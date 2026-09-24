-- Vérification par exécution réelle de 0021_separation_saisie_validation.sql,
-- contre la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0021_separation_saisie_validation_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.
--
-- Une seule église E ; ADM administrateur (par sa fiche), TRES trésorière
-- d'E (rang membre), PAST pasteur mandaté sur E.

begin;

insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-f00000000001', 'adm21@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-f00000000002', 'tres21@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-f00000000003', 'past21@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-f00000000004', 'sansfiche21@test.local', 'authenticated', 'authenticated');

insert into public.comptes_utilisateurs (auth_user_id, identifiant, administrateur_amorcage) values
  ('00000000-0000-4000-8000-f00000000004', 'sansfiche21@test.local', true);

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
  ('00000000-0000-4000-8000-f10000000001', 'siege', 'Siège', 'T21-S', null, '/00000000-0000-4000-8000-f10000000001/');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id) values
  ('00000000-0000-4000-8000-f20000000001', '00000000-0000-4000-8000-f10000000001', 'Adm', 'A', '1980-01-01', 'masculin', 'marie', 'administrateur', '00000000-0000-4000-8000-f00000000001'),
  ('00000000-0000-4000-8000-f20000000002', '00000000-0000-4000-8000-f10000000001', 'Tres', 'T', '1980-01-01', 'feminin', 'marie', 'membre', '00000000-0000-4000-8000-f00000000002'),
  ('00000000-0000-4000-8000-f20000000003', '00000000-0000-4000-8000-f10000000001', 'Past', 'P', '1980-01-01', 'masculin', 'marie', 'pasteur', '00000000-0000-4000-8000-f00000000003');

insert into public.tresoriers_noeud (id, fidele_id, noeud_id, date_debut) values
  (gen_random_uuid(), '00000000-0000-4000-8000-f20000000002', '00000000-0000-4000-8000-f10000000001', now());
insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
  (gen_random_uuid(), '00000000-0000-4000-8000-f10000000001', '00000000-0000-4000-8000-f20000000003', 'pasteur principal');

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

-- Saisie d'une contribution d'E, au nom de p_auteur, en attente.
create or replace function pg_temp.saisir(p_id uuid, p_auteur uuid) returns boolean language plpgsql as $$
begin
  return not pg_temp.refuse(format(
    $q$insert into public.contributions (id, type_offrande_id, montant, devise, noeud_id, mode_paiement, origine, date_saisie, saisie_par_fidele_id)
       values (%L, (select id from public.types_offrande limit 1), 100, 'GNF', '00000000-0000-4000-8000-f10000000001', 'especes', 'mobile', now(), %L)$q$,
    p_id, p_auteur));
end $$;

-- 1. La trésorière saisit : sous son propre nom seulement.
select pg_temp.connecter('00000000-0000-4000-8000-f00000000002');
do $$ begin
  assert not pg_temp.saisir('00000000-0000-4000-8000-f30000000001', '00000000-0000-4000-8000-f20000000003'),
    'trésorière : saisit au nom du pasteur';
  assert pg_temp.saisir('00000000-0000-4000-8000-f30000000001', '00000000-0000-4000-8000-f20000000002'),
    'trésorière : saisie à son nom';
  -- 2. Elle ne valide ni ne rejette sa propre saisie.
  assert pg_temp.touche($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-f20000000002'
    where id = '00000000-0000-4000-8000-f30000000001'$q$) = 0, 'trésorière : valide sa propre saisie';
  assert pg_temp.touche($q$update public.contributions set statut = 'rejetee', valide_par_fidele_id = '00000000-0000-4000-8000-f20000000002'
    where id = '00000000-0000-4000-8000-f30000000001'$q$) = 0, 'trésorière : rejette sa propre saisie';
end $$;
select set_config('role', 'postgres', true);

-- 3. Le pasteur valide la saisie de la trésorière — au nom de personne d'autre.
select pg_temp.connecter('00000000-0000-4000-8000-f00000000003');
do $$ begin
  assert pg_temp.refuse($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-f20000000001'
    where id = '00000000-0000-4000-8000-f30000000001'$q$), 'pasteur : valide au nom de l''administrateur';
  assert pg_temp.refuse($q$update public.contributions set saisie_par_fidele_id = null
    where id = '00000000-0000-4000-8000-f30000000001'$q$), 'pasteur : efface l''auteur de la saisie';
  assert pg_temp.touche($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-f20000000003',
    date_validation = now() where id = '00000000-0000-4000-8000-f30000000001'$q$) = 1, 'pasteur : valide la saisie d''autrui';
end $$;
select set_config('role', 'postgres', true);

-- 4. L'administrateur n'y fait pas exception : sa propre saisie attend une autre personne.
select pg_temp.connecter('00000000-0000-4000-8000-f00000000001');
do $$ begin
  assert pg_temp.saisir('00000000-0000-4000-8000-f30000000002', '00000000-0000-4000-8000-f20000000001'), 'administrateur : saisie';
  assert pg_temp.touche($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-f20000000001'
    where id = '00000000-0000-4000-8000-f30000000002'$q$) = 0, 'administrateur : valide sa propre saisie';
end $$;
select set_config('role', 'postgres', true);

-- 5. Un compte sans fiche (administrateur d'amorçage) ne saisit pas : aucun auteur traçable.
select pg_temp.connecter('00000000-0000-4000-8000-f00000000004');
do $$ begin
  assert not pg_temp.saisir('00000000-0000-4000-8000-f30000000003', null), 'compte sans fiche : saisie';
end $$;
select set_config('role', 'postgres', true);

do $$ begin
  assert (select statut from public.contributions where id = '00000000-0000-4000-8000-f30000000002') = 'en_attente',
    'la saisie de l''administrateur attend une seconde personne';
end $$;

select 'OK — 0021_separation_saisie_validation : toutes les assertions passent';

rollback;
