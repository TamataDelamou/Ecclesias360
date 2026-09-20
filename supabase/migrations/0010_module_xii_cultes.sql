-- Module XII — Gestion des cultes (RG-XII-01 à 06). Dépend de
-- organisation_nodes (0001) et fideles (0002), créées avant ce fichier —
-- respecte l'ordre de dépendance.

-- RG-XII-01/02/05 — serie_recurrente_id regroupe les occurrences d'un
-- culte récurrent ; est_exception marque une occurrence modifiée
-- ponctuellement.
create table if not exists public.cultes (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  date_heure timestamptz not null,
  type_culte text not null,
  theme text,
  predicateur_id uuid references public.fideles(id) on delete set null,
  statut text not null default 'planifie' check (statut in ('planifie', 'en_cours', 'termine', 'annule')),
  mode_presence text not null default 'nominal' check (mode_presence in ('nominal', 'global')),
  compte_global_presence integer,
  serie_recurrente_id uuid,
  est_exception boolean not null default false
);

create index if not exists idx_cultes_noeud on public.cultes (noeud_id);
create index if not exists idx_cultes_serie on public.cultes (serie_recurrente_id);

-- RG-XII-01 — programme (liturgie) structuré en séquences ordonnées.
create table if not exists public.sequences_liturgiques (
  id uuid primary key,
  culte_id uuid not null references public.cultes(id) on delete cascade,
  ordre integer not null,
  libelle text not null,
  responsable_id uuid references public.fideles(id) on delete set null,
  duree_prevue_minutes integer
);

create index if not exists idx_sequences_liturgiques_culte on public.sequences_liturgiques (culte_id);

-- RG-XII-02 — pointage nominal uniquement (voir cultes.compte_global_presence
-- pour le mode global) ; les deux modes sont mutuellement exclusifs,
-- appliqué côté application (CulteRules.raisonBlocagePresence).
create table if not exists public.presences_culte (
  id uuid primary key,
  culte_id uuid not null references public.cultes(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  constraint presences_culte_culte_fidele_key unique (culte_id, fidele_id)
);

-- RG-XII-03 — publication post-culte, optionnelle. L'archivage
-- automatique dans la médiathèque (Module XIII) reste différé.
create table if not exists public.publications_culte (
  id uuid primary key,
  culte_id uuid not null references public.cultes(id) on delete cascade,
  date_publication timestamptz not null,
  texte_biblique text,
  audio_url text,
  video_url text,
  pdf_url text,
  constraint publications_culte_culte_key unique (culte_id)
);

-- RG-XII-06 — le classement automatique par l'assistant IA (Module XVI)
-- reste différé, categorie nullable en attendant.
create table if not exists public.propositions_theme (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  titre text not null,
  explication text,
  categorie text,
  statut text not null default 'soumise' check (statut in ('soumise', 'validee', 'rejetee')),
  date_soumission timestamptz not null
);

create index if not exists idx_propositions_theme_fidele on public.propositions_theme (fidele_id);

-- RG-XII-06 — un vote par fidèle et par proposition, modifiable.
create table if not exists public.votes_proposition (
  id uuid primary key,
  proposition_id uuid not null references public.propositions_theme(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  valeur text not null check (valeur in ('jaime', 'jenaimepas')),
  constraint votes_proposition_proposition_fidele_key unique (proposition_id, fidele_id)
);

alter table public.cultes enable row level security;
alter table public.sequences_liturgiques enable row level security;
alter table public.presences_culte enable row level security;
alter table public.publications_culte enable row level security;
alter table public.propositions_theme enable row level security;
alter table public.votes_proposition enable row level security;
