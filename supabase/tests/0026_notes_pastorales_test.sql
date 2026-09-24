-- Vérification par exécution réelle de 0026_notes_pastorales.sql, contre la
-- stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0026_notes_pastorales_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.
--
-- Arbre : S (siège) > E1, E2 (églises paires).
-- Profils (compte n° = fiche n°) :
--   01 PA  pasteur, mandat E1 — auteur de N1
--   02 PB  pasteur, mandat E1
--   03 PR  pasteur régional, mandat S — auteur de N2
--   04 PX  pasteur, mandat E2 (nœud pair)
--   05 F   membre de E1 — fidèle concerné par N1
--   06 FP  pasteur, mandat E1 — fidèle concerné par N2
--   07 R   responsable, mandat E1
--   08 T   membre, trésorier de E1
--   09 C   membre de la commission disciplinaire de E1
--   10 AD  administrateur, sans mandat
-- Notes : N1 (sur F, par PA), N2 (sur FP, par PR), toutes deux au nœud E1.

begin;

insert into auth.users (id, email, aud, role)
select ('00000000-0000-4000-8000-e200000000' || lpad(n::text, 2, '0'))::uuid, 'np' || n || '@test.local', 'authenticated', 'authenticated'
from generate_series(1, 10) n;

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path, categorie_confessionnelle) values
  ('00000000-0000-4000-8000-e21000000001', 'siege', 'Siège', 'T26-S', null,
   '/00000000-0000-4000-8000-e21000000001/', null),
  ('00000000-0000-4000-8000-e21000000002', 'eglise_locale', 'E1', 'T26-E1', '00000000-0000-4000-8000-e21000000001',
   '/00000000-0000-4000-8000-e21000000001/00000000-0000-4000-8000-e21000000002/', 'autres'),
  ('00000000-0000-4000-8000-e21000000003', 'eglise_locale', 'E2', 'T26-E2', '00000000-0000-4000-8000-e21000000001',
   '/00000000-0000-4000-8000-e21000000001/00000000-0000-4000-8000-e21000000003/', 'autres');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id)
select ('00000000-0000-4000-8000-e220000000' || lpad(n::text, 2, '0'))::uuid,
       case n when 3 then '00000000-0000-4000-8000-e21000000001'::uuid
              when 4 then '00000000-0000-4000-8000-e21000000003'::uuid
              when 10 then '00000000-0000-4000-8000-e21000000001'::uuid
              else '00000000-0000-4000-8000-e21000000002'::uuid end,
       'F', 'P' || n, '1980-01-01', 'masculin', 'marie',
       case n when 1 then 'pasteur' when 2 then 'pasteur' when 3 then 'pasteur' when 4 then 'pasteur'
              when 6 then 'pasteur' when 7 then 'responsable' when 10 then 'administrateur' else 'membre' end,
       ('00000000-0000-4000-8000-e200000000' || lpad(n::text, 2, '0'))::uuid
from generate_series(1, 10) n;

insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
  (gen_random_uuid(), '00000000-0000-4000-8000-e21000000002', '00000000-0000-4000-8000-e22000000001', 'pasteur principal'),
  (gen_random_uuid(), '00000000-0000-4000-8000-e21000000002', '00000000-0000-4000-8000-e22000000002', 'pasteur adjoint'),
  (gen_random_uuid(), '00000000-0000-4000-8000-e21000000001', '00000000-0000-4000-8000-e22000000003', 'pasteur régional'),
  (gen_random_uuid(), '00000000-0000-4000-8000-e21000000003', '00000000-0000-4000-8000-e22000000004', 'pasteur principal'),
  (gen_random_uuid(), '00000000-0000-4000-8000-e21000000002', '00000000-0000-4000-8000-e22000000006', 'pasteur adjoint'),
  (gen_random_uuid(), '00000000-0000-4000-8000-e21000000002', '00000000-0000-4000-8000-e22000000007', 'responsable jeunesse');

insert into public.tresoriers_noeud (id, fidele_id, noeud_id, date_debut) values
  (gen_random_uuid(), '00000000-0000-4000-8000-e22000000008', '00000000-0000-4000-8000-e21000000002', now());

insert into public.commissions_disciplinaires (id, noeud_id, nom) values
  ('00000000-0000-4000-8000-e23000000001', '00000000-0000-4000-8000-e21000000002', 'Commission E1');
insert into public.membres_commission_disciplinaire (id, commission_id, fidele_id) values
  (gen_random_uuid(), '00000000-0000-4000-8000-e23000000001', '00000000-0000-4000-8000-e22000000009');

insert into public.notes_pastorales (id, fidele_id, auteur_fidele_id, noeud_id, contenu) values
  ('00000000-0000-4000-8000-e24000000001', '00000000-0000-4000-8000-e22000000005',
   '00000000-0000-4000-8000-e22000000001', '00000000-0000-4000-8000-e21000000002', 'Note sur F'),
  ('00000000-0000-4000-8000-e24000000002', '00000000-0000-4000-8000-e22000000006',
   '00000000-0000-4000-8000-e22000000003', '00000000-0000-4000-8000-e21000000002', 'Note sur FP');

