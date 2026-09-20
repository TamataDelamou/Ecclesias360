-- Module VIII — Gestion administrative (archivage documentaire), RG-VIII-01
-- à 06. Dépend de organisation_nodes (0001) et fideles (0002).

-- RG-VIII-01 — modèle de numérotation paramétrable par type de document.
create table if not exists public.nomenclatures_archivage (
  id uuid primary key,
  type_document text not null,
  modele_numerotation text not null,
  constraint nomenclatures_archivage_type_key unique (type_document)
);

-- RG-VIII-01/02/03/04/05 — greffe transversale : module_origine/objet_id_origine
-- pointent vers l'objet métier producteur, sans FK (modules producteurs
-- hétérogènes, certains n'existent pas encore). numero_archive est immuable
-- une fois attribué (RG-VIII-01, jamais renumeroté).
create table if not exists public.documents_archive (
  id uuid primary key,
  numero_archive text not null,
  type_document text not null,
  module_origine text not null,
  objet_id_origine text not null,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  niveau_confidentialite text not null default 'standard'
    check (niveau_confidentialite in ('standard', 'restreint')),
  statut text not null default 'actif' check (statut in ('actif', 'en_corbeille')),
  fichier text not null,
  date_archivage timestamptz not null,
  date_mise_corbeille timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint documents_archive_numero_key unique (numero_archive)
);

create index if not exists idx_documents_archive_noeud on public.documents_archive (noeud_id);
create index if not exists idx_documents_archive_origine on public.documents_archive (module_origine, objet_id_origine);

-- RG-VIII-02 — historique complet des versions ; la version 1 correspond au
-- fichier fourni à l'archivage initial et reste accessible indéfiniment.
create table if not exists public.versions_document (
  id uuid primary key,
  document_id uuid not null references public.documents_archive(id) on delete cascade,
  numero_version integer not null,
  fichier text not null,
  date timestamptz not null,
  constraint versions_document_document_numero_key unique (document_id, numero_version)
);

create index if not exists idx_versions_document_document on public.versions_document (document_id);

-- RG-VIII-01 — nomenclature de départ : le procès-verbal de comité (Module
-- VII) est le seul type de document producteur existant à ce jour.
insert into public.nomenclatures_archivage (id, type_document, modele_numerotation)
values (gen_random_uuid(), 'proces_verbal_comite', 'PV-{noeud}-{annee}-{sequence}')
on conflict (type_document) do nothing;

alter table public.nomenclatures_archivage enable row level security;
alter table public.documents_archive enable row level security;
alter table public.versions_document enable row level security;
