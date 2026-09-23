-- Vérification par exécution réelle de 0018_authentification.sql (RG-SEC-01),
-- contre la stack Supabase locale (vrai schéma auth, vrai auth.uid()).
-- Exécution : psql -v ON_ERROR_STOP=1 -f supabase/tests/0018_authentification_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
-- Tout se déroule dans une transaction annulée : aucune donnée ne subsiste.
-- Chaque échec lève une exception (assert) et interrompt le script.

begin;

-- Comptes Supabase Auth de test (téléphone stocké sans « + », comme GoTrue).
insert into auth.users (id, phone, email, aud, role) values
  ('00000000-0000-4000-8000-000000000001', '224629999001', null, 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-000000000002', '224629999002', null, 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-000000000003', '224629999003', null, 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-000000000005', null, 'Pasteur@Eglise.org', 'authenticated', 'authenticated'),
  ('00000000-0000-4000-8000-000000000006', '224629999009', null, 'authenticated', 'authenticated');

-- Simule la session d'un compte : mêmes réglages que PostgREST.
create or replace function pg_temp.connecter(p_uid uuid) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', json_build_object('sub', p_uid, 'role', 'authenticated')::text, true);
  perform set_config('role', 'authenticated', true);
end $$;

create or replace function pg_temp.deconnecter() returns void language plpgsql as $$
begin
  perform set_config('role', 'postgres', true);
  perform set_config('request.jwt.claims', '', true);
end $$;

-- 1. Normalisation E.164, miroir de IdentifiantRules.
do $$ begin
  assert public.normaliser_telephone('+224 629 99-90.01') = '+224629999001', 'séparateurs';
  assert public.normaliser_telephone('00224629999001') = '+224629999001', 'préfixe 00';
  assert public.normaliser_telephone('620000001') is null, 'national refusé';
  assert public.normaliser_telephone('+0224629999001') is null, 'indicatif 0 refusé';
end $$;

-- 2. Base vide : premier compte administrateur d'amorçage.
select pg_temp.connecter('00000000-0000-4000-8000-000000000001');
do $$ begin
  assert public.enregistrer_compte_courant() = 'administrateur_amorcage', 'amorçage attendu';
  assert public.role_courant() = 'administrateur', 'rôle amorçage';
end $$;
select pg_temp.deconnecter();

-- Données : un siège, une fiche par numéro, deux fiches sur le même numéro, une fiche e-mail.
insert into public.organisation_nodes (id, type_noeud, nom, code_interne, path, depth)
values ('10000000-0000-4000-8000-000000000001', 'siege', 'GSG', 'GSG-SIEGE', '/10000000-0000-4000-8000-000000000001/', 0);
insert into public.fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, telephone, email) values
  ('20000000-0000-4000-8000-000000000002', '10000000-0000-4000-8000-000000000001', 'Camara', 'Aïssata', '1990-01-01', 'feminin', 'celibataire', '+224 629 99 90 02', null),
  ('20000000-0000-4000-8000-000000000031', '10000000-0000-4000-8000-000000000001', 'Diallo', 'A', '1990-01-01', 'masculin', 'marie', '00224629999003', null),
  ('20000000-0000-4000-8000-000000000032', '10000000-0000-4000-8000-000000000001', 'Diallo', 'B', '1990-01-01', 'masculin', 'marie', '+224629999003', null),
  ('20000000-0000-4000-8000-000000000005', '10000000-0000-4000-8000-000000000001', 'Bah', 'Paul', '1980-01-01', 'masculin', 'marie', null, 'pasteur@eglise.org');

-- 3. Liaison automatique par téléphone (fiche saisie avec séparateurs).
select pg_temp.connecter('00000000-0000-4000-8000-000000000002');
do $$ begin
  assert public.enregistrer_compte_courant() = 'lie_automatiquement', 'liaison auto';
  assert public.fidele_courant_id() = '20000000-0000-4000-8000-000000000002', 'fidele_courant_id';
  assert public.role_courant() = 'membre', 'rôle de la fiche';
  -- Reconnexion : aucune nouvelle décision.
  assert public.enregistrer_compte_courant() = 'deja_lie', 'reconnexion';
end $$;

