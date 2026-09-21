-- Module XI — Finances, RG-XI-01 à 07. Dépend de organisation_nodes (0001),
-- fideles (0002) et cultes (0010, module XII).

-- RG-XI-01 — référentiel fermé et extensible des types d'offrande. Porté
-- par le Module XI lui-même (module producteur), même précédent que
-- types_ministeres/dons_spirituels/professions (voir AGENTS.md §7, entrée
-- Module XI). Mêmes codes que le seed local (app_database.dart).
create table if not exists public.types_offrande (
  id uuid primary key,
  code text not null unique,
  libelle text not null,
  standard boolean not null default false,
  statut text not null default 'actif'
);

insert into public.types_offrande (id, code, libelle, standard) values
  (gen_random_uuid(), 'ordinaire', 'Offrande ordinaire', true),
  (gen_random_uuid(), 'dime', 'Dîme', true),
  (gen_random_uuid(), 'premices', 'Prémices', true),
  (gen_random_uuid(), 'missionnaire', 'Offrande missionnaire', true),
  (gen_random_uuid(), 'construction', 'Offrande de construction', true)
on conflict (code) do nothing;

-- RG-XI-02 — désignation d'un fidèle comme trésorier d'un nœud. L'énum
-- Role (Module XXIII) est fermée et ne porte pas de valeur « trésorier » :
-- cette table latérale l'habilite pour la validation comptable, même motif
-- que membres_comite/membres_commission_disciplinaire.
create table if not exists public.tresoriers_noeud (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id),
  noeud_id uuid not null references public.organisation_nodes(id),
  date_debut timestamptz not null,
  date_fin timestamptz
);

create index if not exists idx_tresoriers_noeud_noeud on public.tresoriers_noeud (noeud_id);
create index if not exists idx_tresoriers_noeud_fidele on public.tresoriers_noeud (fidele_id);

-- RG-XI-03 — projet financier d'un nœud. Le solde n'est pas une colonne
-- stockée : il se recalcule à la lecture à partir des contributions
-- validées et des dépenses (même précédent que le décompte des votes,
-- RG-XII-06).
create table if not exists public.projets (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id),
  nom text not null,
  budget_previsionnel integer not null,
  devise text not null,
  statut text not null default 'en_cours'
    check (statut in ('en_cours', 'suspendu', 'clos'))
);

create index if not exists idx_projets_noeud on public.projets (noeud_id);

-- RG-XI-01/02/05/06 — contribution d'un fidèle (ou d'un donateur anonyme
-- identifié techniquement, fidele_id alors nul). contribution_origine_id +
-- est_contre_passation portent la correction tracée exigée par RG-XI-05 :
-- une contribution validée n'est jamais modifiée, seulement contre-passée
-- par une nouvelle ligne de montant inverse qui la référence.
create table if not exists public.contributions (
  id uuid primary key,
  fidele_id uuid references public.fideles(id),
  libelle_donateur_anonyme text,
  type_offrande_id uuid not null references public.types_offrande(id),
  montant integer not null,
  devise text not null,
  noeud_id uuid not null references public.organisation_nodes(id),
  culte_id uuid references public.cultes(id),
  projet_id uuid references public.projets(id),
  mode_paiement text not null,
  statut text not null default 'en_attente'
    check (statut in ('en_attente', 'validee', 'rejetee')),
  origine text not null check (origine in ('mobile', 'desktop', 'hors_ligne')),
  date_saisie timestamptz not null,
  valide_par_fidele_id uuid references public.fideles(id),
  date_validation timestamptz,
  motif_rejet text,
  contribution_origine_id uuid references public.contributions(id),
  est_contre_passation boolean not null default false
);

create index if not exists idx_contributions_noeud on public.contributions (noeud_id);
create index if not exists idx_contributions_fidele on public.contributions (fidele_id);
create index if not exists idx_contributions_projet on public.contributions (projet_id);

-- RG-XI-03 — dépense affectée à un projet. derogation_tracee +
-- motif_derogation couvrent l'engagement d'une dépense au-delà du solde
-- disponible, exceptionnellement autorisé par un rôle habilité.
create table if not exists public.depenses_projet (
  id uuid primary key,
  projet_id uuid not null references public.projets(id),
  montant integer not null,
  libelle text not null,
  date timestamptz not null,
  valide_par_fidele_id uuid not null references public.fideles(id),
  derogation_tracee boolean not null default false,
  motif_derogation text
);

create index if not exists idx_depenses_projet_projet on public.depenses_projet (projet_id);

-- RG-XI-04 — engagement récurrent d'un fidèle (dîme ou promesse de don, les
-- deux seules formes citées par le Cahier).
create table if not exists public.engagements (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id),
  type text not null check (type in ('dime_engagement', 'promesse_don')),
  montant_prevu integer not null,
  periodicite text not null
    check (periodicite in ('hebdomadaire', 'mensuelle', 'trimestrielle', 'annuelle')),
  date_debut timestamptz not null,
  statut text not null default 'actif'
    check (statut in ('actif', 'suspendu', 'clos'))
);

create index if not exists idx_engagements_fidele on public.engagements (fidele_id);

-- RG-XI-04 — échéance générée pour un engagement récurrent. contribution_id
-- est renseigné quand l'échéance est rapprochée manuellement d'une
-- contribution effectivement saisie (aucune détection automatique de
-- correspondance dans ce lot).
create table if not exists public.echeances_engagement (
  id uuid primary key,
  engagement_id uuid not null references public.engagements(id) on delete cascade,
  date_echeance timestamptz not null,
  statut text not null default 'en_attente'
    check (statut in ('en_attente', 'honoree', 'en_retard')),
  contribution_id uuid references public.contributions(id)
);

create index if not exists idx_echeances_engagement_engagement on public.echeances_engagement (engagement_id);

alter table public.types_offrande enable row level security;
alter table public.tresoriers_noeud enable row level security;
alter table public.projets enable row level security;
alter table public.contributions enable row level security;
alter table public.depenses_projet enable row level security;
alter table public.engagements enable row level security;
alter table public.echeances_engagement enable row level security;
