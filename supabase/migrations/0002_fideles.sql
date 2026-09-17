-- Module II — Gestion complète des fidèles (RG-II-*)
-- Dépend de organisation_nodes (0001_organisation_nodes.sql), créée avant
-- ce fichier — respecte l'ordre de dépendance (voir AGENTS.md §7 bugs
-- connus : ne jamais référencer une table avant sa propre création).

create table if not exists public.fideles (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete restrict,
  nom text not null,
  prenoms text not null,
  date_naissance date not null,
  sexe text not null check (sexe in ('masculin', 'feminin')),
  statut_civil text not null
    check (statut_civil in ('celibataire', 'marie', 'divorce', 'veuf')),
  statut_spirituel text not null default 'visiteur'
    check (statut_spirituel in (
      'visiteur', 'nouveau_converti', 'baptise', 'membre_actif',
      'membre_en_discipline', 'membre_decede', 'membre_transfere'
    )),
  statut text not null default 'actif'
    check (statut in ('actif', 'inactif', 'decede')),
  date_conversion date,
  date_bapteme date,
  eglise_provenance text,
  photo_url text,
  telephone text,
  email text,
  adresse text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_fideles_noeud on public.fideles (noeud_id);

-- RG-II-04 — la suppression d'un lien familial n'entraîne jamais la
-- suppression des fidèles liés (pas de cascade sur `fideles` depuis cette
-- table, uniquement l'inverse).
create table if not exists public.liens_familiaux (
  id uuid primary key,
  fidele_id1 uuid not null references public.fideles(id) on delete cascade,
  fidele_id2 uuid not null references public.fideles(id) on delete cascade,
  type_lien text not null check (type_lien in ('conjoint', 'enfant', 'parent')),
  check (fidele_id1 <> fidele_id2)
);

create index if not exists idx_liens_familiaux_fidele1 on public.liens_familiaux (fidele_id1);
create index if not exists idx_liens_familiaux_fidele2 on public.liens_familiaux (fidele_id2);

-- RG-II-05 — historisation des champs sensibles.
create table if not exists public.historique_fideles (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  champ_modifie text not null,
  ancienne_valeur text,
  nouvelle_valeur text,
  auteur_fidele_id uuid references public.fideles(id) on delete set null,
  date timestamptz not null default now()
);

create index if not exists idx_historique_fideles_fidele on public.historique_fideles (fidele_id);

-- RG-II-06 — tuteur légal d'un fidèle mineur, fidèle enregistré ou tiers.
create table if not exists public.tuteurs (
  id uuid primary key,
  mineur_id uuid not null references public.fideles(id) on delete cascade,
  lien text not null,
  tuteur_fidele_id uuid references public.fideles(id) on delete set null,
  tuteur_tiers_nom text,
  tuteur_tiers_telephone text,
  check (
    (tuteur_fidele_id is not null and tuteur_tiers_nom is null)
    or (tuteur_fidele_id is null and tuteur_tiers_nom is not null)
  )
);

create index if not exists idx_tuteurs_mineur on public.tuteurs (mineur_id);

-- RLS activée dès l'origine, policies écrites plus tard avec les helpers de
-- périmètre (RG-SEC-05) et RG-SEC-06 (confidentialité renforcée des
-- données spirituelles du Module II), activées en bloc au déploiement de
-- l'auth groupée — jamais table par table (voir AGENTS.md §10).
alter table public.fideles enable row level security;
alter table public.liens_familiaux enable row level security;
alter table public.historique_fideles enable row level security;
alter table public.tuteurs enable row level security;
