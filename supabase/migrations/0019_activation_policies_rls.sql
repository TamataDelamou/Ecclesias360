-- RG-SEC-01/04/05/06/06bis — activation groupée des policies RLS de toutes
-- les tables applicatives, au moment où l'authentification est livrée
-- (0018), comme prévu par AGENTS.md §10 depuis 0004. À partir de cette
-- migration, tout module (re)construit livre ses policies ACTIVES dès
-- l'écriture, jamais commentées.
--
-- Gabarits de bornage (rapport table par table : supabase/tests/0019_rapport_rls.md) :
--   P  périmètre     — public.dans_perimetre(noeud) : nœud d'un mandat actif
--                      (node_responsables) ou descendant (RG-SEC-05) ;
--                      l'administrateur n'est PAS borné (gabarit générique,
--                      seule exception nommée future : Église Sœur, RG-ES-04).
--   O  propriétaire  — ligne du fidèle courant (public.fidele_courant_id()).
--   C  confidentialité relationnelle — appartenance nommée (commission
--                      disciplinaire, comité, trésorier, responsable de
--                      ministère), indépendante du périmètre hiérarchique.
--   R  rôle          — seuil de rang (public.a_role_minimal), jamais seul
--                      pour une donnée rattachée à un nœud, sauf administrateur.
--   G  référentiel global — lecture par tout fidèle enregistré, écriture
--                      administrateur.
-- RG-SEC-06bis : l'utilisateur simple (sans fiche) n'a ni périmètre, ni
-- propriété, ni rang ≥ membre : il ne lit que les contenus publiés de la
-- médiathèque (et leurs commentaires publiés) et son propre compte.
-- Aucune policy pour `anon` : tout accès exige une session.
--
-- Les fonctions ci-dessous sont security definer (search_path durci,
-- références qualifiées) : elles lisent les tables parentes sans repasser
-- par leur RLS — pas de récursion, et elles ne renvoient qu'un identifiant
-- de nœud ou un booléen, jamais une ligne.

-- ---------------------------------------------------------------------
-- Fonctions d'aide
-- ---------------------------------------------------------------------

-- Rang additif des rôles (RG-XXIII-02), miroir de Role/CapacityRules.
create or replace function public.rang_role(p_role text)
returns integer
language sql
immutable
set search_path = pg_catalog, pg_temp
as $$
  select case p_role
    when 'utilisateur_simple' then 0
    when 'membre' then 1
    when 'responsable' then 2
    when 'pasteur' then 3
    when 'administrateur' then 4
  end;
$$;

create or replace function public.a_role_minimal(p_role text)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select coalesce(public.rang_role(public.role_courant()) >= public.rang_role(p_role), false);
$$;

create or replace function public.est_administrateur()
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select coalesce(public.role_courant() = 'administrateur', false);
$$;