-- 4. Le client ne peut jamais écrire le lien ni le rôle directement.
do $$ begin
  begin
    update public.fideles set role = 'administrateur' where id = '20000000-0000-4000-8000-000000000002';
    assert false, 'mise à jour du rôle aurait dû être refusée';
  exception when insufficient_privilege then null;
  end;
  begin
    update public.fideles set auth_user_id = auth.uid() where id = '20000000-0000-4000-8000-000000000031';
    assert false, 'mise à jour du lien aurait dû être refusée';
  exception when insufficient_privilege then null;
  end;
end $$;
select pg_temp.deconnecter();

-- 5. Correspondance multiple : utilisateur simple, conflit en attente.
select pg_temp.connecter('00000000-0000-4000-8000-000000000003');
do $$ begin
  assert public.enregistrer_compte_courant() = 'correspondance_multiple', 'multiple';
  assert public.role_courant() = 'utilisateur_simple', 'simple si multiple';
  assert public.fidele_courant_id() is null, 'aucune fiche liée';
end $$;
select pg_temp.deconnecter();
do $$ begin
  assert (select statut from public.journal_liaisons_comptes
          where auth_user_id = '00000000-0000-4000-8000-000000000003') = 'en_attente', 'conflit en attente';
end $$;

-- 6. Correspondance e-mail insensible à la casse.
select pg_temp.connecter('00000000-0000-4000-8000-000000000005');
do $$ begin
  assert public.enregistrer_compte_courant() = 'lie_automatiquement', 'liaison e-mail';
end $$;
select pg_temp.deconnecter();

-- 7. Garde-fou SIM churn : le numéro du compte 2 est recyclé (compte 6
-- reçoit +224629999002 après suppression du compte 2).
delete from auth.users where id = '00000000-0000-4000-8000-000000000002';
do $$ begin
  assert (select auth_user_id from public.fideles where id = '20000000-0000-4000-8000-000000000002') is null,
    'lien vidé par on delete set null';
end $$;
update auth.users set phone = '224629999002' where id = '00000000-0000-4000-8000-000000000006';
select pg_temp.connecter('00000000-0000-4000-8000-000000000006');
do $$ begin
  assert public.enregistrer_compte_courant() = 'fiche_deja_liee', 'fiche liée par le passé protégée';
  assert public.role_courant() = 'utilisateur_simple', 'nouveau titulaire simple';
  assert public.fidele_courant_id() is null, 'pas de liaison au nouveau titulaire';
end $$;

-- 8. Résolution réservée à un administrateur.
do $$ begin
  begin
    perform public.resoudre_conflit_liaison(gen_random_uuid(), true);
    assert false, 'résolution par un non-administrateur aurait dû être refusée';
  exception when insufficient_privilege then null;
  end;
end $$;
select pg_temp.deconnecter();

-- 9. L'administrateur d'amorçage choisit la fiche d'un conflit multiple ; tracé.
-- (Identifiant du conflit lu en postgres : les policies de lecture arrivent en 0019.)
select set_config('test.conflit', (select id::text from public.journal_liaisons_comptes where issue = 'correspondance_multiple'), true);
select pg_temp.connecter('00000000-0000-4000-8000-000000000001');
do $$
declare v_id uuid := current_setting('test.conflit')::uuid;
begin
  perform public.resoudre_conflit_liaison(v_id, true, '20000000-0000-4000-8000-000000000032');
  begin
    perform public.resoudre_conflit_liaison(v_id, false);
    assert false, 'double résolution aurait dû être refusée';
  exception when invalid_parameter_value then null;
  end;
end $$;
select pg_temp.deconnecter();
do $$
declare v_id uuid := current_setting('test.conflit')::uuid;
begin
  assert (select auth_user_id from public.fideles where id = '20000000-0000-4000-8000-000000000032')
    = '00000000-0000-4000-8000-000000000003', 'fiche liée par l''administrateur';
  assert (select statut from public.journal_liaisons_comptes where id = v_id) = 'resolu_lie', 'statut résolu';
  assert (select resolu_par_auth_user_id from public.journal_liaisons_comptes where id = v_id)
    = '00000000-0000-4000-8000-000000000001', 'auteur de la résolution tracé';
end $$;

-- 10. Anonyme : aucune exécution possible.
set local role anon;
do $$ begin
  begin
    perform public.enregistrer_compte_courant();
    assert false, 'anon ne doit pas pouvoir exécuter';
  exception when insufficient_privilege then null;
  end;
end $$;
reset role;

select 'OK — 0018_authentification : toutes les assertions passent' as resultat;
rollback;
