-- Vérification par exécution réelle de 0027_bucket_corpus_bibliques.sql,
-- contre la stack Supabase locale (stockage activé dans config.toml).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0027_bucket_corpus_bibliques_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Complété par tool/bible/televerser_corpus.dart --verifier (lecture publique
-- réelle par HTTP, refus d'écriture anonyme et authentifiée par l'API).
-- Tout se déroule dans une transaction annulée.

begin;

-- 1. Le bucket existe, public en lecture, borné en taille et en type.
do $$ begin
  assert exists (select 1 from storage.buckets
                 where id = 'corpus-bibliques' and public
                   and file_size_limit = 20971520
                   and allowed_mime_types = array['application/gzip']),
    'bucket corpus-bibliques absent ou mal configuré';
end $$;

-- 2. Aucune policy de storage.objects n'ouvre d'écriture (ni lecture par
--    table) : seule l'URL publique du bucket sert les fichiers.
do $$ begin
  assert (select relrowsecurity from pg_class where oid = 'storage.objects'::regclass),
    'RLS désactivée sur storage.objects';
  assert not exists (select 1 from pg_policies where schemaname = 'storage' and tablename = 'objects'),
    'une policy de storage.objects existe : vérifier qu''elle n''ouvre pas le bucket corpus-bibliques';
end $$;

-- 3. Écriture directe refusée à un client, anonyme ou authentifié.
create or replace function pg_temp.refuse(p_sql text) returns boolean language plpgsql as $$
begin
  execute p_sql;
  return false;
exception when insufficient_privilege then
  return true;
end $$;

insert into storage.objects (bucket_id, name) values ('corpus-bibliques', 'existant.db.gz');

select set_config('role', 'anon', true);
do $$ begin
  assert pg_temp.refuse($q$insert into storage.objects (bucket_id, name) values ('corpus-bibliques', 'anon.db.gz')$q$),
    'anon : dépose un fichier';
end $$;
select set_config('role', 'postgres', true);

select set_config('request.jwt.claims', json_build_object('sub', gen_random_uuid(), 'role', 'authenticated')::text, true);
select set_config('role', 'authenticated', true);
do $$ begin
  assert pg_temp.refuse($q$insert into storage.objects (bucket_id, name) values ('corpus-bibliques', 'auth.db.gz')$q$),
    'authenticated : dépose un fichier';
  assert (select count(*) from storage.objects where bucket_id = 'corpus-bibliques') = 0,
    'authenticated : liste les objets du bucket par la table';
end $$;
select set_config('role', 'postgres', true);

do $$ begin
  assert (select count(*) from storage.objects where bucket_id = 'corpus-bibliques' and name = 'existant.db.gz') = 1,
    'fichier existant altéré';
end $$;

select 'OK — 0027_bucket_corpus_bibliques : toutes les assertions passent';

rollback;
