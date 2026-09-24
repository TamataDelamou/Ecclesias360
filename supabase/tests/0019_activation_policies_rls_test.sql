-- Vérification par exécution réelle de 0019_activation_policies_rls.sql,
-- contre la stack Supabase locale (vrai auth.uid(), vrai rôle authenticated).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0019_activation_policies_rls_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée ; chaque échec interrompt le script.
--
-- Arbre : S (siège) ─┬─ R (région) ── E1 (église)
--                    └─ E2 (église, branche paire de R)
-- Comptes : ADM administrateur d'amorçage sans fiche ; RESP responsable,
-- mandat sur R ; PAST pasteur, mandat sur E1 ; PAST2 pasteur, mandat sur E2 ;
-- MEM membre d'E1 sans mandat ; TRES membre d'E2 trésorier d'E2 ; COM membre
-- d'E2, membre de la commission C2 ; SIMPLE compte sans fiche (RG-SEC-06bis).

begin;

-- ---------------------------------------------------------------- données
insert into auth.users (id, email, aud, role) values
  ('00000000-0000-4000-8000-200000000001', 'adm@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000002', 'resp@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000003', 'past@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000004', 'mem@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000005', 'tres@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000006', 'com@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000007', 'simple@test.local', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-200000000008', 'past2@test.local', 'authenticated', 'authenticated');

insert into public.comptes_utilisateurs (auth_user_id, identifiant, administrateur_amorcage) values
  ('00000000-0000-4000-8000-200000000001', 'adm@test.local', true),
  ('00000000-0000-4000-8000-200000000007', 'simple@test.local', false);

insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path, categorie_confessionnelle) values
  ('00000000-0000-4000-8000-100000000001', 'siege', 'Siège', 'T-S', null,
   '/00000000-0000-4000-8000-100000000001/', null),
  ('00000000-0000-4000-8000-100000000002', 'region', 'Région', 'T-R', '00000000-0000-4000-8000-100000000001',
   '/00000000-0000-4000-8000-100000000001/00000000-0000-4000-8000-100000000002/', null),
  ('00000000-0000-4000-8000-100000000003', 'eglise_locale', 'Église 1', 'T-E1', '00000000-0000-4000-8000-100000000002',
   '/00000000-0000-4000-8000-100000000001/00000000-0000-4000-8000-100000000002/00000000-0000-4000-8000-100000000003/', 'autres'),
  ('00000000-0000-4000-8000-100000000004', 'eglise_locale', 'Église 2', 'T-E2', '00000000-0000-4000-8000-100000000001',
   '/00000000-0000-4000-8000-100000000001/00000000-0000-4000-8000-100000000004/', 'autres');

insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, role, auth_user_id) values
  ('00000000-0000-4000-8000-300000000002', '00000000-0000-4000-8000-100000000003', 'Resp', 'R', '1980-01-01', 'masculin', 'marie', 'responsable', '00000000-0000-4000-8000-200000000002'),
  ('00000000-0000-4000-8000-300000000003', '00000000-0000-4000-8000-100000000003', 'Past', 'P', '1970-01-01', 'masculin', 'marie', 'pasteur', '00000000-0000-4000-8000-200000000003'),
  ('00000000-0000-4000-8000-300000000004', '00000000-0000-4000-8000-100000000003', 'Mem', 'M', '1990-01-01', 'feminin', 'celibataire', 'membre', '00000000-0000-4000-8000-200000000004'),
  ('00000000-0000-4000-8000-300000000005', '00000000-0000-4000-8000-100000000004', 'Tres', 'T', '1985-01-01', 'masculin', 'marie', 'membre', '00000000-0000-4000-8000-200000000005'),
  ('00000000-0000-4000-8000-300000000006', '00000000-0000-4000-8000-100000000004', 'Com', 'C', '1975-01-01', 'feminin', 'marie', 'membre', '00000000-0000-4000-8000-200000000006'),
  ('00000000-0000-4000-8000-300000000007', '00000000-0000-4000-8000-100000000004', 'Autre', 'A', '1995-01-01', 'masculin', 'celibataire', 'membre', null),
  ('00000000-0000-4000-8000-300000000008', '00000000-0000-4000-8000-100000000003', 'FideleE1', 'F', '2000-01-01', 'feminin', 'celibataire', 'membre', null),
  ('00000000-0000-4000-8000-300000000009', '00000000-0000-4000-8000-100000000004', 'Past2', 'P', '1972-01-01', 'masculin', 'marie', 'pasteur', '00000000-0000-4000-8000-200000000008');

insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
  (gen_random_uuid(), '00000000-0000-4000-8000-100000000002', '00000000-0000-4000-8000-300000000002', 'responsable régional'),
  (gen_random_uuid(), '00000000-0000-4000-8000-100000000003', '00000000-0000-4000-8000-300000000003', 'pasteur principal'),
  (gen_random_uuid(), '00000000-0000-4000-8000-100000000004', '00000000-0000-4000-8000-300000000009', 'pasteur principal');

insert into public.tresoriers_noeud (id, fidele_id, noeud_id, date_debut) values
  (gen_random_uuid(), '00000000-0000-4000-8000-300000000005', '00000000-0000-4000-8000-100000000004', now());

insert into public.commissions_disciplinaires (id, noeud_id, nom) values
  ('00000000-0000-4000-8000-400000000002', '00000000-0000-4000-8000-100000000004', 'Commission E2');
insert into public.membres_commission_disciplinaire (id, commission_id, fidele_id) values
  (gen_random_uuid(), '00000000-0000-4000-8000-400000000002', '00000000-0000-4000-8000-300000000006');

insert into public.dossiers_disciplinaires (id, fidele_id, noeud_id, nature_faute_id, date_ouverture, commission_id) values
  ('00000000-0000-4000-8000-500000000001', '00000000-0000-4000-8000-300000000004', '00000000-0000-4000-8000-100000000003',
   (select id from public.natures_faute limit 1), now(), null),
  ('00000000-0000-4000-8000-500000000002', '00000000-0000-4000-8000-300000000007', '00000000-0000-4000-8000-100000000004',
   (select id from public.natures_faute limit 1), now(), '00000000-0000-4000-8000-400000000002');

-- (saisie_par_fidele_id : 0021 — chaque saisie trace son auteur.)
insert into public.contributions (id, fidele_id, type_offrande_id, montant, devise, noeud_id, mode_paiement, origine, date_saisie, statut, saisie_par_fidele_id) values
  ('00000000-0000-4000-8000-600000000001', '00000000-0000-4000-8000-300000000004', (select id from public.types_offrande limit 1),
   1000, 'GNF', '00000000-0000-4000-8000-100000000003', 'especes', 'mobile', now(), 'en_attente', '00000000-0000-4000-8000-300000000004'),
  ('00000000-0000-4000-8000-600000000002', '00000000-0000-4000-8000-300000000007', (select id from public.types_offrande limit 1),
   5000, 'GNF', '00000000-0000-4000-8000-100000000004', 'especes', 'mobile', now(), 'en_attente', '00000000-0000-4000-8000-300000000007');

insert into public.documents_archive (id, numero_archive, type_document, module_origine, objet_id_origine, noeud_id, fichier, date_archivage, niveau_confidentialite) values
  ('00000000-0000-4000-8000-700000000001', 'T-DOC-1', 'pv', 'comite', 'x', '00000000-0000-4000-8000-100000000003', 'f1', now(), 'standard'),
  ('00000000-0000-4000-8000-700000000002', 'T-DOC-2', 'piece', 'discipline', 'x', '00000000-0000-4000-8000-100000000003', 'f2', now(), 'restreint'),
  ('00000000-0000-4000-8000-700000000003', 'T-DOC-3', 'piece', 'discipline', 'x', '00000000-0000-4000-8000-100000000004', 'f3', now(), 'restreint');
insert into public.pieces_dossier (id, dossier_id, nature, ajoute_le, document_archive_id) values
  (gen_random_uuid(), '00000000-0000-4000-8000-500000000002', 'temoignage', now(), '00000000-0000-4000-8000-700000000003');