create or replace function pg_temp.compte(n int) returns uuid language sql as $$
  select ('00000000-0000-4000-8000-e200000000' || lpad(n::text, 2, '0'))::uuid;
$$;
create or replace function pg_temp.fiche(n int) returns uuid language sql as $$
  select ('00000000-0000-4000-8000-e220000000' || lpad(n::text, 2, '0'))::uuid;
$$;
create or replace function pg_temp.note(n int) returns uuid language sql as $$
  select ('00000000-0000-4000-8000-e240000000' || lpad(n::text, 2, '0'))::uuid;
$$;

create or replace function pg_temp.connecter(n int) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', json_build_object('sub', pg_temp.compte(n), 'role', 'authenticated')::text, true);
  perform set_config('role', 'authenticated', true);
end $$;

-- Vrai si l'instruction est refusée (policy, privilège ou contrainte).
create or replace function pg_temp.refuse(p_sql text) returns boolean language plpgsql as $$
begin
  execute p_sql;
  return false;
exception when insufficient_privilege or check_violation then
  return true;
end $$;

create or replace function pg_temp.touche(p_sql text) returns bigint language plpgsql as $$
declare n bigint;
begin
  execute p_sql;
  get diagnostics n = row_count;
  return n;
end $$;

create or replace function pg_temp.voit(p_profil int, p_note int) returns boolean language plpgsql as $$
declare n bigint;
begin
  perform pg_temp.connecter(p_profil);
  select count(*) into n from public.notes_pastorales where id = pg_temp.note(p_note);
  return n = 1;
end $$;

create or replace function pg_temp.rediger(p_profil int, p_fidele int, p_auteur int, p_noeud uuid) returns boolean
language plpgsql as $$
begin
  perform pg_temp.connecter(p_profil);
  return not pg_temp.refuse(format(
    $q$insert into public.notes_pastorales (id, fidele_id, auteur_fidele_id, noeud_id, contenu)
       values (gen_random_uuid(), %L, %L, %L, 'x')$q$,
    pg_temp.fiche(p_fidele), pg_temp.fiche(p_auteur), p_noeud));
end $$;

create or replace function pg_temp.journaliser(p_profil int, p_note int, p_compte int, p_role text) returns boolean
language plpgsql as $$
begin
  perform pg_temp.connecter(p_profil);
  return not pg_temp.refuse(format(
    $q$insert into public.consultations_notes_pastorales (id, note_id, auth_user_id, fidele_id, role)
       values (gen_random_uuid(), %L, %L, %L, %L)$q$,
    pg_temp.note(p_note), pg_temp.compte(p_compte), pg_temp.fiche(p_compte), p_role));
end $$;

-- ---------------------------------------------------------------- 0. couverture
do $$ begin
  assert (select bool_and(relrowsecurity) from pg_class
          where oid in ('public.notes_pastorales'::regclass, 'public.consultations_notes_pastorales'::regclass)),
    'RLS non activée';
  assert not exists (select 1 from pg_policies where tablename in ('notes_pastorales', 'consultations_notes_pastorales')
                     and roles <> '{authenticated}'), 'policy ouverte à un autre rôle que authenticated';
end $$;

-- ---------------------------------------------------------------- 1. anon : rien
select set_config('role', 'anon', true);
do $$ begin
  assert pg_temp.refuse('select * from public.notes_pastorales'), 'anon lit les notes';
  assert pg_temp.refuse('select * from public.consultations_notes_pastorales'), 'anon lit le journal';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 2. lecture
do $$ begin
  assert pg_temp.voit(1, 1), 'PA : ne lit pas sa propre note';
  assert pg_temp.voit(2, 1), 'PB : pasteur du périmètre, ne lit pas N1';
  assert pg_temp.voit(3, 1), 'PR : pasteur du nœud parent, ne lit pas N1';
  assert pg_temp.voit(3, 2), 'PR : ne lit pas sa propre note N2';
  assert not pg_temp.voit(4, 1), 'PX : pasteur d''un nœud pair, lit N1';
  assert not pg_temp.voit(5, 1), 'F : lit la note écrite sur lui';
  assert not pg_temp.voit(6, 2), 'FP : pasteur de son propre nœud, lit la note écrite sur lui';
  assert pg_temp.voit(6, 1), 'FP : pasteur de E1, ne lit pas N1 (note sur un autre)';
  assert not pg_temp.voit(7, 1), 'R : responsable, lit une note';
  assert not pg_temp.voit(8, 1), 'T : trésorier, lit une note';
  assert not pg_temp.voit(9, 1), 'C : membre de commission, lit une note';
  assert pg_temp.voit(10, 1) and pg_temp.voit(10, 2), 'AD : administrateur, ne lit pas par son rang';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 3. rédaction
do $$
declare e1 uuid := '00000000-0000-4000-8000-e21000000002';
        s uuid := '00000000-0000-4000-8000-e21000000001';
