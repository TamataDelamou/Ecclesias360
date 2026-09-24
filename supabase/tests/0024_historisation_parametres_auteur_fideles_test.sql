-- Vérification par exécution réelle de 0024_historisation_parametres_auteur_fideles.sql,
-- contre la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0024_historisation_parametres_auteur_fideles_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.
--
-- Profils : A administrateur, P pasteur du siège (mandat), M simple membre.

begin;

insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-c20000000001', 'admin24@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-c20000000002', 'pasteur24@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-c20000000003', 'membre24@test.local', 'authenticated', 'authenticated');

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
  ('00000000-0000-4000-8000-c21000000001', 'siege', 'Siège', 'T24-S', null, '/00000000-0000-4000-8000-c21000000001/');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id) values
  ('00000000-0000-4000-8000-c22000000001', '00000000-0000-4000-8000-c21000000001', 'Admin', 'A', '1970-01-01', 'masculin', 'marie', 'administrateur', '00000000-0000-4000-8000-c20000000001'),
  ('00000000-0000-4000-8000-c22000000002', '00000000-0000-4000-8000-c21000000001', 'Pasteur', 'P', '1975-01-01', 'feminin', 'marie', 'pasteur', '00000000-0000-4000-8000-c20000000002'),
  ('00000000-0000-4000-8000-c22000000003', '00000000-0000-4000-8000-c21000000001', 'Membre', 'M', '1980-01-01', 'masculin', 'marie', 'membre', '00000000-0000-4000-8000-c20000000003');

insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
  (gen_random_uuid(), '00000000-0000-4000-8000-c21000000001', '00000000-0000-4000-8000-c22000000002', 'pasteur');

create or replace function pg_temp.connecter(p_uid uuid) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', json_build_object('sub', p_uid, 'role', 'authenticated')::text, true);
  perform set_config('role', 'authenticated', true);
end $$;

create or replace function pg_temp.refuse(p_sql text) returns boolean language plpgsql as $$
begin
  execute p_sql;
  return false;
exception when insufficient_privilege then
  return true;
end $$;

create or replace function pg_temp.touche(p_sql text) returns bigint language plpgsql as $$
declare n bigint;
begin
  execute p_sql;
  get diagnostics n = row_count;
  return n;
end $$;

-- 0. Les données de départ des référentiels (migrations antérieures) ne sont pas journalisées.
do $$ begin
  assert (select count(*) from public.journal_parametres) = 0, 'journal vide au départ';
end $$;

-- 1. L'administrateur crée, désactive puis supprime une zone : trois traces.
select pg_temp.connecter('00000000-0000-4000-8000-c20000000001');
do $$ begin
  assert not pg_temp.refuse($q$insert into public.zones_geographiques (id, libelle, niveau, statut)
    values ('00000000-0000-4000-8000-c23000000001', 'Togo', 0, 'actif')$q$), 'admin : crée une zone';
  assert pg_temp.touche($q$update public.zones_geographiques set statut = 'desactive'
    where id = '00000000-0000-4000-8000-c23000000001'$q$) = 1, 'admin : désactive';
  assert pg_temp.touche($q$delete from public.zones_geographiques
    where id = '00000000-0000-4000-8000-c23000000001'$q$) = 1, 'admin : supprime';
  -- Un autre référentiel est couvert par le même déclencheur.
  assert pg_temp.touche($q$update public.types_offrande set libelle = libelle || ' (modifié)'
    where id = (select id from public.types_offrande order by code limit 1)$q$) = 1, 'admin : modifie un type d''offrande';
  assert (select count(*) from public.journal_parametres) = 4, 'admin : lit les 4 traces';
end $$;
select set_config('role', 'postgres', true);

do $$
declare
  creation record;
  desactivation record;
  suppression record;
