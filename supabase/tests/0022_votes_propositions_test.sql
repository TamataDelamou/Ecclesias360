-- Vérification par exécution réelle de 0022_votes_propositions.sql, contre
-- la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0022_votes_propositions_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.

begin;

insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-a20000000001', 'auteur22@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-a20000000002', 'votant22@test.local', 'authenticated', 'authenticated');

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
  ('00000000-0000-4000-8000-a21000000001', 'siege', 'Siège', 'T22-S', null, '/00000000-0000-4000-8000-a21000000001/');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id) values
  ('00000000-0000-4000-8000-a22000000001', '00000000-0000-4000-8000-a21000000001', 'Auteur', 'A', '1980-01-01', 'masculin', 'marie', 'membre', '00000000-0000-4000-8000-a20000000001'),
  ('00000000-0000-4000-8000-a22000000002', '00000000-0000-4000-8000-a21000000001', 'Votant', 'V', '1980-01-01', 'feminin', 'marie', 'membre', '00000000-0000-4000-8000-a20000000002');

insert into public.propositions_theme (id, fidele_id, titre, date_soumission) values
  ('00000000-0000-4000-8000-a23000000001', '00000000-0000-4000-8000-a22000000001', 'La grâce', now());

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

-- 1. L'auteur ne vote pas sur sa propre proposition.
select pg_temp.connecter('00000000-0000-4000-8000-a20000000001');
do $$ begin
  assert pg_temp.refuse($q$insert into public.votes_proposition (id, proposition_id, fidele_id, valeur) values
    (gen_random_uuid(), '00000000-0000-4000-8000-a23000000001', '00000000-0000-4000-8000-a22000000001', 'jaime')$q$),
    'auteur : vote sur sa proposition';
end $$;
select set_config('role', 'postgres', true);

-- 2. Un autre fidèle vote, en son nom seul, puis change son vote.
select pg_temp.connecter('00000000-0000-4000-8000-a20000000002');
do $$ begin
  assert pg_temp.refuse($q$insert into public.votes_proposition (id, proposition_id, fidele_id, valeur) values
    (gen_random_uuid(), '00000000-0000-4000-8000-a23000000001', '00000000-0000-4000-8000-a22000000001', 'jaime')$q$),
    'votant : vote au nom de l''auteur';
  assert not pg_temp.refuse($q$insert into public.votes_proposition (id, proposition_id, fidele_id, valeur) values
    ('00000000-0000-4000-8000-a24000000001', '00000000-0000-4000-8000-a23000000001', '00000000-0000-4000-8000-a22000000002', 'jaime')$q$),
    'votant : vote';
  assert pg_temp.touche($q$update public.votes_proposition set valeur = 'jenaimepas'
    where id = '00000000-0000-4000-8000-a24000000001'$q$) = 1, 'votant : change son vote';
  assert pg_temp.refuse($q$update public.votes_proposition set fidele_id = '00000000-0000-4000-8000-a22000000001'
    where id = '00000000-0000-4000-8000-a24000000001'$q$), 'votant : réattribue son vote';
end $$;
select set_config('role', 'postgres', true);

-- 3. L'auteur ne modifie pas le vote d'autrui.
select pg_temp.connecter('00000000-0000-4000-8000-a20000000001');
do $$ begin
  assert pg_temp.touche($q$update public.votes_proposition set valeur = 'jaime'
    where id = '00000000-0000-4000-8000-a24000000001'$q$) = 0, 'auteur : modifie le vote d''autrui';
end $$;
select set_config('role', 'postgres', true);

do $$ begin
  assert (select valeur from public.votes_proposition where id = '00000000-0000-4000-8000-a24000000001') = 'jenaimepas',
    'vote conservé';
end $$;

select 'OK — 0022_votes_propositions : toutes les assertions passent';

rollback;