insert into public.cultes (id, noeud_id, date_heure, type_culte) values
  ('00000000-0000-4000-8000-800000000001', '00000000-0000-4000-8000-100000000003', now(), 'dominical'),
  ('00000000-0000-4000-8000-800000000002', '00000000-0000-4000-8000-100000000004', now(), 'dominical');

insert into public.contenus_mediatheque (id, type_contenu, titre, noeud_editeur_id, theme, date_contenu, statut, moderation_a_priori) values
  ('00000000-0000-4000-8000-900000000001', 'audio', 'Publié', '00000000-0000-4000-8000-100000000003', 'foi', now(), 'publie', false),
  ('00000000-0000-4000-8000-900000000002', 'audio', 'Brouillon', '00000000-0000-4000-8000-100000000003', 'foi', now(), 'brouillon', false),
  ('00000000-0000-4000-8000-900000000003', 'video', 'Modéré a priori', '00000000-0000-4000-8000-100000000003', 'foi', now(), 'publie', true);
insert into public.commentaires (id, contenu_id, fidele_id, texte, date, statut_moderation) values
  (gen_random_uuid(), '00000000-0000-4000-8000-900000000001', '00000000-0000-4000-8000-300000000007', 'visible', now(), 'publie'),
  (gen_random_uuid(), '00000000-0000-4000-8000-900000000001', '00000000-0000-4000-8000-300000000007', 'masqué', now(), 'masque');

insert into public.periodes_comptables (id, exercice, date_debut, date_fin, statut) values
  ('00000000-0000-4000-8000-a00000000001', 2025, '2025-01-01', '2025-12-31', 'cloturee'),
  ('00000000-0000-4000-8000-a00000000002', 2026, '2026-01-01', '2026-12-31', 'ouverte');
insert into public.ecritures_comptables (id, date, compte_id, noeud_id, periode_id) values
  ('00000000-0000-4000-8000-b00000000001', now(), (select id from public.comptes_comptables limit 1),
   '00000000-0000-4000-8000-100000000003', '00000000-0000-4000-8000-a00000000002');

insert into public.journal_liaisons_comptes (auth_user_id, identifiant, issue, statut) values
  ('00000000-0000-4000-8000-200000000007', 'simple@test.local', 'aucune_correspondance', 'consigne');

-- ---------------------------------------------------------------- outils
create or replace function pg_temp.connecter(p_uid uuid) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', json_build_object('sub', p_uid, 'role', 'authenticated')::text, true);
  perform set_config('role', 'authenticated', true);
end $$;

-- Nombre de lignes visibles d'une table pour la session courante.
create or replace function pg_temp.nb(p_table text) returns bigint language plpgsql as $$
declare n bigint;
begin
  execute format('select count(*) from public.%I', p_table) into n;
  return n;
end $$;

-- Vrai si l'instruction est refusée (RLS ou privilège de colonne).
create or replace function pg_temp.refuse(p_sql text) returns boolean language plpgsql as $$
begin
  execute p_sql;
  return false;
exception when insufficient_privilege then
  return true;
end $$;

-- Nombre de lignes réellement touchées (une policy USING filtre sans erreur).
create or replace function pg_temp.touche(p_sql text) returns bigint language plpgsql as $$
declare n bigint;
begin
  execute p_sql;
  get diagnostics n = row_count;
  return n;
end $$;

-- ---------------------------------------------------------------- 0. couverture
do $$
declare v text;
begin
  select string_agg(c.relname, ', ') into v
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
  where n.nspname = 'public' and c.relkind = 'r'
    and (not c.relrowsecurity
         or not exists (select 1 from pg_policies p where p.schemaname = 'public' and p.tablename = c.relname));
  assert v is null, 'tables sans RLS ou sans policy : ' || v;

  select string_agg(policyname, ', ') into v from pg_policies
  where schemaname = 'public' and roles <> '{authenticated}';
  assert v is null, 'policies ouvertes à un autre rôle que authenticated : ' || v;

  select string_agg(policyname, ', ') into v from pg_policies
  where schemaname = 'public' and (qual = 'true' or with_check = 'true');
  assert v is null, 'policies inconditionnelles : ' || v;