begin
  assert pg_temp.rediger(2, 5, 2, e1), 'PB : rédaction légitime refusée';
  assert not pg_temp.rediger(2, 5, 1, e1), 'PB : rédige au nom de PA';
  assert not pg_temp.rediger(2, 2, 2, e1), 'PB : rédige sur sa propre fiche';
  assert not pg_temp.rediger(3, 5, 3, s), 'PR : rattache la note à un autre nœud que celui du fidèle';
  assert not pg_temp.rediger(4, 5, 4, e1), 'PX : rédige hors de son périmètre';
  assert not pg_temp.rediger(7, 5, 7, e1), 'R : responsable, rédige';
  assert not pg_temp.rediger(8, 5, 8, e1), 'T : trésorier, rédige';
  assert not pg_temp.rediger(9, 5, 9, e1), 'C : membre de commission, rédige';
  assert not pg_temp.rediger(5, 6, 5, e1), 'F : membre, rédige';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 4. modification, suppression
do $$ begin
  perform pg_temp.connecter(1);
  assert pg_temp.touche(format($q$update public.notes_pastorales set contenu = 'Complétée', updated_at = now()
                                   where id = %L$q$, pg_temp.note(1))) = 1, 'PA : ne modifie pas sa note';
  assert pg_temp.refuse(format($q$update public.notes_pastorales set fidele_id = %L where id = %L$q$,
                               pg_temp.fiche(8), pg_temp.note(1))), 'PA : change le fidèle concerné';
  assert pg_temp.refuse(format($q$update public.notes_pastorales set noeud_id = '00000000-0000-4000-8000-e21000000003'
                                   where id = %L$q$, pg_temp.note(1))), 'PA : change le nœud';
  assert pg_temp.refuse(format($q$update public.notes_pastorales set auteur_fidele_id = %L where id = %L$q$,
                               pg_temp.fiche(2), pg_temp.note(1))), 'PA : change l''auteur';
  assert pg_temp.refuse(format('delete from public.notes_pastorales where id = %L', pg_temp.note(1))),
    'PA : supprime sa note';

  perform pg_temp.connecter(2);
  assert pg_temp.touche(format($q$update public.notes_pastorales set contenu = 'Réécrite' where id = %L$q$,
                               pg_temp.note(1))) = 0, 'PB : modifie la note de PA';
  perform pg_temp.connecter(10);
  assert pg_temp.touche(format($q$update public.notes_pastorales set contenu = 'Réécrite' where id = %L$q$,
                               pg_temp.note(1))) = 0, 'AD : modifie la note de PA';
end $$;
select set_config('role', 'postgres', true);
do $$ begin
  assert (select contenu from public.notes_pastorales where id = pg_temp.note(1)) = 'Complétée',
    'contenu de N1 inattendu après les modifications';
end $$;

-- ---------------------------------------------------------------- 5. journal
do $$ begin
  assert pg_temp.journaliser(2, 1, 2, 'pasteur'), 'PB : sa consultation de N1 refusée';
  assert not pg_temp.journaliser(2, 1, 1, 'pasteur'), 'PB : journalise au nom de PA';
  assert not pg_temp.journaliser(2, 1, 2, 'administrateur'), 'PB : journalise avec un faux rôle';
  assert not pg_temp.journaliser(4, 1, 4, 'pasteur'), 'PX : journalise une note illisible';
  assert not pg_temp.journaliser(5, 1, 5, 'membre'), 'F : journalise la note écrite sur lui';

  perform pg_temp.connecter(1);
  assert (select count(*) from public.consultations_notes_pastorales where note_id = pg_temp.note(1)) = 1,
    'PA (auteur) : ne lit pas le journal de sa note';
  perform pg_temp.connecter(3);
  assert (select count(*) from public.consultations_notes_pastorales where note_id = pg_temp.note(1)) = 1,
    'PR (pasteur du périmètre) : ne lit pas le journal';
  perform pg_temp.connecter(5);
  assert (select count(*) from public.consultations_notes_pastorales) = 0, 'F : lit le journal de sa note';
  perform pg_temp.connecter(7);
  assert (select count(*) from public.consultations_notes_pastorales) = 0, 'R : lit le journal';
  perform pg_temp.connecter(4);
  assert (select count(*) from public.consultations_notes_pastorales) = 0, 'PX : lit le journal';

  perform pg_temp.connecter(2);
  assert pg_temp.refuse('update public.consultations_notes_pastorales set role = ''membre'''), 'PB : modifie le journal';
  assert pg_temp.refuse('delete from public.consultations_notes_pastorales'), 'PB : supprime le journal';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 6. contrôle négatif
-- Le gabarit générique « fiche accessible » de 0019 (soi-même ou périmètre)
-- rouvrirait la note au fidèle concerné : ce test doit donc échouer si la
-- policy de lecture est remplacée par lui.
drop policy notes_pastorales_lecture on public.notes_pastorales;
create policy notes_pastorales_lecture on public.notes_pastorales
  for select to authenticated using (public.fidele_accessible(fidele_id));
do $$ begin
  assert pg_temp.voit(5, 1), 'contrôle négatif : le gabarit générique n''ouvre pas la note au fidèle concerné';
end $$;
select set_config('role', 'postgres', true);

select 'OK — 0026_notes_pastorales : toutes les assertions passent';

rollback;
