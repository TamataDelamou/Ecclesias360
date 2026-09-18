-- Sécurité de base (RG-SEC-01 à 07), RG-I-05, RG-SEC-05 — helpers de
-- périmètre hiérarchique. Dépend de organisation_nodes (0001) et fideles
-- (0002), créées avant ce fichier — respecte l'ordre de dépendance.
--
-- Toutes les `create policy` du projet restent commentées : activation
-- groupée prévue avec le déploiement de l'authentification (RG-SEC-01,
-- Supabase Auth OTP + GSG ID), jamais isolée table par table (voir
-- AGENTS.md §10 et RECONSTRUCTION_ecclesias360.md §3). Ces helpers, eux,
-- sont actifs dès cette migration : ils ne modifient aucune donnée et sont
-- nécessaires pour écrire puis tester les policies au moment venu.

alter table public.fideles
  add column if not exists auth_user_id uuid unique references auth.users(id) on delete set null;

alter table public.fideles
  add column if not exists role text not null default 'membre'
    check (role in ('utilisateur_simple', 'membre', 'responsable', 'pasteur', 'administrateur'));

-- RG-I-05 — responsables en fonction d'un nœud, avec historique des
-- mandats (jamais supprimé, seulement clos via date_fin).
create table if not exists public.node_responsables (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  fonction text not null,
  date_debut timestamptz not null default now(),
  date_fin timestamptz
);

create index if not exists idx_node_responsables_noeud on public.node_responsables (noeud_id);
create index if not exists idx_node_responsables_fidele on public.node_responsables (fidele_id);

alter table public.node_responsables enable row level security;

-- search_path durci sur pg_catalog, pg_temp (public exclu de la
-- résolution) : toute référence à un objet applicatif doit être qualifiée
-- explicitement (public.xxx) pour ne jamais dépendre de la résolution
-- implicite — c'est la surface qu'un search_path non durci laisserait
-- détourner.

create or replace function public.fidele_courant_id()
returns uuid
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select id from public.fideles where auth_user_id = auth.uid();
$$;

create or replace function public.role_courant()
returns text
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select role from public.fideles where auth_user_id = auth.uid();
$$;

-- RG-SEC-05 — nœuds où le fidèle courant a un mandat actif
-- (node_responsables, date_fin nulle ou future), plus tous leurs
-- descendants (n.path like racine.path || '%'). Miroir SQL de
-- PerimetreRules.noeudsDuPerimetre (Dart pur, testé en isolation en
-- l'absence d'infrastructure pgTAP — les deux doivent rester équivalents).
create or replace function public.noeuds_du_perimetre()
returns setof uuid
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select n.id
  from public.organisation_nodes n
  where exists (
    select 1
    from public.node_responsables r
    join public.organisation_nodes racine on racine.id = r.noeud_id
    where r.fidele_id = public.fidele_courant_id()
      and (r.date_fin is null or r.date_fin > now())
      and n.path like racine.path || '%'
  );
$$;