create or replace function public.dans_perimetre(p_noeud uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select public.est_administrateur()
      or (p_noeud is not null and p_noeud in (select public.noeuds_du_perimetre()));
$$;

-- Nœud de rattachement du fidèle courant (lecture communautaire : cultes,
-- ministères de son église).
create or replace function public.mon_noeud()
returns uuid
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select noeud_id from public.fideles where auth_user_id = auth.uid();
$$;

create or replace function public.noeud_du_fidele(p_fidele uuid)
returns uuid
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select noeud_id from public.fideles where id = p_fidele;
$$;

-- O ou P : le fidèle courant lui-même, ou un fidèle de son périmètre.
create or replace function public.fidele_accessible(p_fidele uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select p_fidele = public.fidele_courant_id()
      or public.dans_perimetre(public.noeud_du_fidele(p_fidele));
$$;

create or replace function public.est_tresorier(p_noeud uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.tresoriers_noeud t
    where t.noeud_id = p_noeud and t.fidele_id = public.fidele_courant_id()
  );
$$;

create or replace function public.est_membre_comite(p_noeud uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.membres_comite m
    where m.noeud_id = p_noeud and m.fidele_id = public.fidele_courant_id()
  );
$$;

create or replace function public.est_membre_commission(p_commission uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.membres_commission_disciplinaire m
    where m.commission_id = p_commission and m.fidele_id = public.fidele_courant_id()
  );
$$;

-- RG-X-01 : l'appartenance à une commission du nœud habilite à ouvrir un dossier.
create or replace function public.est_membre_commission_du_noeud(p_noeud uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1
    from public.membres_commission_disciplinaire m
    join public.commissions_disciplinaires c on c.id = m.commission_id
    where c.noeud_id = p_noeud and m.fidele_id = public.fidele_courant_id()
  );
$$;

-- Responsable de ministère en fonction (mandat en cours, RG-III-01/02).
create or replace function public.est_responsable_ministere(p_ministere uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.mandats_responsables m
    where m.ministere_id = p_ministere
      and m.fidele_id = public.fidele_courant_id()
      and m.date_fin_reelle is null
  );
$$;

-- Annexe B : le responsable de ministère consulte les dons de ses membres.
create or replace function public.responsable_d_un_ministere_du_fidele(p_fidele uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.affectations_ministeres a
    where a.fidele_id = p_fidele and public.est_responsable_ministere(a.ministere_id)
  );
$$;

create or replace function public.noeud_du_ministere(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.ministeres where id = p_id; $$;

create or replace function public.noeud_de_la_seance(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.seances_comite where id = p_id; $$;

create or replace function public.noeud_de_la_decision(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$
  select s.noeud_id from public.decisions d join public.seances_comite s on s.id = d.seance_id where d.id = p_id;
$$;

create or replace function public.noeud_du_pv(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$
  select s.noeud_id from public.proces_verbaux p join public.seances_comite s on s.id = p.seance_id where p.id = p_id;
$$;

create or replace function public.noeud_du_culte(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.cultes where id = p_id; $$;

create or replace function public.noeud_du_bien(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.biens where id = p_id; $$;

create or replace function public.noeud_de_la_campagne(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.campagnes_inventaire where id = p_id; $$;

create or replace function public.noeud_du_projet(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.projets where id = p_id; $$;

create or replace function public.noeud_de_la_commission(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select noeud_id from public.commissions_disciplinaires where id = p_id; $$;

create or replace function public.fidele_de_l_engagement(p_id uuid) returns uuid
language sql stable security definer set search_path = pg_catalog, pg_temp
as $$ select fidele_id from public.engagements where id = p_id; $$;

-- RG-SEC-06 : lecture d'un dossier disciplinaire — pasteur (ou plus) du
-- périmètre, ou membre de la commission assignée. Jamais le fidèle concerné.
create or replace function public.dossier_disciplinaire_accessible(p_dossier uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.dossiers_disciplinaires d
    where d.id = p_dossier
      and ((public.dans_perimetre(d.noeud_id) and public.a_role_minimal('pasteur'))
           or public.est_membre_commission(d.commission_id))
  );
$$;

-- RG-VIII-03 : un document « restreint » n'est lu que par un pasteur (ou
-- plus) de son périmètre, ou par la commission d'un dossier dont il est une pièce.
create or replace function public.document_archive_accessible(p_document uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.documents_archive d
    where d.id = p_document
      and public.dans_perimetre(d.noeud_id)
      and (d.niveau_confidentialite = 'standard' or public.a_role_minimal('pasteur'))
  ) or exists (
    select 1 from public.pieces_dossier p
    where p.document_archive_id = p_document
      and public.dossier_disciplinaire_accessible(p.dossier_id)
  );
$$;

create or replace function public.contenu_mediatheque_publie(p_contenu uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (select 1 from public.contenus_mediatheque c where c.id = p_contenu and c.statut = 'publie');
$$;

-- RG-XIII-03 : modération par un pasteur (ou plus), ou par le périmètre du nœud éditeur.
create or replace function public.moderateur_du_contenu(p_contenu uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select public.a_role_minimal('pasteur') or exists (
    select 1 from public.contenus_mediatheque c
    where c.id = p_contenu and public.dans_perimetre(c.noeud_editeur_id)
  );
$$;

-- RG-XIII-03 : statut initial imposé par le contenu, jamais choisi par l'auteur.
create or replace function public.statut_initial_commentaire(p_contenu uuid)
returns text
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select case when c.moderation_a_priori then 'en_attente' else 'publie' end
  from public.contenus_mediatheque c where c.id = p_contenu;
$$;

do $$
declare
  f text;
begin
  foreach f in array array[
    'a_role_minimal(text)', 'est_administrateur()', 'dans_perimetre(uuid)', 'mon_noeud()',
    'noeud_du_fidele(uuid)', 'fidele_accessible(uuid)', 'est_tresorier(uuid)', 'est_membre_comite(uuid)',
    'est_membre_commission(uuid)', 'est_membre_commission_du_noeud(uuid)', 'est_responsable_ministere(uuid)',
    'responsable_d_un_ministere_du_fidele(uuid)', 'noeud_du_ministere(uuid)', 'noeud_de_la_seance(uuid)',
    'noeud_de_la_decision(uuid)', 'noeud_du_pv(uuid)', 'noeud_du_culte(uuid)', 'noeud_du_bien(uuid)',
    'noeud_de_la_campagne(uuid)', 'noeud_du_projet(uuid)', 'noeud_de_la_commission(uuid)',
    'fidele_de_l_engagement(uuid)', 'dossier_disciplinaire_accessible(uuid)',
    'document_archive_accessible(uuid)', 'contenu_mediatheque_publie(uuid)', 'moderateur_du_contenu(uuid)',
    'statut_initial_commentaire(uuid)'
  ] loop
    execute format('revoke all on function public.%s from public, anon', f);
    execute format('grant execute on function public.%s to authenticated', f);
  end loop;
end $$;

-- ---------------------------------------------------------------------
-- G — référentiels globaux : lecture fidèle enregistré, écriture administrateur
-- ---------------------------------------------------------------------
do $$
declare
  t text;
begin
  foreach t in array array[
    'zones_geographiques', 'types_ministeres', 'dons_spirituels', 'dons_ministeres_compatibles',
    'professions', 'groupes_eglise', 'nomenclatures_archivage', 'natures_faute', 'types_offrande',
    'categories_bien', 'comptes_comptables'
  ] loop
    execute format('drop policy if exists %1$s_lecture on public.%1$I', t);
    execute format('drop policy if exists %1$s_ecriture on public.%1$I', t);
    execute format($p$create policy %1$s_lecture on public.%1$I for select to authenticated
                     using ((select public.a_role_minimal('membre')))$p$, t);
    execute format($p$create policy %1$s_ecriture on public.%1$I for all to authenticated
                     using ((select public.est_administrateur()))
                     with check ((select public.est_administrateur()))$p$, t);
  end loop;
end $$;

-- RG-XXI-03 : exercices lus par tout fidèle enregistré, ouverts/clôturés par un pasteur ou plus.
drop policy if exists periodes_comptables_lecture on public.periodes_comptables;
drop policy if exists periodes_comptables_ecriture on public.periodes_comptables;
create policy periodes_comptables_lecture on public.periodes_comptables for select to authenticated
  using ((select public.a_role_minimal('membre')));
drop policy if exists periodes_comptables_creation on public.periodes_comptables;
drop policy if exists periodes_comptables_modification on public.periodes_comptables;
create policy periodes_comptables_creation on public.periodes_comptables for insert to authenticated
  with check ((select public.a_role_minimal('pasteur')));
create policy periodes_comptables_modification on public.periodes_comptables for update to authenticated
  using ((select public.a_role_minimal('pasteur')))
  with check ((select public.a_role_minimal('pasteur')));

-- ---------------------------------------------------------------------
-- Module I — Organisation
-- ---------------------------------------------------------------------
drop policy if exists organisation_nodes_lecture on public.organisation_nodes;
drop policy if exists organisation_nodes_creation on public.organisation_nodes;
drop policy if exists organisation_nodes_modification on public.organisation_nodes;
drop policy if exists organisation_nodes_suppression on public.organisation_nodes;
-- Annuaire des Églises (capacité consulter_annuaire_eglises = responsable) :
-- lecture de l'arbre entier dès le rang responsable ; sinon son église.
create policy organisation_nodes_lecture on public.organisation_nodes for select to authenticated
  using (public.dans_perimetre(id) or id = (select public.mon_noeud()) or (select public.a_role_minimal('responsable')));
-- Racine (siège) : administrateur seul ; nœud enfant : dans le périmètre.
create policy organisation_nodes_creation on public.organisation_nodes for insert to authenticated
  with check ((select public.est_administrateur()) or public.dans_perimetre(noeud_parent_id));
create policy organisation_nodes_modification on public.organisation_nodes for update to authenticated
  using (public.dans_perimetre(id))
  with check (public.dans_perimetre(id) and (noeud_parent_id is null or public.dans_perimetre(noeud_parent_id)));
create policy organisation_nodes_suppression on public.organisation_nodes for delete to authenticated
  using ((select public.est_administrateur()));

drop policy if exists historique_rattachements_lecture on public.historique_rattachements;
drop policy if exists historique_rattachements_creation on public.historique_rattachements;
create policy historique_rattachements_lecture on public.historique_rattachements for select to authenticated
  using (public.dans_perimetre(noeud_id));
create policy historique_rattachements_creation on public.historique_rattachements for insert to authenticated
  with check (public.dans_perimetre(noeud_id));

drop policy if exists node_responsables_lecture on public.node_responsables;
drop policy if exists node_responsables_creation on public.node_responsables;
drop policy if exists node_responsables_modification on public.node_responsables;
create policy node_responsables_lecture on public.node_responsables for select to authenticated
  using (public.dans_perimetre(noeud_id) or fidele_id = (select public.fidele_courant_id()));
-- RG-I-05 : désignation par un pasteur (ou plus) du périmètre — jamais au-dessus de son périmètre.
create policy node_responsables_creation on public.node_responsables for insert to authenticated
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));
create policy node_responsables_modification on public.node_responsables for update to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

-- ---------------------------------------------------------------------
-- Module II — Fidèles
-- ---------------------------------------------------------------------
drop policy if exists fideles_lecture on public.fideles;
drop policy if exists fideles_creation on public.fideles;
drop policy if exists fideles_modification on public.fideles;
drop policy if exists fideles_suppression on public.fideles;
create policy fideles_lecture on public.fideles for select to authenticated
  using (auth_user_id = (select auth.uid()) or public.dans_perimetre(noeud_id));
create policy fideles_creation on public.fideles for insert to authenticated
  with check (public.dans_perimetre(noeud_id));
create policy fideles_modification on public.fideles for update to authenticated
  using (public.dans_perimetre(noeud_id))
  with check (public.dans_perimetre(noeud_id));
create policy fideles_suppression on public.fideles for delete to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

drop policy if exists liens_familiaux_acces on public.liens_familiaux;
create policy liens_familiaux_acces on public.liens_familiaux for all to authenticated
  using (public.fidele_accessible(fidele_id1))
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id1)));

drop policy if exists historique_fideles_lecture on public.historique_fideles;
drop policy if exists historique_fideles_creation on public.historique_fideles;
create policy historique_fideles_lecture on public.historique_fideles for select to authenticated
  using (public.fidele_accessible(fidele_id));
create policy historique_fideles_creation on public.historique_fideles for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id)));

drop policy if exists tuteurs_acces on public.tuteurs;
create policy tuteurs_acces on public.tuteurs for all to authenticated
  using (public.fidele_accessible(mineur_id))
  with check (public.dans_perimetre(public.noeud_du_fidele(mineur_id)));

-- ---------------------------------------------------------------------
-- Module III — Ministères
-- ---------------------------------------------------------------------
drop policy if exists ministeres_lecture on public.ministeres;
drop policy if exists ministeres_ecriture on public.ministeres;
create policy ministeres_lecture on public.ministeres for select to authenticated
  using (public.dans_perimetre(noeud_id) or noeud_id = (select public.mon_noeud()) or public.est_responsable_ministere(id));
drop policy if exists ministeres_creation on public.ministeres;
drop policy if exists ministeres_modification on public.ministeres;
create policy ministeres_creation on public.ministeres for insert to authenticated
  with check (public.dans_perimetre(noeud_id));
create policy ministeres_modification on public.ministeres for update to authenticated
  using (public.dans_perimetre(noeud_id))
  with check (public.dans_perimetre(noeud_id));

drop policy if exists affectations_ministeres_lecture on public.affectations_ministeres;
drop policy if exists affectations_ministeres_ecriture on public.affectations_ministeres;
create policy affectations_ministeres_lecture on public.affectations_ministeres for select to authenticated
  using (public.dans_perimetre(public.noeud_du_ministere(ministere_id))
         or public.est_responsable_ministere(ministere_id)
         or fidele_id = (select public.fidele_courant_id()));
drop policy if exists affectations_ministeres_creation on public.affectations_ministeres;
drop policy if exists affectations_ministeres_modification on public.affectations_ministeres;
create policy affectations_ministeres_creation on public.affectations_ministeres for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_ministere(ministere_id)) or public.est_responsable_ministere(ministere_id));
create policy affectations_ministeres_modification on public.affectations_ministeres for update to authenticated
  using (public.dans_perimetre(public.noeud_du_ministere(ministere_id)) or public.est_responsable_ministere(ministere_id))
  with check (public.dans_perimetre(public.noeud_du_ministere(ministere_id)) or public.est_responsable_ministere(ministere_id));

-- Le responsable en fonction lit ses mandats mais ne se désigne jamais lui-même.
drop policy if exists mandats_responsables_lecture on public.mandats_responsables;
drop policy if exists mandats_responsables_ecriture on public.mandats_responsables;
create policy mandats_responsables_lecture on public.mandats_responsables for select to authenticated
  using (public.dans_perimetre(public.noeud_du_ministere(ministere_id)) or fidele_id = (select public.fidele_courant_id()));
drop policy if exists mandats_responsables_creation on public.mandats_responsables;
drop policy if exists mandats_responsables_modification on public.mandats_responsables;
create policy mandats_responsables_creation on public.mandats_responsables for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_ministere(ministere_id)));
create policy mandats_responsables_modification on public.mandats_responsables for update to authenticated
  using (public.dans_perimetre(public.noeud_du_ministere(ministere_id)))
  with check (public.dans_perimetre(public.noeud_du_ministere(ministere_id)));

