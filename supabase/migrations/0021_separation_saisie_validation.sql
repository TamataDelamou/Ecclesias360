-- RG-XI-02 / RG-SEC-06 — séparation stricte des tâches saisie/validation
-- en matière financière. Jusqu'ici l'auteur de la saisie d'une contribution
-- n'était tracé nulle part : la même personne pouvait saisir puis valider.
--
-- Miroir SQL de `FinancesRules.raisonBlocageSeparationTaches` (Dart).
-- Conséquence assumée (voir AGENTS.md, Module XI) : un site ne comptant
-- qu'une seule personne habilitée voit ses propres saisies attendre une
-- seconde personne habilitée — comportement correct, pas un défaut.
-- L'administrateur n'y fait pas exception.

alter table public.contributions
  add column if not exists saisie_par_fidele_id uuid references public.fideles(id) on delete set null;

-- La saisie trace toujours son auteur réel (la fiche liée à la session) :
-- un compte sans fiche ne saisit pas, un auteur ne s'attribue pas à autrui.
drop policy if exists contributions_saisie on public.contributions;
create policy contributions_saisie on public.contributions for insert to authenticated
  with check (
    saisie_par_fidele_id = (select public.fidele_courant_id())
    and (
      (statut = 'en_attente'
       and (fidele_id = (select public.fidele_courant_id()) or public.dans_perimetre(noeud_id) or public.est_tresorier(noeud_id)))
      -- RG-XI-05 : contre-passation créée directement validée par son valideur, qui en est l'auteur.
      or (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
      or public.est_tresorier(noeud_id)
    ));

-- Décision (validation ou rejet) : habilitée, depuis « en attente », tracée
-- au nom du décideur réel, et jamais par l'auteur de la saisie.
drop policy if exists contributions_validation on public.contributions;
create policy contributions_validation on public.contributions for update to authenticated
  using (statut = 'en_attente'
         and saisie_par_fidele_id is distinct from (select public.fidele_courant_id())
         and ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id)))
  with check (valide_par_fidele_id = (select public.fidele_courant_id())
              and saisie_par_fidele_id is distinct from (select public.fidele_courant_id())
              and ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id)));

-- Une décision ne réécrit que la décision : ni le montant, ni le donateur,
-- ni l'auteur de la saisie (la RLS ne borne que les lignes).
revoke update on public.contributions from anon, authenticated;
grant update (statut, valide_par_fidele_id, date_validation, motif_rejet) on public.contributions to authenticated;
