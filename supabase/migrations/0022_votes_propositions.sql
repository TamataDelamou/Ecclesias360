-- RG-XII-06 — « Les autres fidèles votent » sur une proposition de thème :
-- son auteur ne vote jamais sur la sienne. Et un fidèle peut revenir sur son
-- propre vote (comportement de `CulteRepository.voter`), ce que 0019 (ajout
-- seul) ne reflétait pas.
--
-- Miroir SQL de `CulteRules.raisonBlocageVote` (Dart).

create or replace function public.auteur_de_la_proposition(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select fidele_id from public.propositions_theme where id = p_id; $$;

revoke all on function public.auteur_de_la_proposition(uuid) from public, anon;
grant execute on function public.auteur_de_la_proposition(uuid) to authenticated;

drop policy if exists votes_proposition_creation on public.votes_proposition;
create policy votes_proposition_creation on public.votes_proposition for insert to authenticated
  with check ((select public.a_role_minimal('membre'))
              and fidele_id = (select public.fidele_courant_id())
              and public.auteur_de_la_proposition(proposition_id) is distinct from (select public.fidele_courant_id()));

-- Changer son propre vote (jamais celui d'autrui, jamais vers sa propre proposition).
drop policy if exists votes_proposition_modification on public.votes_proposition;
create policy votes_proposition_modification on public.votes_proposition for update to authenticated
  using (fidele_id = (select public.fidele_courant_id()))
  with check (fidele_id = (select public.fidele_courant_id())
              and public.auteur_de_la_proposition(proposition_id) is distinct from (select public.fidele_courant_id()));

-- Seule la valeur du vote change.
revoke update on public.votes_proposition from anon, authenticated;
grant update (valeur) on public.votes_proposition to authenticated;
