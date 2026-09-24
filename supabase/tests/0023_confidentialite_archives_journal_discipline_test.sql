-- Vérification par exécution réelle de 0023_confidentialite_archives_journal_discipline.sql,
-- contre la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0023_confidentialite_archives_journal_discipline_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.
--
-- Profils : P pasteur du siège, R responsable du siège (mandat), C membre de
-- la commission K (sans mandat), M simple membre. Dossier D instruit par K,
-- dossier D2 sans commission.
-- Documents : A pièce de D (restreint), B procès-verbal standard, Z pièce de
-- D2 dont le niveau a été abaissé à « standard ».

begin;

insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-b20000000001', 'pasteur23@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-b20000000002', 'responsable23@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-b20000000003', 'commission23@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-b20000000004', 'membre23@test.local', 'authenticated', 'authenticated');

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
  ('00000000-0000-4000-8000-b21000000001', 'siege', 'Siège', 'T23-S', null, '/00000000-0000-4000-8000-b21000000001/');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id) values
  ('00000000-0000-4000-8000-b22000000001', '00000000-0000-4000-8000-b21000000001', 'Pasteur', 'P', '1970-01-01', 'masculin', 'marie', 'pasteur', '00000000-0000-4000-8000-b20000000001'),
  ('00000000-0000-4000-8000-b22000000002', '00000000-0000-4000-8000-b21000000001', 'Responsable', 'R', '1975-01-01', 'feminin', 'marie', 'responsable', '00000000-0000-4000-8000-b20000000002'),
  ('00000000-0000-4000-8000-b22000000003', '00000000-0000-4000-8000-b21000000001', 'Commission', 'C', '1980-01-01', 'masculin', 'marie', 'membre', '00000000-0000-4000-8000-b20000000003'),
  ('00000000-0000-4000-8000-b22000000004', '00000000-0000-4000-8000-b21000000001', 'Membre', 'M', '1985-01-01', 'feminin', 'marie', 'membre', '00000000-0000-4000-8000-b20000000004'),
  ('00000000-0000-4000-8000-b22000000005', '00000000-0000-4000-8000-b21000000001', 'Concerne', 'F', '1990-01-01', 'masculin', 'celibataire', 'membre', null);

insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
  (gen_random_uuid(), '00000000-0000-4000-8000-b21000000001', '00000000-0000-4000-8000-b22000000001', 'pasteur'),
  (gen_random_uuid(), '00000000-0000-4000-8000-b21000000001', '00000000-0000-4000-8000-b22000000002', 'responsable');

insert into public.commissions_disciplinaires (id, noeud_id, nom) values
  ('00000000-0000-4000-8000-b23000000001', '00000000-0000-4000-8000-b21000000001', 'Commission K');
insert into public.membres_commission_disciplinaire (id, commission_id, fidele_id) values
  (gen_random_uuid(), '00000000-0000-4000-8000-b23000000001', '00000000-0000-4000-8000-b22000000003');

insert into public.dossiers_disciplinaires (id, fidele_id, noeud_id, nature_faute_id, date_ouverture, commission_id) values
  ('00000000-0000-4000-8000-b24000000001', '00000000-0000-4000-8000-b22000000005', '00000000-0000-4000-8000-b21000000001',
   (select id from public.natures_faute where code = 'conflit_non_resolu'), now(), '00000000-0000-4000-8000-b23000000001'),
  ('00000000-0000-4000-8000-b24000000002', '00000000-0000-4000-8000-b22000000005', '00000000-0000-4000-8000-b21000000001',
   (select id from public.natures_faute where code = 'conflit_non_resolu'), now(), null);

insert into public.documents_archive (id, numero_archive, type_document, module_origine, objet_id_origine, noeud_id, niveau_confidentialite, fichier, date_archivage) values
  ('00000000-0000-4000-8000-b25000000001', 'T23-PD-A', 'piece_dossier_disciplinaire', 'discipline', '00000000-0000-4000-8000-b24000000001',
   '00000000-0000-4000-8000-b21000000001', 'restreint', 'temoignage A', now()),
  ('00000000-0000-4000-8000-b25000000002', 'T23-PV-B', 'proces_verbal_comite', 'comite', 'seance-x',
   '00000000-0000-4000-8000-b21000000001', 'standard', 'pv B', now()),
  -- Z : niveau déjà abaissé (état antérieur à 0023, où la colonne était modifiable).
  ('00000000-0000-4000-8000-b25000000003', 'T23-PD-Z', 'piece_dossier_disciplinaire', 'discipline', '00000000-0000-4000-8000-b24000000002',
   '00000000-0000-4000-8000-b21000000001', 'standard', 'temoignage Z', now());

