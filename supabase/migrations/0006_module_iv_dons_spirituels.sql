-- Module IV — Gestion des dons spirituels (RG-IV-01 à 04). Dépend de
-- fideles (0002) et types_ministeres (0005), créées avant ce fichier —
-- respecte l'ordre de dépendance.

-- RG-IV-04 — référentiel fixe des neuf dons spirituels (1 Corinthiens 12).
create table if not exists public.dons_spirituels (
  id uuid primary key,
  code text not null,
  libelle text not null,
  description_biblique text not null,
  constraint dons_spirituels_code_key unique (code)
);

-- RG-IV-01/02 — chaque ligne est une évaluation ; jamais mise à jour,
-- seulement ajoutée (historique complet, la plus récente fait foi).
create table if not exists public.dons_fideles (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  don_id uuid not null references public.dons_spirituels(id) on delete restrict,
  niveau_maturite text not null check (niveau_maturite in ('emergent', 'en_developpement', 'confirme', 'mature')),
  responsable_suivi_id uuid not null references public.fideles(id) on delete restrict,
  date_evaluation timestamptz not null,
  observations text
);

create index if not exists idx_dons_fideles_fidele on public.dons_fideles (fidele_id);
create index if not exists idx_dons_fideles_don on public.dons_fideles (don_id);

-- RG-IV-03 — table de correspondance don <-> type de ministère compatible,
-- vide par défaut (jugement pastoral/organisationnel, hors périmètre
-- technique) : alimente la suggestion d'affectation (Module III), jamais
-- d'affectation automatique.
create table if not exists public.dons_ministeres_compatibles (
  id uuid primary key,
  don_id uuid not null references public.dons_spirituels(id) on delete cascade,
  type_ministere_id uuid not null references public.types_ministeres(id) on delete cascade,
  constraint dons_ministeres_compatibles_don_type_key unique (don_id, type_ministere_id)
);

alter table public.dons_spirituels enable row level security;
alter table public.dons_fideles enable row level security;
alter table public.dons_ministeres_compatibles enable row level security;

-- RG-IV-04 — neuf dons standards, mêmes codes que `donsSpirituelsStandards`
-- (lib/features/organization/data/local/app_database.dart).
insert into public.dons_spirituels (id, code, libelle, description_biblique)
values
  (gen_random_uuid(), 'parole_de_sagesse', 'Parole de sagesse', '1 Corinthiens 12:8'),
  (gen_random_uuid(), 'parole_de_connaissance', 'Parole de connaissance', '1 Corinthiens 12:8'),
  (gen_random_uuid(), 'foi', 'Foi', '1 Corinthiens 12:9'),
  (gen_random_uuid(), 'dons_de_guerisons', 'Dons de guérisons', '1 Corinthiens 12:9'),
  (gen_random_uuid(), 'operations_de_miracles', 'Opérations de miracles', '1 Corinthiens 12:10'),
  (gen_random_uuid(), 'prophetie', 'Prophétie', '1 Corinthiens 12:10'),
  (gen_random_uuid(), 'discernement_des_esprits', 'Discernement des esprits', '1 Corinthiens 12:10'),
  (gen_random_uuid(), 'diverses_langues', 'Diverses langues', '1 Corinthiens 12:10'),
  (gen_random_uuid(), 'interpretation_des_langues', 'Interprétation des langues', '1 Corinthiens 12:10')
on conflict (code) do nothing;