-- RG-III-05 : journal en ajout seul.
drop policy if exists activites_ministeres_lecture on public.activites_ministeres;
drop policy if exists activites_ministeres_creation on public.activites_ministeres;
create policy activites_ministeres_lecture on public.activites_ministeres for select to authenticated
  using (public.dans_perimetre(public.noeud_du_ministere(ministere_id)) or public.est_responsable_ministere(ministere_id));
create policy activites_ministeres_creation on public.activites_ministeres for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_ministere(ministere_id)) or public.est_responsable_ministere(ministere_id));

-- ---------------------------------------------------------------------
-- Module IV — Dons spirituels (évaluations en ajout seul, RG-IV-01/02)
-- ---------------------------------------------------------------------
drop policy if exists dons_fideles_lecture on public.dons_fideles;
drop policy if exists dons_fideles_creation on public.dons_fideles;
create policy dons_fideles_lecture on public.dons_fideles for select to authenticated
  using (public.fidele_accessible(fidele_id) or public.responsable_d_un_ministere_du_fidele(fidele_id));
create policy dons_fideles_creation on public.dons_fideles for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id)));

-- ---------------------------------------------------------------------
-- Module V — Groupes professionnels
-- ---------------------------------------------------------------------
drop policy if exists professions_fideles_lecture on public.professions_fideles;
drop policy if exists professions_fideles_creation on public.professions_fideles;
drop policy if exists professions_fideles_verification on public.professions_fideles;
create policy professions_fideles_lecture on public.professions_fideles for select to authenticated
  using (public.fidele_accessible(fidele_id));
