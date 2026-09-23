-- Vérification par exécution réelle de 0020_liaison_administrateur.sql,
-- contre la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0020_liaison_administrateur_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.

begin;

insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-c00000000001', 'adm1@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-c00000000002', 'adm2@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-c00000000003', 'membre@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-c00000000004', 'ancien@test.local', 'authenticated', 'authenticated');

insert into public.comptes_utilisateurs (auth_user_id, identifiant, administrateur_amorcage) values
  ('00000000-0000-4000-8000-c00000000001', 'adm1@test.local', true),
  ('00000000-0000-4000-8000-c00000000002', 'adm2@test.local', true),
  ('00000000-0000-4000-8000-c00000000003', 'membre@test.local', false);

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
  ('00000000-0000-4000-8000-d00000000001', 'siege', 'Siège', 'T20-S', null, '/00000000-0000-4000-8000-d00000000001/');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id) values
  ('00000000-0000-4000-8000-e00000000001', '00000000-0000-4000-8000-d00000000001', 'Libre', 'L', '1980-01-01', 'masculin', 'marie', 'membre', null),
  ('00000000-0000-4000-8000-e00000000002', '00000000-0000-4000-8000-d00000000001', 'Membre', 'M', '1980-01-01', 'masculin', 'marie', 'membre', '00000000-0000-4000-8000-c00000000003'),
  ('00000000-0000-4000-8000-e00000000003', '00000000-0000-4000-8000-d00000000001', 'Ancienne', 'A', '1980-01-01', 'feminin', 'marie', 'membre', null),
  ('00000000-0000-4000-8000-e00000000004', '00000000-0000-4000-8000-d00000000001', 'Autre', 'O', '1980-01-01', 'feminin', 'marie', 'membre', null);

-- La fiche « Ancienne » a été liée par le passé (lien depuis retiré).
insert into public.journal_liaisons_comptes (auth_user_id, identifiant, fidele_id, issue, statut) values
  ('00000000-0000-4000-8000-c00000000004', 'ancien@test.local', '00000000-0000-4000-8000-e00000000003', 'lie_automatiquement', 'consigne');

create or replace function pg_temp.connecter(p_uid uuid) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', json_build_object('sub', p_uid, 'role', 'authenticated')::text, true);
  perform set_config('role', 'authenticated', true);
end $$;

-- Code SQLSTATE levé par l'appel (null s'il réussit).
create or replace function pg_temp.erreur(p_fidele uuid) returns text language plpgsql as $$
begin
  perform public.lier_mon_compte_a_fiche(p_fidele);
  return null;
exception when others then
  return sqlstate;
end $$;

-- 1. Un membre ne se lie pas lui-même par ce chemin.
select pg_temp.connecter('00000000-0000-4000-8000-c00000000003');
do $$ begin
  assert pg_temp.erreur('00000000-0000-4000-8000-e00000000001') = '42501', 'membre : lie son compte';
end $$;
select set_config('role', 'postgres', true);

-- 2. Fiche liée par le passé ou actuellement : refusée (garde-fou recyclage).
select pg_temp.connecter('00000000-0000-4000-8000-c00000000002');
do $$ begin
  assert pg_temp.erreur('00000000-0000-4000-8000-e00000000003') = '22023', 'administrateur : fiche liée par le passé';
  assert pg_temp.erreur('00000000-0000-4000-8000-e00000000002') = '22023', 'administrateur : fiche liée à un autre compte';
end $$;
select set_config('role', 'postgres', true);

-- 3. Cas nominal : l'administrateur d'amorçage se lie à une fiche libre,
--    reste administrateur, devient une personne du registre ; tracé.
select pg_temp.connecter('00000000-0000-4000-8000-c00000000001');
do $$ begin
  assert pg_temp.erreur('00000000-0000-4000-8000-e00000000001') is null, 'administrateur : liaison nominale';
  assert public.fidele_courant_id() = '00000000-0000-4000-8000-e00000000001', 'fiche courante';
  assert public.role_courant() = 'administrateur', 'rôle conservé';
  -- 4. Une seconde liaison est refusée : le compte a déjà une fiche.
  assert pg_temp.erreur('00000000-0000-4000-8000-e00000000004') = '22023', 'administrateur : deuxième fiche';
end $$;
select set_config('role', 'postgres', true);

do $$ begin
  assert (select count(*) from public.journal_liaisons_comptes
          where auth_user_id = '00000000-0000-4000-8000-c00000000001'
            and fidele_id = '00000000-0000-4000-8000-e00000000001'
            and statut = 'resolu_lie'
            and resolu_par_auth_user_id = '00000000-0000-4000-8000-c00000000001') = 1, 'liaison journalisée';
  -- 5. La fiche désormais liée protège contre toute autre liaison administrateur.
end $$;
select pg_temp.connecter('00000000-0000-4000-8000-c00000000002');
do $$ begin
  assert pg_temp.erreur('00000000-0000-4000-8000-e00000000001') = '22023', 'administrateur 2 : fiche de l''administrateur 1';
end $$;
select set_config('role', 'postgres', true);

select 'OK — 0020_liaison_administrateur : toutes les assertions passent';

rollback;
