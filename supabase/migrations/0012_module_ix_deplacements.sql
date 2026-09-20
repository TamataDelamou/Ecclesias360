-- Module IX — Gestion des déplacements, RG-IX-01 à 04. Dépend de
-- organisation_nodes (0001), fideles (0002) et documents_archive (0011).

-- RG-IX-01 — valide_par_origine/valide_par_destination portent la double
-- validation pastorale, au-delà du modèle minimal du Cahier (qui ne prévoit
-- qu'un statut global) : nécessaires pour permettre une validation
-- unilatérale paramétrable sans perdre la trace de qui a validé.
create table if not exists public.mutations (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id),
  noeud_origine_id uuid not null references public.organisation_nodes(id),
  noeud_destination_id uuid not null references public.organisation_nodes(id),
  motif text not null,
  statut text not null default 'en_attente'
    check (statut in ('en_attente', 'validee', 'refusee')),
  valide_par_origine boolean not null default false,
  valide_par_destination boolean not null default false,
  motif_refus text,
  date_demande timestamptz not null,
  date_validation timestamptz,
  constraint mutations_noeuds_distincts check (noeud_origine_id <> noeud_destination_id)
);

create index if not exists idx_mutations_fidele on public.mutations (fidele_id);
create index if not exists idx_mutations_noeud_origine on public.mutations (noeud_origine_id);
create index if not exists idx_mutations_noeud_destination on public.mutations (noeud_destination_id);

-- RG-IX-02 — lettre de recommandation générée à la validation, archivée
-- dans le Module VIII (une seule lettre par mutation).
create table if not exists public.lettres_recommandation (
  id uuid primary key,
  mutation_id uuid not null references public.mutations(id) on delete cascade,
  document_archive_id uuid not null references public.documents_archive(id),
  constraint lettres_recommandation_mutation_key unique (mutation_id)
);

-- RG-IX-01/02 — nomenclature de la lettre de recommandation (Module VIII).
insert into public.nomenclatures_archivage (id, type_document, modele_numerotation)
values (gen_random_uuid(), 'lettre_recommandation', 'LR-{noeud}-{annee}-{sequence}')
on conflict (type_document) do nothing;

alter table public.mutations enable row level security;
alter table public.lettres_recommandation enable row level security;