-- Le fidèle déclare lui-même (statut « déclaré ») ; seul son périmètre vérifie (RG-V-01).
create policy professions_fideles_creation on public.professions_fideles for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id))
              or (fidele_id = (select public.fidele_courant_id()) and statut_verification = 'declare'));
create policy professions_fideles_verification on public.professions_fideles for update to authenticated
  using (public.dans_perimetre(public.noeud_du_fidele(fidele_id)))
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id)));

drop policy if exists sollicitations_lecture on public.sollicitations;
drop policy if exists sollicitations_creation on public.sollicitations;
drop policy if exists sollicitations_reponse on public.sollicitations;
create policy sollicitations_lecture on public.sollicitations for select to authenticated
  using (public.fidele_accessible(fidele_id));
create policy sollicitations_creation on public.sollicitations for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id)));
create policy sollicitations_reponse on public.sollicitations for update to authenticated
  using (public.fidele_accessible(fidele_id))
  with check (public.fidele_accessible(fidele_id));

-- ---------------------------------------------------------------------
-- Module VI — Groupes de l'Église
-- ---------------------------------------------------------------------
drop policy if exists appartenances_groupe_lecture on public.appartenances_groupe;
drop policy if exists appartenances_groupe_ecriture on public.appartenances_groupe;
create policy appartenances_groupe_lecture on public.appartenances_groupe for select to authenticated
  using (public.fidele_accessible(fidele_id));
create policy appartenances_groupe_ecriture on public.appartenances_groupe for all to authenticated
  using (public.dans_perimetre(public.noeud_du_fidele(fidele_id)))
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id)));

-- ---------------------------------------------------------------------
-- Module VII — Comité local (C : membres du comité du nœud)
-- ---------------------------------------------------------------------
drop policy if exists membres_comite_lecture on public.membres_comite;
drop policy if exists membres_comite_ecriture on public.membres_comite;
create policy membres_comite_lecture on public.membres_comite for select to authenticated
  using (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id));
drop policy if exists membres_comite_creation on public.membres_comite;
drop policy if exists membres_comite_modification on public.membres_comite;
create policy membres_comite_creation on public.membres_comite for insert to authenticated
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));
create policy membres_comite_modification on public.membres_comite for update to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

drop policy if exists quorums_comite_lecture on public.quorums_comite;
drop policy if exists quorums_comite_ecriture on public.quorums_comite;
create policy quorums_comite_lecture on public.quorums_comite for select to authenticated
  using (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id));
drop policy if exists quorums_comite_creation on public.quorums_comite;
drop policy if exists quorums_comite_modification on public.quorums_comite;
create policy quorums_comite_creation on public.quorums_comite for insert to authenticated
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));
create policy quorums_comite_modification on public.quorums_comite for update to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

drop policy if exists seances_comite_acces on public.seances_comite;
drop policy if exists seances_comite_lecture on public.seances_comite;
drop policy if exists seances_comite_creation on public.seances_comite;
drop policy if exists seances_comite_modification on public.seances_comite;
create policy seances_comite_lecture on public.seances_comite for select to authenticated
  using (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id));
create policy seances_comite_creation on public.seances_comite for insert to authenticated
  with check (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id));
create policy seances_comite_modification on public.seances_comite for update to authenticated
  using (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id))
  with check (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id));

drop policy if exists presents_seance_acces on public.presents_seance;
drop policy if exists presents_seance_lecture on public.presents_seance;
drop policy if exists presents_seance_creation on public.presents_seance;
drop policy if exists presents_seance_modification on public.presents_seance;
create policy presents_seance_lecture on public.presents_seance for select to authenticated
  using (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));
create policy presents_seance_creation on public.presents_seance for insert to authenticated
  with check (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));
create policy presents_seance_modification on public.presents_seance for update to authenticated
  using (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)))
  with check (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));

drop policy if exists decisions_lecture on public.decisions;
drop policy if exists decisions_creation on public.decisions;
drop policy if exists decisions_modification on public.decisions;
create policy decisions_lecture on public.decisions for select to authenticated
  using (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));
create policy decisions_creation on public.decisions for insert to authenticated
  with check (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));
create policy decisions_modification on public.decisions for update to authenticated
  using (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)))
  with check (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));

-- RG-VII-02 : un PV validé n'est plus jamais modifié (correction par erratum).
drop policy if exists proces_verbaux_lecture on public.proces_verbaux;
drop policy if exists proces_verbaux_creation on public.proces_verbaux;
drop policy if exists proces_verbaux_modification on public.proces_verbaux;
create policy proces_verbaux_lecture on public.proces_verbaux for select to authenticated
  using (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));
create policy proces_verbaux_creation on public.proces_verbaux for insert to authenticated
  with check (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));
create policy proces_verbaux_modification on public.proces_verbaux for update to authenticated
  using (statut = 'brouillon'
         and (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id))))
  with check (public.dans_perimetre(public.noeud_de_la_seance(seance_id)) or public.est_membre_comite(public.noeud_de_la_seance(seance_id)));

drop policy if exists erratums_pv_lecture on public.erratums_pv;
drop policy if exists erratums_pv_creation on public.erratums_pv;
create policy erratums_pv_lecture on public.erratums_pv for select to authenticated
  using (public.dans_perimetre(public.noeud_du_pv(proces_verbal_id)) or public.est_membre_comite(public.noeud_du_pv(proces_verbal_id)));
create policy erratums_pv_creation on public.erratums_pv for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_pv(proces_verbal_id)) or public.est_membre_comite(public.noeud_du_pv(proces_verbal_id)));

