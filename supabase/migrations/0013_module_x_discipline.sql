-- Module X — Gestion disciplinaire, RG-X-01 à 06. Dépend de
-- organisation_nodes (0001), fideles (0002), decisions (0009, module VII)
-- et documents_archive (0011).

-- RG-X-02 — référentiel fermé et extensible des natures de faute. Décision
-- pastorale hors périmètre technique : liste de départ volontairement
-- courte et strictement administrative/procédurale (gouvernance,
-- organisation, engagements) — aucune catégorie à caractère moral,
-- doctrinal ou théologique n'y figure ni ne doit y être ajoutée (voir
-- AGENTS.md §7, entrée Module X). Mêmes codes que le seed local
-- (app_database.dart).
create table if not exists public.natures_faute (
  id uuid primary key,
  code text not null unique,
  libelle text not null,
  standard boolean not null default false,
  statut text not null default 'actif'
);

insert into public.natures_faute (id, code, libelle, standard) values
  (gen_random_uuid(), 'absenteisme_prolonge', 'Absentéisme prolongé et injustifié', true),
  (gen_random_uuid(), 'desobeissance_autorite_pastorale', 'Désobéissance à l''autorité pastorale', true),
  (gen_random_uuid(), 'conflit_non_resolu', 'Conflit non résolu avec un membre ou un responsable', true),
  (gen_random_uuid(), 'manquement_engagement_mandat', 'Manquement à un engagement ou à un mandat', true)
on conflict (code) do nothing;

-- RG-X-02 — commission instructrice, scopée à un nœud (peut recouper les
-- membres du comité local sans dépendance directe, voir Cahier).
create table if not exists public.commissions_disciplinaires (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id),
  nom text not null,
  statut text not null default 'active'
);

create index if not exists idx_commissions_disciplinaires_noeud
  on public.commissions_disciplinaires (noeud_id);

create table if not exists public.membres_commission_disciplinaire (
  id uuid primary key,
  commission_id uuid not null references public.commissions_disciplinaires(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id),
  constraint membres_commission_disciplinaire_key unique (commission_id, fidele_id)
);

-- RG-X-01 à 04 — dossier disciplinaire. Au-delà du tableau minimal du
-- Cahier, quatre champs pragmatiques sont ajoutés (voir
-- lib/features/discipline/domain/models/dossier_disciplinaire.dart pour la
-- justification détaillée) : ouvert_par_fidele_id, statut_spirituel_
-- anterieur, suspension_ministeres_appliquee, decision_comite_origine_id.
create table if not exists public.dossiers_disciplinaires (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id),
  noeud_id uuid not null references public.organisation_nodes(id),
  nature_faute_id uuid not null references public.natures_faute(id),
  date_ouverture timestamptz not null,
  statut text not null default 'en_instruction'
    check (statut in ('en_instruction', 'sanctionne', 'clos')),
  ouvert_par_fidele_id uuid references public.fideles(id),
  statut_spirituel_anterieur text,
  commission_id uuid references public.commissions_disciplinaires(id),
  decision text,
  date_decision timestamptz,
  duree_sanction_jours integer,
  date_reintegration_prevue timestamptz,
  suspension_ministeres_appliquee boolean not null default false,
  decision_comite_origine_id uuid references public.decisions(id)
);

create index if not exists idx_dossiers_disciplinaires_fidele on public.dossiers_disciplinaires (fidele_id);
create index if not exists idx_dossiers_disciplinaires_noeud on public.dossiers_disciplinaires (noeud_id);

-- RG-X-02/06 — pièces (témoignages/preuves), archivées dans le Module VIII
-- avec le niveau de confidentialité maximal disponible (restreint).
create table if not exists public.pieces_dossier (
  id uuid primary key,
  dossier_id uuid not null references public.dossiers_disciplinaires(id) on delete cascade,
  nature text not null check (nature in ('temoignage', 'preuve')),
  ajoute_le timestamptz not null,
  document_archive_id uuid references public.documents_archive(id)
);

-- RG-X-06 — nomenclature de la pièce de dossier disciplinaire (Module VIII).
insert into public.nomenclatures_archivage (id, type_document, modele_numerotation)
values (gen_random_uuid(), 'piece_dossier_disciplinaire', 'PD-{noeud}-{annee}-{sequence}')
on conflict (type_document) do nothing;

alter table public.natures_faute enable row level security;
alter table public.commissions_disciplinaires enable row level security;
alter table public.membres_commission_disciplinaire enable row level security;
alter table public.dossiers_disciplinaires enable row level security;
alter table public.pieces_dossier enable row level security;
