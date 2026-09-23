-- RG-SEC-01 — Authentification native Supabase Auth sans mot de passe
-- (signInWithOtp / verifyOtp : SMS, WhatsApp, Magic Link, code e-mail) et
-- liaison d'un compte authentifié à une fiche fidèle.
-- Dépend de fideles (0002) et des helpers de 0004, créés avant ce fichier.
--
-- Miroir SQL de `LiaisonCompteRules` / `CompteRepository` (Dart) : les deux
-- doivent rester strictement équivalents, même précédent que
-- `noeuds_du_perimetre()` ↔ `PerimetreRules`. La synchronisation distante
-- n'étant active pour aucun module, la décision est aujourd'hui prise
-- localement par l'application ; cette fonction est la source de vérité
-- serveur dès que la synchronisation des fidèles sera branchée.
--
-- RG-SEC-01bis (fédération GSG ID : vérification JWKS, liste blanche de
-- projets) n'est PAS construit ici : le GSG Platform Kernel n'est configuré
-- sur aucun environnement accessible (voir AGENTS.md §11).
--
-- Les policies RLS de ces tables sont dans 0019 (activation groupée).

-- Compte authentifié : état qui n'a pas sa place sur une fiche fidèle
-- (administrateur d'amorçage sans fiche, identifiant vérifié).
create table if not exists public.comptes_utilisateurs (
  auth_user_id uuid primary key references auth.users(id) on delete cascade,
  identifiant text not null,
  administrateur_amorcage boolean not null default false,
  cree_le timestamptz not null default now()
);

alter table public.comptes_utilisateurs enable row level security;

-- Journal de toute liaison (ou non-liaison) d'un compte à une fiche, et de
-- sa résolution par un administrateur. Aucune clé étrangère vers
-- auth.users : la trace survit à la suppression du compte — c'est elle qui
-- protège une fiche déjà liée une fois contre le recyclage de numéros de
-- téléphone (SIM churn).
create table if not exists public.journal_liaisons_comptes (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid not null,
  identifiant text not null,
  fidele_id uuid references public.fideles(id) on delete set null,
  issue text not null check (issue in (
    'lie_automatiquement', 'administrateur_amorcage', 'aucune_correspondance',
    'correspondance_multiple', 'fiche_deja_liee'
  )),
  statut text not null check (statut in ('consigne', 'en_attente', 'resolu_lie', 'resolu_rejete')),
  resolu_par_auth_user_id uuid,
  resolu_le timestamptz,
  cree_le timestamptz not null default now()
);

create index if not exists idx_journal_liaisons_auth_user on public.journal_liaisons_comptes (auth_user_id);
create index if not exists idx_journal_liaisons_fidele on public.journal_liaisons_comptes (fidele_id);

alter table public.journal_liaisons_comptes enable row level security;

-- Le lien compte ↔ fiche et le rôle ne s'écrivent jamais directement par un
-- client : seulement via les fonctions security definer ci-dessous (et, pour
-- le rôle, un futur écran d'administration des rôles). Le privilège
-- UPDATE/INSERT de table couvrirait toutes les colonnes : il est retiré puis
-- regranté colonne par colonne, sans auth_user_id ni role.
revoke insert, update on public.fideles from anon, authenticated;
grant insert (
  id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, statut_spirituel, statut,
  date_conversion, date_bapteme, eglise_provenance, photo_url, telephone, email, adresse,
  created_at, updated_at
) on public.fideles to authenticated;
grant update (
  noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, statut_spirituel, statut,
  date_conversion, date_bapteme, eglise_provenance, photo_url, telephone, email, adresse,
  updated_at
) on public.fideles to authenticated;

-- Normalisation E.164 (KER-ID-06), miroir de IdentifiantRules.normaliserTelephone :
-- séparateurs retirés, 00 → +, null si non réductible (indicatif jamais deviné).
create or replace function public.normaliser_telephone(saisie text)
returns text
language sql
immutable
set search_path = pg_catalog, pg_temp
as $$
  select case when brut ~ '^\+[1-9][0-9]{7,14}$' then brut end
  from (
    select case when s like '00%' then '+' || substr(s, 3) else s end as brut
    from (select regexp_replace(btrim(saisie), '[[:space:]().\-/]', '', 'g') as s) nettoye
  ) prefixe;
$$;

-- Rôle effectif du compte courant (RG-XXIII-02, RG-SEC-06bis), miroir de
-- CompteRepository._session : rôle de la fiche liée, sinon administrateur
-- d'amorçage, sinon utilisateur simple pour tout compte authentifié.
-- Remplace la version de 0004, qui renvoyait null pour un compte sans fiche.
create or replace function public.role_courant()
returns text
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select case
    when auth.uid() is null then null
    else coalesce(
      (select f.role from public.fideles f where f.auth_user_id = auth.uid()),
      (select 'administrateur' from public.comptes_utilisateurs c
        where c.auth_user_id = auth.uid() and c.administrateur_amorcage),
      'utilisateur_simple'
    )
  end;
$$;

-- Décide et applique la liaison du compte courant (appelée après verifyOtp).
-- Renvoie l'issue journalisée. Idempotente pour un compte déjà lié.
create or replace function public.enregistrer_compte_courant()
returns text
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $$
declare
  v_uid uuid := auth.uid();
  v_identifiant text;
  v_telephone boolean;
  v_nb integer;
  v_fiche uuid;
  v_fiche_liee boolean;
  v_issue text;
begin
  if v_uid is null then
    raise exception 'authentification requise' using errcode = '28000';
  end if;

  select case when u.phone is not null and u.phone <> ''
              then public.normaliser_telephone('+' || ltrim(u.phone, '+'))
              else lower(btrim(u.email)) end,
         u.phone is not null and u.phone <> ''
    into v_identifiant, v_telephone
  from auth.users u where u.id = v_uid;

  if v_identifiant is null then
    raise exception 'identifiant du compte non exploitable' using errcode = '22023';
  end if;

  -- Compte déjà lié : reconnexion, aucune nouvelle décision.
  if exists (select 1 from public.fideles where auth_user_id = v_uid) then
    insert into public.comptes_utilisateurs (auth_user_id, identifiant)
    values (v_uid, v_identifiant) on conflict (auth_user_id) do nothing;
    return 'deja_lie';
  end if;

  select count(*), min(f.id::text)::uuid
    into v_nb, v_fiche
  from public.fideles f
  where case when v_telephone
             then public.normaliser_telephone(f.telephone) = v_identifiant
             else lower(btrim(f.email)) = v_identifiant end;

  if v_nb > 1 then
    v_issue := 'correspondance_multiple';
    v_fiche := null;
  elsif v_nb = 1 then
    -- Garde-fou SIM churn : fiche liée maintenant, ou attestée liée par le
    -- passé dans le journal (même si le lien a depuis été vidé).
    select f.auth_user_id is not null or exists (
             select 1 from public.journal_liaisons_comptes j
             where j.fidele_id = f.id
               and (j.issue = 'lie_automatiquement' or j.statut = 'resolu_lie'))
      into v_fiche_liee
    from public.fideles f where f.id = v_fiche;
    v_issue := case when v_fiche_liee then 'fiche_deja_liee' else 'lie_automatiquement' end;
  elsif not exists (select 1 from public.organisation_nodes) then
    v_issue := 'administrateur_amorcage';
  else
    v_issue := 'aucune_correspondance';
  end if;

  if v_issue = 'lie_automatiquement' then
    update public.fideles set auth_user_id = v_uid where id = v_fiche;
  end if;

  insert into public.comptes_utilisateurs (auth_user_id, identifiant, administrateur_amorcage)
  values (v_uid, v_identifiant, v_issue = 'administrateur_amorcage')
  on conflict (auth_user_id) do update
    set administrateur_amorcage = public.comptes_utilisateurs.administrateur_amorcage
                                  or excluded.administrateur_amorcage;

  -- Une issue identique n'est pas répétée ; un conflit rejeté n'est jamais rouvert.
  if not exists (
    select 1 from public.journal_liaisons_comptes j
    where j.auth_user_id = v_uid and j.issue = v_issue and j.fidele_id is not distinct from v_fiche
  ) then
    insert into public.journal_liaisons_comptes (auth_user_id, identifiant, fidele_id, issue, statut)
    values (v_uid, v_identifiant, v_fiche, v_issue,
            case when v_issue in ('correspondance_multiple', 'fiche_deja_liee') then 'en_attente' else 'consigne' end);
  end if;

  return v_issue;
end;
$$;

-- Résolution d'un conflit par un administrateur, miroir de
-- CompteRepository.resoudreConflit.
create or replace function public.resoudre_conflit_liaison(p_entree_id uuid, p_lier boolean, p_fidele_id uuid default null)
returns void
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $$
declare
  v_entree public.journal_liaisons_comptes%rowtype;
  v_fiche uuid;
begin
  if public.role_courant() is distinct from 'administrateur' then
    raise exception 'action réservée à un administrateur' using errcode = '42501';
  end if;

  select * into v_entree from public.journal_liaisons_comptes where id = p_entree_id for update;
  if not found or v_entree.statut <> 'en_attente' then
    raise exception 'conflit de liaison déjà résolu ou introuvable' using errcode = '22023';
  end if;

  v_fiche := coalesce(p_fidele_id, v_entree.fidele_id);
  if p_lier then
    if v_fiche is null then
      raise exception 'une fiche doit être choisie' using errcode = '22023';
    end if;
    update public.fideles set auth_user_id = null where auth_user_id = v_entree.auth_user_id;
    update public.fideles set auth_user_id = v_entree.auth_user_id where id = v_fiche;
  end if;

  update public.journal_liaisons_comptes
     set statut = case when p_lier then 'resolu_lie' else 'resolu_rejete' end,
         fidele_id = case when p_lier then v_fiche else fidele_id end,
         resolu_par_auth_user_id = auth.uid(),
         resolu_le = now()
   where id = p_entree_id;
end;
$$;

revoke all on function public.enregistrer_compte_courant() from public, anon;
revoke all on function public.resoudre_conflit_liaison(uuid, boolean, uuid) from public, anon;
grant execute on function public.enregistrer_compte_courant() to authenticated;
grant execute on function public.resoudre_conflit_liaison(uuid, boolean, uuid) to authenticated;