drop policy if exists taches_suivi_lecture on public.taches_suivi;
drop policy if exists taches_suivi_creation on public.taches_suivi;
drop policy if exists taches_suivi_modification on public.taches_suivi;
create policy taches_suivi_lecture on public.taches_suivi for select to authenticated
  using (public.dans_perimetre(public.noeud_de_la_decision(decision_id))
         or public.est_membre_comite(public.noeud_de_la_decision(decision_id))
         or assigne_fidele_id = (select public.fidele_courant_id()));
create policy taches_suivi_creation on public.taches_suivi for insert to authenticated
  with check (public.dans_perimetre(public.noeud_de_la_decision(decision_id)) or public.est_membre_comite(public.noeud_de_la_decision(decision_id)));
-- La personne assignée marque sa tâche faite.
create policy taches_suivi_modification on public.taches_suivi for update to authenticated
  using (public.dans_perimetre(public.noeud_de_la_decision(decision_id))
         or public.est_membre_comite(public.noeud_de_la_decision(decision_id))
         or assigne_fidele_id = (select public.fidele_courant_id()))
  with check (public.dans_perimetre(public.noeud_de_la_decision(decision_id))
              or public.est_membre_comite(public.noeud_de_la_decision(decision_id))
              or assigne_fidele_id = (select public.fidele_courant_id()));

-- ---------------------------------------------------------------------
-- Module XII — Cultes (lecture communautaire : les fidèles de l'église)
-- ---------------------------------------------------------------------
drop policy if exists cultes_lecture on public.cultes;
drop policy if exists cultes_ecriture on public.cultes;
create policy cultes_lecture on public.cultes for select to authenticated
  using (public.dans_perimetre(noeud_id) or noeud_id = (select public.mon_noeud()));
drop policy if exists cultes_creation on public.cultes;
drop policy if exists cultes_modification on public.cultes;
create policy cultes_creation on public.cultes for insert to authenticated
  with check (public.dans_perimetre(noeud_id));
create policy cultes_modification on public.cultes for update to authenticated
  using (public.dans_perimetre(noeud_id))
  with check (public.dans_perimetre(noeud_id));

drop policy if exists sequences_liturgiques_lecture on public.sequences_liturgiques;
drop policy if exists sequences_liturgiques_ecriture on public.sequences_liturgiques;
create policy sequences_liturgiques_lecture on public.sequences_liturgiques for select to authenticated
  using (public.dans_perimetre(public.noeud_du_culte(culte_id)) or public.noeud_du_culte(culte_id) = (select public.mon_noeud()));
create policy sequences_liturgiques_ecriture on public.sequences_liturgiques for all to authenticated
  using (public.dans_perimetre(public.noeud_du_culte(culte_id)))
  with check (public.dans_perimetre(public.noeud_du_culte(culte_id)));

drop policy if exists presences_culte_lecture on public.presences_culte;
drop policy if exists presences_culte_ecriture on public.presences_culte;
create policy presences_culte_lecture on public.presences_culte for select to authenticated
  using (public.dans_perimetre(public.noeud_du_culte(culte_id)) or fidele_id = (select public.fidele_courant_id()));
create policy presences_culte_ecriture on public.presences_culte for all to authenticated
  using (public.dans_perimetre(public.noeud_du_culte(culte_id)))
  with check (public.dans_perimetre(public.noeud_du_culte(culte_id)));

drop policy if exists publications_culte_lecture on public.publications_culte;
drop policy if exists publications_culte_ecriture on public.publications_culte;
create policy publications_culte_lecture on public.publications_culte for select to authenticated
  using (public.dans_perimetre(public.noeud_du_culte(culte_id)) or public.noeud_du_culte(culte_id) = (select public.mon_noeud()));
drop policy if exists publications_culte_creation on public.publications_culte;
drop policy if exists publications_culte_modification on public.publications_culte;
create policy publications_culte_creation on public.publications_culte for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_culte(culte_id)));
create policy publications_culte_modification on public.publications_culte for update to authenticated
  using (public.dans_perimetre(public.noeud_du_culte(culte_id)))
  with check (public.dans_perimetre(public.noeud_du_culte(culte_id)));

-- RG-XII-06 : propositions et votes ouverts à tout fidèle enregistré, en son nom seul.
drop policy if exists propositions_theme_lecture on public.propositions_theme;
drop policy if exists propositions_theme_creation on public.propositions_theme;
drop policy if exists propositions_theme_modification on public.propositions_theme;
create policy propositions_theme_lecture on public.propositions_theme for select to authenticated
  using ((select public.a_role_minimal('membre')));
create policy propositions_theme_creation on public.propositions_theme for insert to authenticated
  with check ((select public.a_role_minimal('membre')) and fidele_id = (select public.fidele_courant_id()));
create policy propositions_theme_modification on public.propositions_theme for update to authenticated
  using ((select public.a_role_minimal('pasteur')))
  with check ((select public.a_role_minimal('pasteur')));

drop policy if exists votes_proposition_lecture on public.votes_proposition;
drop policy if exists votes_proposition_creation on public.votes_proposition;
create policy votes_proposition_lecture on public.votes_proposition for select to authenticated
  using ((select public.a_role_minimal('membre')));
create policy votes_proposition_creation on public.votes_proposition for insert to authenticated
  with check ((select public.a_role_minimal('membre')) and fidele_id = (select public.fidele_courant_id()));

-- ---------------------------------------------------------------------
-- Module VIII — Archivage (RG-VIII-03 : niveau « restreint »)
-- ---------------------------------------------------------------------
drop policy if exists documents_archive_lecture on public.documents_archive;
drop policy if exists documents_archive_creation on public.documents_archive;
drop policy if exists documents_archive_modification on public.documents_archive;
drop policy if exists documents_archive_purge on public.documents_archive;
create policy documents_archive_lecture on public.documents_archive for select to authenticated
  using (public.document_archive_accessible(id));
-- Producteurs : périmètre, comité (PV, RG-VII-03), commission (pièces, RG-X-06).
create policy documents_archive_creation on public.documents_archive for insert to authenticated
  with check (public.dans_perimetre(noeud_id) or public.est_membre_comite(noeud_id) or public.est_membre_commission_du_noeud(noeud_id));
create policy documents_archive_modification on public.documents_archive for update to authenticated
  using (public.dans_perimetre(noeud_id) and public.document_archive_accessible(id))
  with check (public.dans_perimetre(noeud_id));