insert into public.pieces_dossier (id, dossier_id, nature, ajoute_le, document_archive_id) values
  (gen_random_uuid(), '00000000-0000-4000-8000-b24000000001', 'temoignage', now(), '00000000-0000-4000-8000-b25000000001'),
  (gen_random_uuid(), '00000000-0000-4000-8000-b24000000002', 'temoignage', now(), '00000000-0000-4000-8000-b25000000003');

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

create or replace function pg_temp.voit(p_document uuid) returns boolean language sql as $$
  select exists (select 1 from public.documents_archive where id = p_document);
$$;

-- 1. Responsable du périmètre : le PV standard, jamais une pièce disciplinaire,
--    même celle dont le niveau a été abaissé à « standard ».
select pg_temp.connecter('00000000-0000-4000-8000-b20000000002');
do $$ begin
  assert pg_temp.voit('00000000-0000-4000-8000-b25000000002'), 'responsable : PV standard';
  assert not pg_temp.voit('00000000-0000-4000-8000-b25000000001'), 'responsable : pièce restreinte';
  assert not pg_temp.voit('00000000-0000-4000-8000-b25000000003'), 'responsable : pièce abaissée à standard';
  assert (select count(*) from public.versions_document where document_id = '00000000-0000-4000-8000-b25000000003') = 0,
    'responsable : versions de la pièce abaissée';
end $$;
select set_config('role', 'postgres', true);

