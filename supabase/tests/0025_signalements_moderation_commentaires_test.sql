-- Vérification par exécution réelle de 0025_signalements_moderation_commentaires.sql,
-- contre la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0025_signalements_moderation_commentaires_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.
--
-- Profils : A auteur du commentaire, S1/S2/S3/S4 signaleurs (membres),
-- P pasteur (modérateur), R responsable sans mandat (pas modérateur).

begin;

insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-d20000000001', 'auteur25@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-d20000000002', 's1_25@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-d20000000003', 's2_25@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-d20000000004', 's3_25@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-d20000000005', 's4_25@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-d20000000006', 'pasteur25@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-d20000000007', 'resp25@test.local', 'authenticated', 'authenticated');

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
  ('00000000-0000-4000-8000-d21000000001', 'siege', 'Siège', 'T25-S', null, '/00000000-0000-4000-8000-d21000000001/');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id)
select ('00000000-0000-4000-8000-d2200000000' || n)::uuid, '00000000-0000-4000-8000-d21000000001', 'F', 'P' || n, '1980-01-01', 'masculin', 'marie',
       case n when 6 then 'pasteur' when 7 then 'responsable' else 'membre' end,
       ('00000000-0000-4000-8000-d2000000000' || n)::uuid
from generate_series(1, 7) n;

insert into public.contenus_mediatheque (id, type_contenu, titre, noeud_editeur_id, theme, date_contenu, statut) values
  ('00000000-0000-4000-8000-d23000000001', 'audio', 'Prédication', '00000000-0000-4000-8000-d21000000001', 'foi', now(), 'publie');

insert into public.commentaires (id, contenu_id, fidele_id, texte, statut_moderation, date) values
  ('00000000-0000-4000-8000-d24000000001', '00000000-0000-4000-8000-d23000000001',
   '00000000-0000-4000-8000-d22000000001', 'Commentaire', 'publie', now() - interval '1 hour');

create or replace function pg_temp.connecter(p_uid uuid) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', json_build_object('sub', p_uid, 'role', 'authenticated')::text, true);
  perform set_config('role', 'authenticated', true);
end $$;

create or replace function pg_temp.refuse(p_sql text) returns boolean language plpgsql as $$
begin
  execute p_sql;
  return false;
exception when insufficient_privilege or unique_violation then
  return true;
end $$;

create or replace function pg_temp.touche(p_sql text) returns bigint language plpgsql as $$
declare n bigint;
begin
  execute p_sql;
  get diagnostics n = row_count;
  return n;
end $$;