-- RG-VIII-05 : purge définitive réservée à un pasteur (ou plus) du périmètre.
create policy documents_archive_purge on public.documents_archive for delete to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

drop policy if exists versions_document_lecture on public.versions_document;
drop policy if exists versions_document_creation on public.versions_document;
drop policy if exists versions_document_purge on public.versions_document;
create policy versions_document_lecture on public.versions_document for select to authenticated
  using (public.document_archive_accessible(document_id));
create policy versions_document_creation on public.versions_document for insert to authenticated
  with check (exists (select 1 from public.documents_archive d where d.id = document_id));
create policy versions_document_purge on public.versions_document for delete to authenticated
  using (exists (select 1 from public.documents_archive d
                 where d.id = document_id and public.dans_perimetre(d.noeud_id) and public.a_role_minimal('pasteur')));

-- ---------------------------------------------------------------------
-- Module IX — Déplacements (les deux périmètres, origine et destination)
-- ---------------------------------------------------------------------
drop policy if exists mutations_lecture on public.mutations;
drop policy if exists mutations_creation on public.mutations;
drop policy if exists mutations_validation on public.mutations;
create policy mutations_lecture on public.mutations for select to authenticated
  using (public.dans_perimetre(noeud_origine_id) or public.dans_perimetre(noeud_destination_id)
         or fidele_id = (select public.fidele_courant_id()));
create policy mutations_creation on public.mutations for insert to authenticated
  with check (public.dans_perimetre(noeud_origine_id) or public.dans_perimetre(noeud_destination_id));
create policy mutations_validation on public.mutations for update to authenticated
  using (public.dans_perimetre(noeud_origine_id) or public.dans_perimetre(noeud_destination_id))
  with check (public.dans_perimetre(noeud_origine_id) or public.dans_perimetre(noeud_destination_id));

drop policy if exists lettres_recommandation_lecture on public.lettres_recommandation;
drop policy if exists lettres_recommandation_creation on public.lettres_recommandation;
create policy lettres_recommandation_lecture on public.lettres_recommandation for select to authenticated
  using (exists (select 1 from public.mutations m where m.id = mutation_id));
create policy lettres_recommandation_creation on public.lettres_recommandation for insert to authenticated
  with check (exists (select 1 from public.mutations m where m.id = mutation_id
                      and (public.dans_perimetre(m.noeud_origine_id) or public.dans_perimetre(m.noeud_destination_id))));

-- ---------------------------------------------------------------------
-- Module X — Discipline (RG-SEC-06 : confidentialité renforcée)
-- ---------------------------------------------------------------------
drop policy if exists commissions_disciplinaires_lecture on public.commissions_disciplinaires;
drop policy if exists commissions_disciplinaires_ecriture on public.commissions_disciplinaires;
create policy commissions_disciplinaires_lecture on public.commissions_disciplinaires for select to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_membre_commission(id));
drop policy if exists commissions_disciplinaires_creation on public.commissions_disciplinaires;
drop policy if exists commissions_disciplinaires_modification on public.commissions_disciplinaires;
create policy commissions_disciplinaires_creation on public.commissions_disciplinaires for insert to authenticated
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));
create policy commissions_disciplinaires_modification on public.commissions_disciplinaires for update to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

drop policy if exists membres_commission_disciplinaire_lecture on public.membres_commission_disciplinaire;
drop policy if exists membres_commission_disciplinaire_ecriture on public.membres_commission_disciplinaire;
create policy membres_commission_disciplinaire_lecture on public.membres_commission_disciplinaire for select to authenticated
  using ((public.dans_perimetre(public.noeud_de_la_commission(commission_id)) and (select public.a_role_minimal('pasteur')))
         or public.est_membre_commission(commission_id));
create policy membres_commission_disciplinaire_ecriture on public.membres_commission_disciplinaire for all to authenticated
  using (public.dans_perimetre(public.noeud_de_la_commission(commission_id)) and (select public.a_role_minimal('pasteur')))
  with check (public.dans_perimetre(public.noeud_de_la_commission(commission_id)) and (select public.a_role_minimal('pasteur')));

-- Jamais lisible par le fidèle concerné lui-même (aucune branche O).
drop policy if exists dossiers_disciplinaires_lecture on public.dossiers_disciplinaires;
drop policy if exists dossiers_disciplinaires_ouverture on public.dossiers_disciplinaires;
drop policy if exists dossiers_disciplinaires_instruction on public.dossiers_disciplinaires;
create policy dossiers_disciplinaires_lecture on public.dossiers_disciplinaires for select to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_membre_commission(commission_id));
-- RG-X-01 : ouverture par un pasteur (ou plus) du périmètre, ou par un membre d'une commission du nœud.
create policy dossiers_disciplinaires_ouverture on public.dossiers_disciplinaires for insert to authenticated
  with check ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_membre_commission_du_noeud(noeud_id));
create policy dossiers_disciplinaires_instruction on public.dossiers_disciplinaires for update to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_membre_commission(commission_id))
  with check ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
              or public.est_membre_commission(commission_id) or public.est_membre_commission_du_noeud(noeud_id));

drop policy if exists pieces_dossier_lecture on public.pieces_dossier;
drop policy if exists pieces_dossier_creation on public.pieces_dossier;
create policy pieces_dossier_lecture on public.pieces_dossier for select to authenticated
  using (public.dossier_disciplinaire_accessible(dossier_id));
create policy pieces_dossier_creation on public.pieces_dossier for insert to authenticated
  with check (public.dossier_disciplinaire_accessible(dossier_id));

-- ---------------------------------------------------------------------
-- Module XI — Finances (RG-SEC-06 : pasteur du périmètre, trésorier du nœud, ou le donateur)
-- ---------------------------------------------------------------------
drop policy if exists tresoriers_noeud_lecture on public.tresoriers_noeud;
drop policy if exists tresoriers_noeud_ecriture on public.tresoriers_noeud;
create policy tresoriers_noeud_lecture on public.tresoriers_noeud for select to authenticated
  using (public.dans_perimetre(noeud_id) or fidele_id = (select public.fidele_courant_id()));