-- 2. Membre de la commission K (hors périmètre) : la pièce de son dossier seul.
select pg_temp.connecter('00000000-0000-4000-8000-b20000000003');
do $$ begin
  assert pg_temp.voit('00000000-0000-4000-8000-b25000000001'), 'commission : pièce du dossier qu''elle instruit';
  assert not pg_temp.voit('00000000-0000-4000-8000-b25000000002'), 'commission : PV hors périmètre';
  assert not pg_temp.voit('00000000-0000-4000-8000-b25000000003'), 'commission : pièce d''un autre dossier';
  -- Rattacher la pièce Z à son propre dossier ne lui ouvre pas Z : chaque
  -- dossier rattaché doit être accessible.
  assert not pg_temp.refuse($q$insert into public.pieces_dossier (id, dossier_id, nature, ajoute_le, document_archive_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-b24000000001', 'preuve', now(), '00000000-0000-4000-8000-b25000000003')$q$),
    'commission : ajout d''une pièce à son dossier';
  assert not pg_temp.voit('00000000-0000-4000-8000-b25000000003'), 'commission : pièce Z après rattachement forgé';
end $$;
select set_config('role', 'postgres', true);

-- 3. Pasteur du périmètre : tout ; niveau, origine et nœud immuables.
select pg_temp.connecter('00000000-0000-4000-8000-b20000000001');
do $$ begin
  assert pg_temp.voit('00000000-0000-4000-8000-b25000000001'), 'pasteur : pièce A';
  assert pg_temp.voit('00000000-0000-4000-8000-b25000000002'), 'pasteur : PV B';
  assert pg_temp.voit('00000000-0000-4000-8000-b25000000003'), 'pasteur : pièce Z';
  assert pg_temp.refuse($q$update public.documents_archive set niveau_confidentialite = 'standard'
    where id = '00000000-0000-4000-8000-b25000000001'$q$), 'pasteur : abaisse le niveau';
  assert pg_temp.refuse($q$update public.documents_archive set module_origine = 'comite'
    where id = '00000000-0000-4000-8000-b25000000001'$q$), 'pasteur : change l''origine';
  assert pg_temp.refuse($q$update public.documents_archive set objet_id_origine = 'autre'
    where id = '00000000-0000-4000-8000-b25000000001'$q$), 'pasteur : change l''objet d''origine';
  assert pg_temp.touche($q$update public.documents_archive set statut = 'en_corbeille', date_mise_corbeille = now()
    where id = '00000000-0000-4000-8000-b25000000002'$q$) = 1, 'pasteur : met en corbeille';
end $$;
select set_config('role', 'postgres', true);

-- 4. Simple membre : aucun document.
select pg_temp.connecter('00000000-0000-4000-8000-b20000000004');
do $$ begin
  assert (select count(*) from public.documents_archive where numero_archive like 'T23-%') = 0, 'membre : aucun document';
end $$;
select set_config('role', 'postgres', true);

-- 5. Journal : chacun n'inscrit que sa propre consultation, réelle et permise.
select pg_temp.connecter('00000000-0000-4000-8000-b20000000003');
do $$ begin
  assert not pg_temp.refuse($q$insert into public.consultations_disciplinaires
    (id, dossier_id, document_archive_id, auth_user_id, fidele_id, role) values
    ('00000000-0000-4000-8000-b26000000001', '00000000-0000-4000-8000-b24000000001', '00000000-0000-4000-8000-b25000000001',
     '00000000-0000-4000-8000-b20000000003', '00000000-0000-4000-8000-b22000000003', 'membre')$q$),
    'commission : journalise sa lecture de la pièce A';
  assert pg_temp.refuse($q$insert into public.consultations_disciplinaires
    (id, dossier_id, auth_user_id, fidele_id, role) values
    (gen_random_uuid(), '00000000-0000-4000-8000-b24000000001',
     '00000000-0000-4000-8000-b20000000001', '00000000-0000-4000-8000-b22000000001', 'pasteur')$q$),
    'commission : consultation au nom du pasteur';
  assert pg_temp.refuse($q$insert into public.consultations_disciplinaires
    (id, dossier_id, auth_user_id, fidele_id, role) values
    (gen_random_uuid(), '00000000-0000-4000-8000-b24000000001',
     '00000000-0000-4000-8000-b20000000003', '00000000-0000-4000-8000-b22000000003', 'pasteur')$q$),
    'commission : rôle falsifié';
  assert pg_temp.refuse($q$insert into public.consultations_disciplinaires
    (id, dossier_id, auth_user_id, fidele_id, role) values
    (gen_random_uuid(), '00000000-0000-4000-8000-b24000000002',
     '00000000-0000-4000-8000-b20000000003', '00000000-0000-4000-8000-b22000000003', 'membre')$q$),
    'commission : consultation d''un dossier inaccessible';
  assert pg_temp.refuse($q$insert into public.consultations_disciplinaires
    (id, dossier_id, auth_user_id, fidele_id, role, consulte_le) values
    (gen_random_uuid(), '00000000-0000-4000-8000-b24000000001',
     '00000000-0000-4000-8000-b20000000003', '00000000-0000-4000-8000-b22000000003', 'membre', now() + interval '1 day')$q$),
    'commission : consultation datée dans le futur';
  -- Le journal révèle qui a consulté : il n'est pas ouvert à la commission.
  assert (select count(*) from public.consultations_disciplinaires) = 0, 'commission : lit le journal';
end $$;
select set_config('role', 'postgres', true);

select pg_temp.connecter('00000000-0000-4000-8000-b20000000002');
do $$ begin
  assert pg_temp.refuse($q$insert into public.consultations_disciplinaires
    (id, dossier_id, auth_user_id, fidele_id, role) values
    (gen_random_uuid(), '00000000-0000-4000-8000-b24000000001',
     '00000000-0000-4000-8000-b20000000002', '00000000-0000-4000-8000-b22000000002', 'responsable')$q$),
    'responsable : consultation d''un dossier qu''il ne peut pas lire';
  assert (select count(*) from public.consultations_disciplinaires) = 0, 'responsable : lit le journal';
end $$;
select set_config('role', 'postgres', true);

-- 6. Pasteur : lit le journal, ne peut ni le modifier ni l'effacer.
select pg_temp.connecter('00000000-0000-4000-8000-b20000000001');
do $$ begin
  assert (select count(*) from public.consultations_disciplinaires
          where id = '00000000-0000-4000-8000-b26000000001') = 1, 'pasteur : lit le journal';
  assert pg_temp.refuse($q$update public.consultations_disciplinaires set role = 'pasteur'
    where id = '00000000-0000-4000-8000-b26000000001'$q$), 'pasteur : modifie le journal';
  assert pg_temp.refuse($q$delete from public.consultations_disciplinaires
    where id = '00000000-0000-4000-8000-b26000000001'$q$), 'pasteur : efface le journal';
end $$;
select set_config('role', 'postgres', true);

-- 7. Anonyme : aucun accès au journal.
select set_config('role', 'anon', true);
do $$ begin
  assert pg_temp.refuse('select 1 from public.consultations_disciplinaires'), 'anonyme : lit le journal';
end $$;
select set_config('role', 'postgres', true);

do $$ begin
  assert (select niveau_confidentialite from public.documents_archive
          where id = '00000000-0000-4000-8000-b25000000001') = 'restreint', 'niveau de la pièce A conservé';
  assert (select count(*) from public.consultations_disciplinaires) = 1, 'une seule consultation journalisée';
end $$;

select 'OK — 0023_confidentialite_archives_journal_discipline : toutes les assertions passent';

rollback;