create or replace function pg_temp.signaler(p_uid text, p_fiche text) returns boolean language plpgsql as $$
begin
  perform pg_temp.connecter(p_uid::uuid);
  return not pg_temp.refuse(format($q$insert into public.signalements_commentaire (id, commentaire_id, fidele_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-d24000000001', %L)$q$, p_fiche));
end $$;

create or replace function pg_temp.statut() returns text language sql as $$
  select statut_moderation from public.commentaires where id = '00000000-0000-4000-8000-d24000000001';
$$;

-- 1. L'auteur ne signale pas son propre commentaire ; nul ne signale au nom d'un autre.
do $$ begin
  assert not pg_temp.signaler('00000000-0000-4000-8000-d20000000001', '00000000-0000-4000-8000-d22000000001'),
    'auteur : signale son propre commentaire';
  assert not pg_temp.signaler('00000000-0000-4000-8000-d20000000002', '00000000-0000-4000-8000-d22000000003'),
    'S1 : signale au nom de S2';
end $$;
select set_config('role', 'postgres', true);

-- 2. Un même fidèle ne signale qu'une fois : trois tentatives, un seul signaleur.
do $$ begin
  assert pg_temp.signaler('00000000-0000-4000-8000-d20000000002', '00000000-0000-4000-8000-d22000000002'), 'S1 : signale';
  assert not pg_temp.signaler('00000000-0000-4000-8000-d20000000002', '00000000-0000-4000-8000-d22000000002'), 'S1 : 2e fois';
  assert not pg_temp.signaler('00000000-0000-4000-8000-d20000000002', '00000000-0000-4000-8000-d22000000002'), 'S1 : 3e fois';
end $$;
select set_config('role', 'postgres', true);
do $$ begin
  assert pg_temp.statut() = 'publie', 'un seul signaleur : toujours publié';
  assert (select nombre_signalements from public.commentaires where id = '00000000-0000-4000-8000-d24000000001') = 1,
    'décompte : un signaleur';
end $$;

-- 3. Trois signaleurs distincts : masquage automatique.
do $$ begin
  assert pg_temp.signaler('00000000-0000-4000-8000-d20000000003', '00000000-0000-4000-8000-d22000000003'), 'S2 : signale';
  assert pg_temp.signaler('00000000-0000-4000-8000-d20000000004', '00000000-0000-4000-8000-d22000000004'), 'S3 : signale';
end $$;
select set_config('role', 'postgres', true);
do $$ begin
  assert pg_temp.statut() = 'masque', 'trois signaleurs distincts : masqué';
end $$;

-- 4. Le fidèle signalé ne voit pas qui l'a signalé ; le modérateur, si.
select pg_temp.connecter('00000000-0000-4000-8000-d20000000001');
do $$ begin
  assert (select count(*) from public.signalements_commentaire) = 0, 'auteur : voit ses signaleurs';
end $$;
select set_config('role', 'postgres', true);
select pg_temp.connecter('00000000-0000-4000-8000-d20000000006');
do $$ begin
  assert (select count(*) from public.signalements_commentaire) = 3, 'pasteur : voit les signaleurs';
end $$;
select set_config('role', 'postgres', true);

-- La transaction de test fige now() : les signalements examinés sont antidatés
-- et la décision datée entre eux et le prochain signalement, comme le seraient
-- trois transactions successives.
update public.signalements_commentaire set created_at = now() - interval '10 minutes';

-- 5. Modération : ni texte ni auteur réécrits, décision tracée au nom du compte réel.
select pg_temp.connecter('00000000-0000-4000-8000-d20000000007');
do $$ begin
  assert pg_temp.touche($q$update public.commentaires set statut_moderation = 'publie', modere_par = '00000000-0000-4000-8000-d22000000007',
    date_moderation = now() where id = '00000000-0000-4000-8000-d24000000001'$q$) = 0, 'responsable sans mandat : modère';
end $$;
select set_config('role', 'postgres', true);

select pg_temp.connecter('00000000-0000-4000-8000-d20000000006');
do $$ begin
  assert pg_temp.refuse($q$update public.commentaires set texte = 'réécrit'
    where id = '00000000-0000-4000-8000-d24000000001'$q$), 'pasteur : réécrit le texte';
  assert pg_temp.refuse($q$update public.commentaires set statut_moderation = 'publie', date_moderation = now(),
    modere_par = '00000000-0000-4000-8000-d22000000007' where id = '00000000-0000-4000-8000-d24000000001'$q$),
    'pasteur : décision au nom d''un autre';
  assert pg_temp.touche($q$update public.commentaires set statut_moderation = 'publie', date_moderation = now() - interval '1 minute',
    modere_par = '00000000-0000-4000-8000-d22000000006', nombre_signalements = 0
    where id = '00000000-0000-4000-8000-d24000000001'$q$) = 1, 'pasteur : approuve';
  assert pg_temp.refuse($q$delete from public.signalements_commentaire$q$), 'pasteur : efface les signalements';
end $$;
select set_config('role', 'postgres', true);

-- 6. Après approbation, les signalements examinés ne comptent plus : un
--    nouveau signaleur ne remasque pas ; une date future est refusée.
do $$ begin
  assert pg_temp.signaler('00000000-0000-4000-8000-d20000000005', '00000000-0000-4000-8000-d22000000005'), 'S4 : signale';
  assert pg_temp.refuse($q$insert into public.signalements_commentaire (id, commentaire_id, fidele_id, created_at)
    values (gen_random_uuid(), '00000000-0000-4000-8000-d24000000001', '00000000-0000-4000-8000-d22000000005', now() + interval '1 day')$q$),
    'S4 : signalement daté dans le futur';
end $$;
select set_config('role', 'postgres', true);
do $$ begin
  assert pg_temp.statut() = 'publie', 'approuvé puis un seul nouveau signaleur : publié';
  assert (select nombre_signalements from public.commentaires where id = '00000000-0000-4000-8000-d24000000001') = 1,
    'décompte depuis la décision : un signaleur';
  assert (select modere_par from public.commentaires where id = '00000000-0000-4000-8000-d24000000001')
         = '00000000-0000-4000-8000-d22000000006', 'décision tracée';
end $$;

-- 7. Anonyme : aucun accès.
select set_config('role', 'anon', true);
do $$ begin
  assert pg_temp.refuse('select 1 from public.signalements_commentaire'), 'anonyme : lit les signalements';
end $$;
select set_config('role', 'postgres', true);

select 'OK — 0025_signalements_moderation_commentaires : toutes les assertions passent';

rollback;
