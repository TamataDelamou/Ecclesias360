-- Module VII — Gestion du comité local (RG-VII-01 à 05). Dépend de
-- organisation_nodes (0001) et fideles (0002), créées avant ce fichier —
-- respecte l'ordre de dépendance.

-- RG-VII-05 — quorum minimum paramétrable par nœud.
create table if not exists public.quorums_comite (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  quorum_minimum integer not null,
  constraint quorums_comite_noeud_key unique (noeud_id)
);

-- RG-VII-01 — sous-ensemble qualifié des fidèles, jamais sans fiche fidèle
-- sous-jacente (FK non nullable, ON DELETE CASCADE).
create table if not exists public.membres_comite (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  fonction text not null,
  date_debut timestamptz not null,
  date_fin timestamptz
);

create index if not exists idx_membres_comite_fidele on public.membres_comite (fidele_id);
create index if not exists idx_membres_comite_noeud on public.membres_comite (noeud_id);

-- RG-VII-05 — quorum_atteint calculé par le système, jamais déclaré
-- librement (nullable : indéterminé si aucun quorum n'est configuré).
create table if not exists public.seances_comite (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id) on delete cascade,
  date timestamptz not null,
  ordre_du_jour text not null,
  quorum_atteint boolean
);

create index if not exists idx_seances_comite_noeud on public.seances_comite (noeud_id);

create table if not exists public.presents_seance (
  id uuid primary key,
  seance_id uuid not null references public.seances_comite(id) on delete cascade,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  constraint presents_seance_seance_fidele_key unique (seance_id, fidele_id)
);

-- RG-VII-04/05 — portee_disciplinaire n'autorise pas le comité à statuer
-- seul sur l'issue finale (Module X, pas encore construit) : simple
-- drapeau informatif pour cette itération.
create table if not exists public.decisions (
  id uuid primary key,
  seance_id uuid not null references public.seances_comite(id) on delete cascade,
  libelle text not null,
  resultat_vote text,
  statut text not null default 'ajourne' check (statut in ('adopte', 'rejete', 'ajourne')),
  portee_disciplinaire boolean not null default false
);

create index if not exists idx_decisions_seance on public.decisions (seance_id);

-- RG-VII-02/03 — document_archive_id reste NULL tant que le Module VIII
-- (archivage, RG-VIII-01) n'est pas construit.
create table if not exists public.proces_verbaux (
  id uuid primary key,
  seance_id uuid not null references public.seances_comite(id) on delete cascade,
  contenu text not null,
  statut text not null default 'brouillon' check (statut in ('brouillon', 'valide')),
  document_archive_id text,
  constraint proces_verbaux_seance_key unique (seance_id)
);

-- RG-VII-02 — correction tracée, jamais de modification silencieuse du PV
-- original.
create table if not exists public.erratums_pv (
  id uuid primary key,
  proces_verbal_id uuid not null references public.proces_verbaux(id) on delete cascade,
  texte text not null,
  date_ajout timestamptz not null,
  auteur_fidele_id uuid references public.fideles(id) on delete set null
);

create index if not exists idx_erratums_pv_proces_verbal on public.erratums_pv (proces_verbal_id);

-- RG-VII-03 — tâches de suivi issues d'une décision.
create table if not exists public.taches_suivi (
  id uuid primary key,
  decision_id uuid not null references public.decisions(id) on delete cascade,
  description text not null,
  assigne_fidele_id uuid not null references public.fideles(id) on delete cascade,
  statut text not null default 'a_faire' check (statut in ('a_faire', 'fait')),
  date_creation timestamptz not null
);

create index if not exists idx_taches_suivi_decision on public.taches_suivi (decision_id);
create index if not exists idx_taches_suivi_assigne on public.taches_suivi (assigne_fidele_id);

alter table public.quorums_comite enable row level security;
alter table public.membres_comite enable row level security;
alter table public.seances_comite enable row level security;
alter table public.presents_seance enable row level security;
alter table public.decisions enable row level security;
alter table public.proces_verbaux enable row level security;
alter table public.erratums_pv enable row level security;
alter table public.taches_suivi enable row level security;