end $$;

-- ---------------------------------------------------------------- 1. anon : rien
select set_config('role', 'anon', true);
do $$ begin
  assert pg_temp.nb('fideles') = 0, 'anon lit des fidèles';
  assert pg_temp.nb('contenus_mediatheque') = 0, 'anon lit la médiathèque';
  assert pg_temp.nb('organisation_nodes') = 0, 'anon lit l''arbre';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 2. utilisateur simple (RG-SEC-06bis)
select pg_temp.connecter('00000000-0000-4000-8000-200000000007');
do $$ begin
  assert pg_temp.nb('fideles') = 0, 'simple : fidèles';
  assert pg_temp.nb('organisation_nodes') = 0, 'simple : arbre';
  assert pg_temp.nb('cultes') = 0, 'simple : cultes';
  assert pg_temp.nb('contributions') = 0, 'simple : contributions';
  assert pg_temp.nb('types_offrande') = 0, 'simple : référentiel';
  assert pg_temp.nb('contenus_mediatheque') = 2, 'simple : seuls les contenus publiés';
  assert pg_temp.nb('commentaires') = 1, 'simple : seuls les commentaires publiés';
  assert pg_temp.nb('comptes_utilisateurs') = 1, 'simple : son compte';
  assert pg_temp.nb('journal_liaisons_comptes') = 0, 'simple : journal';
  assert pg_temp.refuse($q$insert into public.commentaires (id, contenu_id, fidele_id, texte, date) values
    (gen_random_uuid(), '00000000-0000-4000-8000-900000000001', '00000000-0000-4000-8000-300000000007', 'x', now())$q$),
    'simple : commente (lecture seule)';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 3. membre sans mandat (O)
select pg_temp.connecter('00000000-0000-4000-8000-200000000004');
do $$ begin
  assert pg_temp.nb('fideles') = 1, 'membre : sa fiche seulement';
  assert pg_temp.nb('organisation_nodes') = 1, 'membre : son église seulement';
  assert pg_temp.nb('cultes') = 1, 'membre : les cultes de son église';
  assert pg_temp.nb('contributions') = 1, 'membre : ses contributions';
  assert pg_temp.nb('dossiers_disciplinaires') = 0, 'membre : lit un dossier (même le sien)';
  assert pg_temp.nb('documents_archive') = 0, 'membre : archives';
  assert pg_temp.nb('types_offrande') > 0, 'membre : référentiel';
  assert pg_temp.touche($q$update public.contributions set statut = 'validee'
    where id = '00000000-0000-4000-8000-600000000001'$q$) = 0, 'membre : valide sa propre offrande';
  assert pg_temp.refuse($q$insert into public.contributions (id, fidele_id, type_offrande_id, montant, devise, noeud_id, mode_paiement, origine, date_saisie, statut, saisie_par_fidele_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-300000000004', (select id from public.types_offrande limit 1), 1, 'GNF',
            '00000000-0000-4000-8000-100000000003', 'especes', 'mobile', now(), 'validee', '00000000-0000-4000-8000-300000000004')$q$), 'membre : saisit une offrande déjà validée';
  assert not pg_temp.refuse($q$insert into public.contributions (id, fidele_id, type_offrande_id, montant, devise, noeud_id, mode_paiement, origine, date_saisie, saisie_par_fidele_id)
    values (gen_random_uuid(), '00000000-0000-4000-8000-300000000004', (select id from public.types_offrande limit 1), 1, 'GNF',
            '00000000-0000-4000-8000-100000000003', 'especes', 'mobile', now(), '00000000-0000-4000-8000-300000000004')$q$), 'membre : saisie personnelle en attente';
  assert pg_temp.refuse($q$update public.fideles set role = 'administrateur'
    where id = '00000000-0000-4000-8000-300000000004'$q$), 'membre : s''élève administrateur';
  assert pg_temp.refuse($q$insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
    (gen_random_uuid(), '00000000-0000-4000-8000-100000000003', '00000000-0000-4000-8000-300000000004', 'x')$q$),
    'membre : se donne un mandat';
  -- Commentaire : le statut initial est imposé par le contenu (RG-XIII-03).
  assert pg_temp.refuse($q$insert into public.commentaires (id, contenu_id, fidele_id, texte, date, statut_moderation) values
    (gen_random_uuid(), '00000000-0000-4000-8000-900000000003', '00000000-0000-4000-8000-300000000004', 'x', now(), 'publie')$q$),
    'membre : contourne la modération a priori';
  assert not pg_temp.refuse($q$insert into public.commentaires (id, contenu_id, fidele_id, texte, date, statut_moderation) values
    (gen_random_uuid(), '00000000-0000-4000-8000-900000000003', '00000000-0000-4000-8000-300000000004', 'x', now(), 'en_attente')$q$),
    'membre : commentaire en attente';
  assert pg_temp.refuse($q$insert into public.commentaires (id, contenu_id, fidele_id, texte, date) values
    (gen_random_uuid(), '00000000-0000-4000-8000-900000000001', '00000000-0000-4000-8000-300000000007', 'x', now())$q$),
    'membre : commente au nom d''un autre';
  assert pg_temp.touche($q$update public.commentaires set statut_moderation = 'publie'$q$) = 0, 'membre : modère';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 4. responsable, mandat sur R (P)