begin
  select * into creation from public.journal_parametres where referentiel = 'zones_geographiques' and action = 'insert';
  select * into desactivation from public.journal_parametres where referentiel = 'zones_geographiques' and action = 'update';
  select * into suppression from public.journal_parametres where referentiel = 'zones_geographiques' and action = 'delete';
  assert creation.objet_id = '00000000-0000-4000-8000-c23000000001', 'objet tracé';
  assert creation.auteur_auth_user_id = '00000000-0000-4000-8000-c20000000001', 'auteur : compte réel';
  assert creation.auteur_fidele_id = '00000000-0000-4000-8000-c22000000001', 'auteur : fiche liée';
  assert creation.ancienne_valeur is null and creation.nouvelle_valeur ->> 'statut' = 'actif', 'création : valeur';
  assert desactivation.ancienne_valeur ->> 'statut' = 'actif', 'modification : valeur précédente';
  assert desactivation.nouvelle_valeur ->> 'statut' = 'desactive', 'modification : nouvelle valeur';
  assert suppression.ancienne_valeur ->> 'libelle' = 'Togo' and suppression.nouvelle_valeur is null, 'suppression : valeur précédente';
  assert exists (select 1 from public.journal_parametres where referentiel = 'types_offrande'), 'types d''offrande couverts';
end $$;

-- 2. L'administrateur ne réécrit ni n'efface le journal, et ne le remplit pas à la main.
select pg_temp.connecter('00000000-0000-4000-8000-c20000000001');
do $$ begin
  assert pg_temp.refuse($q$update public.journal_parametres set auteur_auth_user_id = null$q$), 'admin : réécrit le journal';
  assert pg_temp.refuse($q$delete from public.journal_parametres$q$), 'admin : efface le journal';
  assert pg_temp.refuse($q$insert into public.journal_parametres (referentiel, objet_id, action)
    values ('zones_geographiques', 'x', 'insert')$q$), 'admin : fausse trace';
end $$;
select set_config('role', 'postgres', true);

-- 3. Un pasteur ne modifie pas un référentiel (aucune trace) et ne lit pas le journal.
select pg_temp.connecter('00000000-0000-4000-8000-c20000000002');
do $$ begin
  assert pg_temp.refuse($q$insert into public.zones_geographiques (id, libelle, niveau, statut)
    values (gen_random_uuid(), 'Bénin', 0, 'actif')$q$), 'pasteur : crée une zone';
  assert (select count(*) from public.journal_parametres) = 0, 'pasteur : lit le journal';
end $$;
select set_config('role', 'postgres', true);

do $$ begin
  assert (select count(*) from public.journal_parametres) = 4, 'aucune trace d''une écriture refusée';
end $$;

-- 4. Historique des fiches : l'auteur inscrit est la fiche du compte réel.
select pg_temp.connecter('00000000-0000-4000-8000-c20000000002');
do $$ begin
  assert not pg_temp.refuse($q$insert into public.historique_fideles (id, fidele_id, champ_modifie, ancienne_valeur, nouvelle_valeur, auteur_fidele_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-c22000000003', 'telephone', null, '+22890000000',
            '00000000-0000-4000-8000-c22000000002')$q$), 'pasteur : historise en son nom';
  assert pg_temp.refuse($q$insert into public.historique_fideles (id, fidele_id, champ_modifie, ancienne_valeur, nouvelle_valeur, auteur_fidele_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-c22000000003', 'telephone', null, '+22890000001',
            '00000000-0000-4000-8000-c22000000001')$q$), 'pasteur : historise au nom d''un autre';
  assert pg_temp.refuse($q$insert into public.historique_fideles (id, fidele_id, champ_modifie, ancienne_valeur, nouvelle_valeur, auteur_fidele_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-c22000000003', 'telephone', null, '+22890000002', null)$q$),
    'pasteur : historise sans auteur';
end $$;
select set_config('role', 'postgres', true);

-- 5. Anonyme : aucun accès au journal.
select set_config('role', 'anon', true);
do $$ begin
  assert pg_temp.refuse('select 1 from public.journal_parametres'), 'anonyme : lit le journal';
end $$;
select set_config('role', 'postgres', true);

select 'OK — 0024_historisation_parametres_auteur_fideles : toutes les assertions passent';

rollback;
