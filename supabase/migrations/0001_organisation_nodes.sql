-- Module I — Gestion de l'organisation ecclésiastique (RG-I-*)
-- Référentiel hiérarchique unique de la plateforme. Une seule racine
-- (type_noeud = 'siege') est autorisée par déploiement.

create table if not exists public.organisation_nodes (
  id uuid primary key,
  type_noeud text not null check (type_noeud in (
    'siege', 'direction_internationale', 'direction_nationale', 'union',
    'mission', 'reseau', 'prefecture', 'region', 'zone', 'district',
    'secteur', 'eglise_locale'
  )),
  noeud_parent_id uuid references public.organisation_nodes(id) on delete restrict,
  nom text not null,
  code_interne text not null,
  logo_url text,
  cachet_url text,
  date_fondation date,
  statut text not null default 'provisoire'
    check (statut in ('provisoire', 'actif', 'archive')),
  categorie_confessionnelle text
    check (categorie_confessionnelle in ('catholique', 'autres')),
  zone_geo_id uuid,
  path text not null,
  depth integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint organisation_nodes_racine_unique_check check (
    (type_noeud = 'siege' and noeud_parent_id is null)
    or (type_noeud <> 'siege' and noeud_parent_id is not null)
  ),
  constraint organisation_nodes_categorie_confessionnelle_coherence_check check (
    (type_noeud = 'eglise_locale' and categorie_confessionnelle is not null)
    or (type_noeud <> 'eglise_locale' and categorie_confessionnelle is null)
  )
);

create unique index if not exists uq_organisation_nodes_code_interne
  on public.organisation_nodes (code_interne);

create index if not exists idx_organisation_nodes_parent
  on public.organisation_nodes (noeud_parent_id);

create index if not exists idx_organisation_nodes_path
  on public.organisation_nodes (path);

-- RG-I-06 — trace tout changement de rattachement d'un nœud.
create table if not exists public.historique_rattachements (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  ancien_parent_id uuid references public.organisation_nodes(id) on delete set null,
  nouveau_parent_id uuid not null references public.organisation_nodes(id) on delete cascade,
  date_effet timestamptz not null default now(),
  motif text
);

create index if not exists idx_historique_rattachements_noeud
  on public.historique_rattachements (noeud_id);

-- RLS activée dès l'origine, policies écrites plus tard avec les helpers de
-- périmètre (RG-SEC-05) et activées en bloc au déploiement de l'auth
-- groupée — jamais table par table (voir AGENTS.md §10).
alter table public.organisation_nodes enable row level security;
alter table public.historique_rattachements enable row level security;