select pg_temp.connecter('00000000-0000-4000-8000-200000000002');
do $$ begin
  assert pg_temp.nb('fideles') = 4, 'responsable : les fidèles de R et descendants (E1), pas E2';
  assert pg_temp.nb('organisation_nodes') = 4, 'responsable : annuaire complet';
  assert pg_temp.nb('contributions') = 0, 'responsable (non pasteur, non trésorier) : lit des contributions';
  assert pg_temp.nb('dossiers_disciplinaires') = 0, 'responsable : dossiers';
  assert pg_temp.nb('documents_archive') = 1, 'responsable : archives standard de son périmètre seulement';
  assert pg_temp.nb('cultes') = 1, 'responsable : cultes de son périmètre';
  assert not pg_temp.refuse($q$insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
    (gen_random_uuid(), 'district', 'D', 'T-D1', '00000000-0000-4000-8000-100000000002', '/x/')$q$), 'responsable : nœud enfant dans son périmètre';
  assert pg_temp.refuse($q$insert into public.organisation_nodes (id, type_noeud, nom, code_interne, noeud_parent_id, path) values
    (gen_random_uuid(), 'district', 'D', 'T-D2', '00000000-0000-4000-8000-100000000001', '/x/')$q$), 'responsable : nœud sous le siège';
  assert pg_temp.refuse($q$insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil) values
    (gen_random_uuid(), '00000000-0000-4000-8000-100000000004', 'X', 'Y', '2000-01-01', 'masculin', 'marie')$q$), 'responsable : fidèle hors périmètre';
  assert not pg_temp.refuse($q$insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil) values
    (gen_random_uuid(), '00000000-0000-4000-8000-100000000003', 'X', 'Y', '2000-01-01', 'masculin', 'marie')$q$), 'responsable : fidèle dans son périmètre';
  assert pg_temp.touche($q$update public.fideles set nom = 'Z'
    where id = '00000000-0000-4000-8000-300000000007'$q$) = 0, 'responsable : modifie un fidèle d''E2';
  assert pg_temp.refuse($q$update public.fideles set role = 'administrateur'
    where id = '00000000-0000-4000-8000-300000000002'$q$), 'responsable : modifie un rôle';
  assert pg_temp.refuse($q$update public.fideles set auth_user_id = null
    where id = '00000000-0000-4000-8000-300000000008'$q$), 'responsable : modifie une liaison de compte';
  assert pg_temp.refuse($q$insert into public.node_responsables (id, noeud_id, fidele_id, fonction) values
    (gen_random_uuid(), '00000000-0000-4000-8000-100000000003', '00000000-0000-4000-8000-300000000008', 'x')$q$),
    'responsable (non pasteur) : désigne un responsable';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 5. pasteur, mandat sur E1