drop policy if exists tresoriers_noeud_creation on public.tresoriers_noeud;
drop policy if exists tresoriers_noeud_modification on public.tresoriers_noeud;
create policy tresoriers_noeud_creation on public.tresoriers_noeud for insert to authenticated
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));
create policy tresoriers_noeud_modification on public.tresoriers_noeud for update to authenticated
  using (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
  with check (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')));

drop policy if exists contributions_lecture on public.contributions;
drop policy if exists contributions_saisie on public.contributions;
drop policy if exists contributions_validation on public.contributions;
create policy contributions_lecture on public.contributions for select to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
         or public.est_tresorier(noeud_id)
         or fidele_id = (select public.fidele_courant_id()));
-- Saisie personnelle (Annexe B) ou déléguée par le périmètre (secrétaire), toujours en attente.
create policy contributions_saisie on public.contributions for insert to authenticated
  with check (
    (statut = 'en_attente'
     and (fidele_id = (select public.fidele_courant_id()) or public.dans_perimetre(noeud_id) or public.est_tresorier(noeud_id)))
    -- RG-XI-05 : contre-passation créée directement validée par un valideur habilité.
    or (public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur')))
    or public.est_tresorier(noeud_id));
-- RG-XI-02 : validation/rejet par un pasteur (ou plus) du périmètre ou un trésorier du nœud.
-- RG-XI-05 : une contribution validée ou rejetée n'est plus jamais modifiée
-- (correction par contre-passation, une nouvelle ligne).
create policy contributions_validation on public.contributions for update to authenticated
  using (statut = 'en_attente'
         and ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id)))
  with check ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id));

drop policy if exists projets_acces on public.projets;
drop policy if exists projets_lecture on public.projets;
drop policy if exists projets_creation on public.projets;
drop policy if exists projets_modification on public.projets;
create policy projets_lecture on public.projets for select to authenticated
  using (public.dans_perimetre(noeud_id) or public.est_tresorier(noeud_id));
create policy projets_creation on public.projets for insert to authenticated
  with check (public.dans_perimetre(noeud_id) or public.est_tresorier(noeud_id));
create policy projets_modification on public.projets for update to authenticated
  using (public.dans_perimetre(noeud_id) or public.est_tresorier(noeud_id))
  with check (public.dans_perimetre(noeud_id) or public.est_tresorier(noeud_id));

drop policy if exists depenses_projet_lecture on public.depenses_projet;
drop policy if exists depenses_projet_creation on public.depenses_projet;
create policy depenses_projet_lecture on public.depenses_projet for select to authenticated
  using (public.dans_perimetre(public.noeud_du_projet(projet_id)) or public.est_tresorier(public.noeud_du_projet(projet_id)));
create policy depenses_projet_creation on public.depenses_projet for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_projet(projet_id)) or public.est_tresorier(public.noeud_du_projet(projet_id)));

drop policy if exists engagements_acces on public.engagements;
drop policy if exists engagements_lecture on public.engagements;
drop policy if exists engagements_creation on public.engagements;
drop policy if exists engagements_modification on public.engagements;
create policy engagements_lecture on public.engagements for select to authenticated
  using (fidele_id = (select public.fidele_courant_id())
         or (public.dans_perimetre(public.noeud_du_fidele(fidele_id)) and (select public.a_role_minimal('pasteur')))
         or public.est_tresorier(public.noeud_du_fidele(fidele_id)));
create policy engagements_creation on public.engagements for insert to authenticated
  with check (fidele_id = (select public.fidele_courant_id())
              or (public.dans_perimetre(public.noeud_du_fidele(fidele_id)) and (select public.a_role_minimal('pasteur')))
              or public.est_tresorier(public.noeud_du_fidele(fidele_id)));
create policy engagements_modification on public.engagements for update to authenticated
  using (fidele_id = (select public.fidele_courant_id())
         or (public.dans_perimetre(public.noeud_du_fidele(fidele_id)) and (select public.a_role_minimal('pasteur')))
         or public.est_tresorier(public.noeud_du_fidele(fidele_id)))
  with check (fidele_id = (select public.fidele_courant_id())
              or (public.dans_perimetre(public.noeud_du_fidele(fidele_id)) and (select public.a_role_minimal('pasteur')))
              or public.est_tresorier(public.noeud_du_fidele(fidele_id)));

drop policy if exists echeances_engagement_acces on public.echeances_engagement;
drop policy if exists echeances_engagement_lecture on public.echeances_engagement;
drop policy if exists echeances_engagement_creation on public.echeances_engagement;
drop policy if exists echeances_engagement_modification on public.echeances_engagement;
create policy echeances_engagement_lecture on public.echeances_engagement for select to authenticated
  using (exists (select 1 from public.engagements e where e.id = engagement_id));
create policy echeances_engagement_creation on public.echeances_engagement for insert to authenticated
  with check (exists (select 1 from public.engagements e where e.id = engagement_id));
create policy echeances_engagement_modification on public.echeances_engagement for update to authenticated
  using (exists (select 1 from public.engagements e where e.id = engagement_id))
  with check (exists (select 1 from public.engagements e where e.id = engagement_id));

-- ---------------------------------------------------------------------
-- Module XX — Biens
-- ---------------------------------------------------------------------
drop policy if exists biens_acces on public.biens;
drop policy if exists biens_lecture on public.biens;
drop policy if exists biens_creation on public.biens;
drop policy if exists biens_modification on public.biens;
create policy biens_lecture on public.biens for select to authenticated
  using (public.dans_perimetre(noeud_id));
create policy biens_creation on public.biens for insert to authenticated
  with check (public.dans_perimetre(noeud_id));
create policy biens_modification on public.biens for update to authenticated
  using (public.dans_perimetre(noeud_id))
  with check (public.dans_perimetre(noeud_id));

drop policy if exists reservations_bien_acces on public.reservations_bien;
drop policy if exists reservations_bien_lecture on public.reservations_bien;
drop policy if exists reservations_bien_creation on public.reservations_bien;
drop policy if exists reservations_bien_modification on public.reservations_bien;
create policy reservations_bien_lecture on public.reservations_bien for select to authenticated
  using (public.dans_perimetre(public.noeud_du_bien(bien_id)));
create policy reservations_bien_creation on public.reservations_bien for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_bien(bien_id)));
create policy reservations_bien_modification on public.reservations_bien for update to authenticated
  using (public.dans_perimetre(public.noeud_du_bien(bien_id)))
  with check (public.dans_perimetre(public.noeud_du_bien(bien_id)));

drop policy if exists mouvements_stock_lecture on public.mouvements_stock;
drop policy if exists mouvements_stock_creation on public.mouvements_stock;
create policy mouvements_stock_lecture on public.mouvements_stock for select to authenticated
  using (public.dans_perimetre(public.noeud_du_bien(bien_id)));
