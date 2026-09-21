-- Module XXI — Comptabilité, RG-XXI-01 à 06. Dépend de organisation_nodes
-- (0001), contributions (0014, module XI) et biens (0015, module XX) comme
-- producteurs d'écritures miroir (RG-XXI-02).

-- RG-XXI-01 — plan comptable paramétrable, référentiel fermé et extensible.
-- Codes génériques (le Cahier n'impose aucun plan comptable réel), même
-- seed local qu'app_database.dart.
create table if not exists public.comptes_comptables (
  id uuid primary key,
  code_compte text not null unique,
  libelle text not null,
  type text not null check (type in ('actif', 'passif', 'charge', 'produit')),
  statut text not null default 'actif'
);

insert into public.comptes_comptables (id, code_compte, libelle, type) values
  (gen_random_uuid(), '512000', 'Banque', 'actif'),
  (gen_random_uuid(), '530000', 'Caisse', 'actif'),
  (gen_random_uuid(), '211000', 'Immobilisations et biens', 'actif'),
  (gen_random_uuid(), '706000', 'Produits des contributions', 'produit'),
  (gen_random_uuid(), '758000', 'Produits de cession de biens', 'produit'),
  (gen_random_uuid(), '651000', 'Charges diverses', 'charge'),
  (gen_random_uuid(), '675000', 'Charges — sorties d''actifs', 'charge')
on conflict (code_compte) do nothing;

-- RG-XXI-03 — période comptable (exercice). Globale (aucune colonne
-- noeud_id, le Cahier ne le prévoit pas pour cette entité) ; une fois
-- clôturée elle devient immuable.
create table if not exists public.periodes_comptables (
  id uuid primary key,
  exercice integer not null unique,
  date_debut timestamptz not null,
  date_fin timestamptz not null,
  statut text not null default 'ouverte' check (statut in ('ouverte', 'cloturee'))
);

-- RG-XXI-01/02/03/05 — écriture comptable en partie double : chaque
-- opération génère deux lignes équilibrées (débit + crédit) partageant le
-- même piece_justificative_id. rapproche (RG-XXI-05, rapprochement
-- bancaire) est une colonne ajoutée au-delà du tableau minimal du Cahier,
-- même précédent que biens.seuil_alerte_stock (module XX).
create table if not exists public.ecritures_comptables (
  id uuid primary key,
  date timestamptz not null,
  compte_id uuid not null references public.comptes_comptables(id),
  debit integer not null default 0,
  credit integer not null default 0,
  noeud_id uuid not null references public.organisation_nodes(id),
  piece_justificative_id text,
  periode_id uuid not null references public.periodes_comptables(id),
  libelle text,
  rapproche boolean not null default false
);

create index if not exists idx_ecritures_comptables_noeud on public.ecritures_comptables (noeud_id);
create index if not exists idx_ecritures_comptables_compte on public.ecritures_comptables (compte_id);
create index if not exists idx_ecritures_comptables_periode on public.ecritures_comptables (periode_id);

-- RG-XXI-04 — budget prévisionnel par nœud, période et compte.
-- seuil_alerte_pourcentage est une colonne ajoutée au-delà du tableau
-- minimal du Cahier (seuil d'alerte « paramétrable » sans support nommé),
-- même précédent que biens.seuil_alerte_stock (module XX).
create table if not exists public.budgets (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id),
  periode_id uuid not null references public.periodes_comptables(id),
  compte_id uuid not null references public.comptes_comptables(id),
  montant_prevu integer not null,
  seuil_alerte_pourcentage integer
);

create index if not exists idx_budgets_noeud_periode on public.budgets (noeud_id, periode_id);

alter table public.comptes_comptables enable row level security;
alter table public.periodes_comptables enable row level security;
alter table public.ecritures_comptables enable row level security;
alter table public.budgets enable row level security;
