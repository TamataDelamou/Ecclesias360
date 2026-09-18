-- Module III — Gestion des ministères et départements (RG-III-01 à 05).
-- Dépend de organisation_nodes (0001) et fideles (0002), créées avant ce
-- fichier — respecte l'ordre de dépendance.

create table if not exists public.types_ministeres (
  id uuid primary key,
  code text not null,
  libelle text not null,
  standard boolean not null default false,
  statut text not null default 'actif' check (statut in ('actif', 'desactive')),
  constraint types_ministeres_code_key unique (code)
);

create table if not exists public.ministeres (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  type_ministere_id uuid not null references public.types_ministeres(id) on delete restrict,
  nom text not null,
  date_creation timestamptz not null,
  statut text not null default 'actif' check (statut in ('actif', 'suspendu', 'archive'))
);

create index if not exists idx_ministeres_noeud on public.ministeres (noeud_id);

-- RG-III-01 — au plus un rôle responsable actif par ministère : appliqué
-- côté application (MinistereRules), pas en contrainte SQL, car la
-- condition porte sur (ministere_id, role = 'responsable', statut =
-- 'active') et non sur l'unicité brute d'une colonne.
create table if not exists public.affectations_ministeres (
  id uuid primary key,
  ministere_id uuid not null references public.ministeres(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  role text not null check (role in ('membre', 'responsable')),
  date_debut timestamptz not null,
  date_fin timestamptz,
  statut text not null default 'active' check (statut in ('active', 'suspendue', 'terminee'))
);

create index if not exists idx_affectations_ministeres_ministere on public.affectations_ministeres (ministere_id);
create index if not exists idx_affectations_ministeres_fidele on public.affectations_ministeres (fidele_id);

-- RG-III-02/05 — les lignes closes (date_fin_reelle non nulle) constituent
-- l'historique des responsables successifs, pas de table séparée.
create table if not exists public.mandats_responsables (
  id uuid primary key,
  ministere_id uuid not null references public.ministeres(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  date_debut timestamptz not null,
  date_fin_prevue timestamptz,
  date_fin_reelle timestamptz
);

create index if not exists idx_mandats_responsables_ministere on public.mandats_responsables (ministere_id);

-- RG-III-05 — journal d'activités (réunions, rapports d'activité).
create table if not exists public.activites_ministeres (
  id uuid primary key,
  ministere_id uuid not null references public.ministeres(id) on delete cascade,
  type text not null check (type in ('reunion', 'rapport')),
  description text not null,
  date timestamptz not null,
  auteur_fidele_id uuid references public.fideles(id) on delete set null
);

create index if not exists idx_activites_ministeres_ministere on public.activites_ministeres (ministere_id);

alter table public.types_ministeres enable row level security;
alter table public.ministeres enable row level security;
alter table public.affectations_ministeres enable row level security;
alter table public.mandats_responsables enable row level security;
alter table public.activites_ministeres enable row level security;

-- RG-III-04 — vingt-quatre types standards fournis par défaut, mêmes codes
-- que `typesMinisteresStandards` (lib/features/organization/data/local/app_database.dart).
insert into public.types_ministeres (id, code, libelle, standard)
values
  (gen_random_uuid(), 'chorale', 'Chorale', true),
  (gen_random_uuid(), 'louange', 'Louange', true),
  (gen_random_uuid(), 'intercession', 'Intercession et prière', true),
  (gen_random_uuid(), 'jeunesse', 'Jeunesse', true),
  (gen_random_uuid(), 'diaconat', 'Diaconat', true),
  (gen_random_uuid(), 'media', 'Média', true),
  (gen_random_uuid(), 'sonorisation', 'Sonorisation et son', true),
  (gen_random_uuid(), 'action_sociale', 'Action sociale', true),
  (gen_random_uuid(), 'evangelisation', 'Évangélisation', true),
  (gen_random_uuid(), 'enfants', 'Enfants et école du dimanche', true),
  (gen_random_uuid(), 'hospitalite', 'Hospitalité et accueil', true),
  (gen_random_uuid(), 'protocole', 'Protocole', true),
  (gen_random_uuid(), 'securite', 'Sécurité', true),
  (gen_random_uuid(), 'finances_offrandes', 'Finances et offrandes', true),
  (gen_random_uuid(), 'visitation_pastorale', 'Visitation pastorale', true),
  (gen_random_uuid(), 'enseignement_biblique', 'Enseignement biblique', true),
  (gen_random_uuid(), 'communication', 'Communication', true),
  (gen_random_uuid(), 'technique_informatique', 'Technique et informatique', true),
  (gen_random_uuid(), 'missions', 'Missions', true),
  (gen_random_uuid(), 'patrimoine', 'Construction et patrimoine', true),
  (gen_random_uuid(), 'sport', 'Sport', true),
  (gen_random_uuid(), 'arts_culture', 'Arts et culture', true),
  (gen_random_uuid(), 'femmes', 'Ministère des femmes', true),
  (gen_random_uuid(), 'hommes', 'Ministère des hommes', true)
on conflict (code) do nothing;
