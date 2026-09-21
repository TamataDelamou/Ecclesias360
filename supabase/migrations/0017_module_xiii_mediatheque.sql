-- Module XIII — Médiathèque chrétienne, RG-XIII-01 à 05. Dépend de
-- organisation_nodes (0001) et fideles (0002). Décision explicite :
-- « métadonnées seulement » — fichier est une simple référence (URL ou
-- texte), aucun fichier binaire n'est stocké côté serveur pour cette
-- itération.

-- RG-XIII-01/02 — contenu de la médiathèque. mots_cles est stocké en texte
-- séparé par des virgules (pas de type tableau imposé côté client Drift),
-- même simplification que documentée côté app_database.dart. La contrainte
-- unique (source_module, source_id, type_contenu) rend idempotent
-- l'archivage automatique déclenché par un module producteur (ex. Module
-- XII, publication d'un culte).
create table if not exists public.contenus_mediatheque (
  id uuid primary key,
  type_contenu text not null check (type_contenu in ('audio', 'video', 'podcast', 'ebook', 'magazine', 'document')),
  titre text not null,
  source_module text,
  source_id text,
  noeud_editeur_id uuid not null references public.organisation_nodes(id),
  fichier text,
  theme text not null,
  mots_cles text not null default '',
  intervenant text,
  date_contenu timestamptz not null,
  statut text not null default 'brouillon' check (statut in ('brouillon', 'publie', 'retire')),
  droits_telechargement boolean not null default false,
  moderation_a_priori boolean not null default false,
  compteur_consultations integer not null default 0,
  unique (source_module, source_id, type_contenu)
);

create index if not exists idx_contenus_mediatheque_noeud on public.contenus_mediatheque (noeud_editeur_id);
create index if not exists idx_contenus_mediatheque_statut on public.contenus_mediatheque (statut);

-- RG-XIII-04 — favoris, un contenu marqué au plus une fois par fidèle.
create table if not exists public.favoris (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id),
  contenu_id uuid not null references public.contenus_mediatheque(id),
  unique (fidele_id, contenu_id)
);

-- RG-XIII-03 — commentaire, soumis à modération a priori ou a posteriori
-- selon le contenu ; masqué automatiquement au-delà du seuil de
-- signalements paramétrable (app_defaults.dart côté client).
create table if not exists public.commentaires (
  id uuid primary key,
  contenu_id uuid not null references public.contenus_mediatheque(id),
  fidele_id uuid not null references public.fideles(id),
  texte text not null,
  statut_moderation text not null default 'publie' check (statut_moderation in ('en_attente', 'publie', 'masque')),
  date timestamptz not null,
  nombre_signalements integer not null default 0
);

create index if not exists idx_commentaires_contenu on public.commentaires (contenu_id);

alter table public.contenus_mediatheque enable row level security;
alter table public.favoris enable row level security;
alter table public.commentaires enable row level security;
