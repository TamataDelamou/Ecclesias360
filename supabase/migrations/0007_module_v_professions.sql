-- Module V — Gestion des groupes professionnels (RG-V-01 à 03). Dépend de
-- fideles (0002), créée avant ce fichier — respecte l'ordre de dépendance.

-- RG-V-02 — référentiel hiérarchisé (catégorie / métier), paramétrable.
create table if not exists public.professions (
  id uuid primary key,
  code text not null,
  categorie text not null,
  libelle text not null,
  statut text not null default 'actif' check (statut in ('actif', 'desactive')),
  constraint professions_code_key unique (code)
);

-- RG-V-01 — déclaration d'une profession/compétence par un fidèle,
-- vérifiable par un responsable.
create table if not exists public.professions_fideles (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  profession_id uuid not null references public.professions(id) on delete restrict,
  statut_verification text not null default 'declare' check (statut_verification in ('declare', 'verifie')),
  annees_experience integer
);

create index if not exists idx_professions_fideles_fidele on public.professions_fideles (fidele_id);
create index if not exists idx_professions_fideles_profession on public.professions_fideles (profession_id);

-- RG-V-03 — sollicitation nommée d'un fidèle pour un projet ou une action
-- sociale, réponse tracée.
create table if not exists public.sollicitations (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  objet text not null,
  date timestamptz not null,
  reponse text
);

create index if not exists idx_sollicitations_fidele on public.sollicitations (fidele_id);

alter table public.professions enable row level security;
alter table public.professions_fideles enable row level security;
alter table public.sollicitations enable row level security;

-- RG-V-02 — quelques métiers de départ, mêmes codes que
-- `professionsDeDepart` (lib/features/organization/data/local/app_database.dart),
-- référentiel entièrement paramétrable ensuite (pas de protection
-- « standard » comme pour les Modules III/IV).
insert into public.professions (id, code, categorie, libelle)
values
  (gen_random_uuid(), 'medecin', 'Santé', 'Médecin'),
  (gen_random_uuid(), 'infirmier', 'Santé', 'Infirmier'),
  (gen_random_uuid(), 'enseignant', 'Éducation', 'Enseignant'),
  (gen_random_uuid(), 'developpeur_informatique', 'Informatique', 'Développeur informatique'),
  (gen_random_uuid(), 'ingenieur', 'Ingénierie et BTP', 'Ingénieur'),
  (gen_random_uuid(), 'architecte', 'Ingénierie et BTP', 'Architecte'),
  (gen_random_uuid(), 'artisan_macon', 'Ingénierie et BTP', 'Artisan / Maçon'),
  (gen_random_uuid(), 'avocat', 'Droit et affaires', 'Avocat'),
  (gen_random_uuid(), 'comptable', 'Droit et affaires', 'Comptable'),
  (gen_random_uuid(), 'entrepreneur', 'Droit et affaires', 'Entrepreneur'),
  (gen_random_uuid(), 'chauffeur', 'Transport et services', 'Chauffeur'),
  (gen_random_uuid(), 'commercant', 'Commerce', 'Commerçant')
on conflict (code) do nothing;