create policy mouvements_stock_creation on public.mouvements_stock for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_bien(bien_id)));

drop policy if exists campagnes_inventaire_acces on public.campagnes_inventaire;
drop policy if exists campagnes_inventaire_lecture on public.campagnes_inventaire;
drop policy if exists campagnes_inventaire_creation on public.campagnes_inventaire;
drop policy if exists campagnes_inventaire_modification on public.campagnes_inventaire;
create policy campagnes_inventaire_lecture on public.campagnes_inventaire for select to authenticated
  using (public.dans_perimetre(noeud_id));
create policy campagnes_inventaire_creation on public.campagnes_inventaire for insert to authenticated
  with check (public.dans_perimetre(noeud_id));
create policy campagnes_inventaire_modification on public.campagnes_inventaire for update to authenticated
  using (public.dans_perimetre(noeud_id))
  with check (public.dans_perimetre(noeud_id));

drop policy if exists pointages_inventaire_lecture on public.pointages_inventaire;
drop policy if exists pointages_inventaire_creation on public.pointages_inventaire;
create policy pointages_inventaire_lecture on public.pointages_inventaire for select to authenticated
  using (public.dans_perimetre(public.noeud_de_la_campagne(campagne_id)));
create policy pointages_inventaire_creation on public.pointages_inventaire for insert to authenticated
  with check (public.dans_perimetre(public.noeud_de_la_campagne(campagne_id)));

-- ---------------------------------------------------------------------
-- Module XXI — Comptabilité (RG-SEC-06 : pasteur du périmètre ou trésorier du nœud)
-- ---------------------------------------------------------------------
drop policy if exists ecritures_comptables_lecture on public.ecritures_comptables;
drop policy if exists ecritures_comptables_creation on public.ecritures_comptables;
drop policy if exists ecritures_comptables_rapprochement on public.ecritures_comptables;
create policy ecritures_comptables_lecture on public.ecritures_comptables for select to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id));
-- RG-XXI-03 : aucune écriture dans une période clôturée.
create policy ecritures_comptables_creation on public.ecritures_comptables for insert to authenticated
  with check (((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id))
              and not exists (select 1 from public.periodes_comptables p where p.id = periode_id and p.statut = 'cloturee'));
-- RG-XXI-03/05 : une écriture est immuable ; seul son drapeau de rapprochement
-- change (privilège de colonne ci-dessous, la RLS ne bornant que les lignes).
create policy ecritures_comptables_rapprochement on public.ecritures_comptables for update to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id))
  with check ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id));

revoke update on public.ecritures_comptables from anon, authenticated;
grant update (rapproche) on public.ecritures_comptables to authenticated;

drop policy if exists budgets_acces on public.budgets;
drop policy if exists budgets_lecture on public.budgets;
drop policy if exists budgets_creation on public.budgets;
drop policy if exists budgets_modification on public.budgets;
create policy budgets_lecture on public.budgets for select to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id));
create policy budgets_creation on public.budgets for insert to authenticated
  with check ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id));
create policy budgets_modification on public.budgets for update to authenticated
  using ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id))
  with check ((public.dans_perimetre(noeud_id) and (select public.a_role_minimal('pasteur'))) or public.est_tresorier(noeud_id));

-- ---------------------------------------------------------------------
-- Module XIII — Médiathèque (seul module ouvert à l'utilisateur simple, en lecture)
-- ---------------------------------------------------------------------
drop policy if exists contenus_mediatheque_lecture on public.contenus_mediatheque;
drop policy if exists contenus_mediatheque_ecriture on public.contenus_mediatheque;
create policy contenus_mediatheque_lecture on public.contenus_mediatheque for select to authenticated
  using (statut = 'publie' or public.dans_perimetre(noeud_editeur_id));
drop policy if exists contenus_mediatheque_creation on public.contenus_mediatheque;
drop policy if exists contenus_mediatheque_modification on public.contenus_mediatheque;
create policy contenus_mediatheque_creation on public.contenus_mediatheque for insert to authenticated
  with check (public.dans_perimetre(noeud_editeur_id));
create policy contenus_mediatheque_modification on public.contenus_mediatheque for update to authenticated
  using (public.dans_perimetre(noeud_editeur_id))
  with check (public.dans_perimetre(noeud_editeur_id));

drop policy if exists favoris_proprietaire on public.favoris;
create policy favoris_proprietaire on public.favoris for all to authenticated
  using (fidele_id = (select public.fidele_courant_id()))
  with check (fidele_id = (select public.fidele_courant_id()) and (select public.a_role_minimal('membre')));

drop policy if exists commentaires_lecture on public.commentaires;
drop policy if exists commentaires_creation on public.commentaires;
drop policy if exists commentaires_moderation on public.commentaires;
create policy commentaires_lecture on public.commentaires for select to authenticated
  using ((statut_moderation = 'publie' and public.contenu_mediatheque_publie(contenu_id))
         or fidele_id = (select public.fidele_courant_id())
         or public.moderateur_du_contenu(contenu_id));
-- Statut initial imposé par le contenu (modération a priori ou a posteriori), jamais par l'auteur.
create policy commentaires_creation on public.commentaires for insert to authenticated
  with check ((select public.a_role_minimal('membre'))
              and fidele_id = (select public.fidele_courant_id())
              and public.contenu_mediatheque_publie(contenu_id)
              and statut_moderation = public.statut_initial_commentaire(contenu_id)
              and nombre_signalements = 0);
create policy commentaires_moderation on public.commentaires for update to authenticated
  using (public.moderateur_du_contenu(contenu_id))
  with check (public.moderateur_du_contenu(contenu_id));

-- ---------------------------------------------------------------------
-- RG-SEC-01 — comptes et journal des liaisons (écriture par fonctions 0018 seulement)
-- ---------------------------------------------------------------------
drop policy if exists comptes_utilisateurs_lecture on public.comptes_utilisateurs;
create policy comptes_utilisateurs_lecture on public.comptes_utilisateurs for select to authenticated
  using (auth_user_id = (select auth.uid()) or (select public.est_administrateur()));

drop policy if exists journal_liaisons_comptes_lecture on public.journal_liaisons_comptes;
create policy journal_liaisons_comptes_lecture on public.journal_liaisons_comptes for select to authenticated
  using ((select public.est_administrateur()));