select pg_temp.connecter('00000000-0000-4000-8000-200000000003');
do $$ begin
  -- 4 fixtures + le fidèle créé par le responsable en section 4.
  assert pg_temp.nb('fideles') = 5, 'pasteur E1 : fidèles d''E1';
  assert pg_temp.nb('dossiers_disciplinaires') = 1, 'pasteur E1 : dossier d''E1 seulement';
  assert pg_temp.nb('documents_archive') = 2, 'pasteur E1 : standard + restreint d''E1, pas E2';
  assert pg_temp.nb('pieces_dossier') = 0, 'pasteur E1 : pièces d''un dossier d''E2';
  assert pg_temp.nb('contributions') >= 1, 'pasteur E1 : contributions d''E1';
  assert pg_temp.touche($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-300000000003'
    where id = '00000000-0000-4000-8000-600000000001'$q$) = 1, 'pasteur E1 : valide une contribution d''E1';
  assert pg_temp.touche($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-300000000003'
    where id = '00000000-0000-4000-8000-600000000002'$q$) = 0, 'pasteur E1 : valide une contribution d''E2';
  assert pg_temp.nb('journal_liaisons_comptes') = 0, 'pasteur : journal des liaisons';
  -- RG-XI-05 : une fois validée, plus aucune modification.
  -- (0021 : le montant n'est plus du tout modifiable, privilège de colonne.)
  assert pg_temp.refuse($q$update public.contributions set montant = 1
    where id = '00000000-0000-4000-8000-600000000001'$q$), 'pasteur E1 : modifie une contribution validée';
  assert pg_temp.touche($q$update public.contributions set motif_rejet = 'x'
    where id = '00000000-0000-4000-8000-600000000001'$q$) = 0, 'pasteur E1 : retouche une contribution validée';
  -- RG-XXI-03/05 : écriture immuable sauf rapprochement, jamais en période clôturée.
  assert pg_temp.refuse($q$update public.ecritures_comptables set noeud_id = noeud_id
    where id = '00000000-0000-4000-8000-b00000000001'$q$), 'pasteur E1 : modifie une écriture';
  assert pg_temp.touche($q$update public.ecritures_comptables set rapproche = true
    where id = '00000000-0000-4000-8000-b00000000001'$q$) = 1, 'pasteur E1 : rapproche une écriture';
  assert pg_temp.refuse($q$insert into public.ecritures_comptables (id, date, compte_id, noeud_id, periode_id) values
    (gen_random_uuid(), now(), (select id from public.comptes_comptables limit 1),
     '00000000-0000-4000-8000-100000000003', '00000000-0000-4000-8000-a00000000001')$q$), 'pasteur E1 : écrit en période clôturée';
  assert not pg_temp.refuse($q$insert into public.ecritures_comptables (id, date, compte_id, noeud_id, periode_id) values
    (gen_random_uuid(), now(), (select id from public.comptes_comptables limit 1),
     '00000000-0000-4000-8000-100000000003', '00000000-0000-4000-8000-a00000000002')$q$), 'pasteur E1 : écrit en période ouverte';
  -- Aucune suppression hors des tables où l'application supprime réellement.
  assert pg_temp.touche($q$delete from public.cultes where noeud_id = '00000000-0000-4000-8000-100000000003'$q$) = 0,
    'pasteur E1 : supprime un culte';
  assert pg_temp.touche($q$delete from public.periodes_comptables$q$) = 0, 'pasteur : supprime un exercice';
  assert pg_temp.touche($q$delete from public.node_responsables$q$) = 0, 'pasteur : supprime un mandat';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 6. pasteur, mandat sur E2 (branche paire)
select pg_temp.connecter('00000000-0000-4000-8000-200000000008');
do $$ begin
  assert pg_temp.nb('dossiers_disciplinaires') = 1, 'pasteur E2 : dossier d''E2 seulement';
  assert pg_temp.nb('pieces_dossier') = 1, 'pasteur E2 : pièce du dossier d''E2';
  assert pg_temp.nb('documents_archive') = 1, 'pasteur E2 : restreint d''E2 seulement';
  assert pg_temp.nb('fideles') = 4, 'pasteur E2 : fidèles d''E2';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 7. trésorier d'E2, rôle membre (C)
select pg_temp.connecter('00000000-0000-4000-8000-200000000005');
do $$ begin
  assert pg_temp.nb('fideles') = 1, 'trésorier : sa fiche seulement (pas de périmètre)';
  assert pg_temp.nb('contributions') = 1, 'trésorier : contributions d''E2';
  assert pg_temp.touche($q$update public.contributions set statut = 'validee', valide_par_fidele_id = '00000000-0000-4000-8000-300000000005'
    where id = '00000000-0000-4000-8000-600000000002'$q$) = 1, 'trésorier : valide une contribution d''E2';
  assert pg_temp.touche($q$update public.contributions set statut = 'rejetee'
    where id = '00000000-0000-4000-8000-600000000001'$q$) = 0, 'trésorier d''E2 : touche E1';
  assert pg_temp.nb('dossiers_disciplinaires') = 0, 'trésorier : dossiers';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 8. membre de la commission C2 (C)
select pg_temp.connecter('00000000-0000-4000-8000-200000000006');
do $$ begin
  assert pg_temp.nb('dossiers_disciplinaires') = 1, 'commission : le dossier assigné';
  assert pg_temp.nb('pieces_dossier') = 1, 'commission : ses pièces';
  assert pg_temp.nb('documents_archive') = 1, 'commission : le document restreint de la pièce';
  assert pg_temp.nb('fideles') = 1, 'commission : sa fiche seulement';
  assert pg_temp.nb('contributions') = 0, 'commission : finances';
  assert not pg_temp.refuse($q$insert into public.dossiers_disciplinaires (id, fidele_id, noeud_id, nature_faute_id, date_ouverture) values
    (gen_random_uuid(), '00000000-0000-4000-8000-300000000007', '00000000-0000-4000-8000-100000000004',
     (select id from public.natures_faute limit 1), now())$q$), 'commission : ouvre un dossier à son nœud (RG-X-01)';
  assert pg_temp.refuse($q$insert into public.dossiers_disciplinaires (id, fidele_id, noeud_id, nature_faute_id, date_ouverture) values
    (gen_random_uuid(), '00000000-0000-4000-8000-300000000008', '00000000-0000-4000-8000-100000000003',
     (select id from public.natures_faute limit 1), now())$q$), 'commission : ouvre un dossier à un autre nœud';
end $$;
select set_config('role', 'postgres', true);

-- ---------------------------------------------------------------- 9. administrateur d'amorçage (non borné)
select pg_temp.connecter('00000000-0000-4000-8000-200000000001');
do $$ begin
  assert pg_temp.nb('fideles') >= 8, 'administrateur : tous les fidèles';
  assert pg_temp.nb('dossiers_disciplinaires') >= 2, 'administrateur : tous les dossiers';
  assert pg_temp.nb('documents_archive') = 3, 'administrateur : toutes les archives';
  assert pg_temp.nb('journal_liaisons_comptes') >= 1, 'administrateur : journal des liaisons';
  assert pg_temp.nb('comptes_utilisateurs') >= 2, 'administrateur : comptes';
  assert pg_temp.nb('contenus_mediatheque') = 3, 'administrateur : brouillons compris';
  assert not pg_temp.refuse($q$insert into public.types_offrande (id, code, libelle) values
    (gen_random_uuid(), 'test_rls', 'Test')$q$), 'administrateur : référentiel';
end $$;
select set_config('role', 'postgres', true);

-- Écriture de référentiel refusée à un pasteur (G).
select pg_temp.connecter('00000000-0000-4000-8000-200000000003');
do $$ begin
  assert pg_temp.refuse($q$insert into public.types_offrande (id, code, libelle) values
    (gen_random_uuid(), 'test_rls2', 'Test')$q$), 'pasteur : écrit un référentiel global';
end $$;
select set_config('role', 'postgres', true);

select 'OK — 0019_activation_policies_rls : toutes les assertions passent';

rollback;
