-- Module XX — Biens (patrimoine), RG-XX-01 à 05. Dépend de
-- organisation_nodes (0001), fideles (0002) et cultes (0010, module XII).

-- RG-XX-01 — référentiel fermé et extensible des catégories de biens
-- (mêmes codes que le seed local, app_database.dart).
create table if not exists public.categories_bien (
  id uuid primary key,
  code text not null unique,
  libelle text not null,
  standard boolean not null default false,
  statut text not null default 'actif'
);

insert into public.categories_bien (id, code, libelle, standard) values
  (gen_random_uuid(), 'terrains', 'Terrains', true),
  (gen_random_uuid(), 'batiments', 'Bâtiments', true),
  (gen_random_uuid(), 'vehicules', 'Véhicules', true),
  (gen_random_uuid(), 'instruments_musique', 'Instruments de musique', true),
  (gen_random_uuid(), 'cameras', 'Caméras', true),
  (gen_random_uuid(), 'sonorisation', 'Sonorisation', true),
  (gen_random_uuid(), 'ordinateurs', 'Ordinateurs', true),
  (gen_random_uuid(), 'mobilier', 'Mobilier', true),
  (gen_random_uuid(), 'stocks', 'Stocks (fournitures)', true)
on conflict (code) do nothing;

-- RG-XX-01/02/05 — bien du patrimoine. id_inventaire est l'identifiant
-- d'inventaire unique exigé par le Cahier, distinct de id. Les colonnes
-- type_sortie/date_sortie/valide_par_fidele_id_sortie/motif_sortie tracent
-- la sortie définitive du patrimoine (RG-XX-02) : aucun mouvement
-- comptable n'est généré côté Module XXI (Comptabilité, non construit).
-- seuil_alerte_stock ne s'applique qu'aux biens à gestion de stock
-- (RG-XX-05).
create table if not exists public.biens (
  id uuid primary key,
  id_inventaire text not null unique,
  categorie_id uuid not null references public.categories_bien(id),
  noeud_id uuid not null references public.organisation_nodes(id),
  designation text not null,
  etat text not null default 'neuf'
    check (etat in ('neuf', 'bon', 'a_reparer', 'hors_service', 'cede')),
  valeur_acquisition integer not null,
  valeur_venale integer not null,
  devise text not null,
  date_acquisition timestamptz not null,
  seuil_alerte_stock integer,
  type_sortie text check (type_sortie in ('cession', 'don', 'mise_au_rebut')),
  date_sortie timestamptz,
  valide_par_fidele_id_sortie uuid references public.fideles(id),
  motif_sortie text
);

create index if not exists idx_biens_noeud on public.biens (noeud_id);
create index if not exists idx_biens_categorie on public.biens (categorie_id);

-- RG-XX-03 — réservation datée d'un bien mobilisable, pour un culte ou un
-- événement. culte_id référence un culte existant (Module XII) ;
-- objet_libre porte la description libre pour evenement/autre (le Module
-- XVIII, Événements, n'existe pas encore).
create table if not exists public.reservations_bien (
  id uuid primary key,
  bien_id uuid not null references public.biens(id),
  objet_reservation text not null check (objet_reservation in ('culte', 'evenement', 'autre')),
  culte_id uuid references public.cultes(id),
  objet_libre text,
  date_debut timestamptz not null,
  date_fin timestamptz not null
);

create index if not exists idx_reservations_bien_bien on public.reservations_bien (bien_id);

-- RG-XX-05 — mouvement d'entrée ou de sortie d'un bien à gestion de stock.
-- La quantité en stock n'est pas une colonne stockée : elle se recalcule à
-- la lecture (entrées moins sorties).
create table if not exists public.mouvements_stock (
  id uuid primary key,
  bien_id uuid not null references public.biens(id),
  type text not null check (type in ('entree', 'sortie')),
  quantite integer not null,
  date timestamptz not null,
  motif text
);

create index if not exists idx_mouvements_stock_bien on public.mouvements_stock (bien_id);

-- RG-XX-04 — campagne d'inventaire physique périodique d'un nœud. Entité
-- ajoutée au-delà du tableau minimal du Cahier (même précédent que
-- erratums_pv, module VII).
create table if not exists public.campagnes_inventaire (
  id uuid primary key,
  noeud_id uuid not null references public.organisation_nodes(id),
  libelle text not null,
  date_debut timestamptz not null,
  date_cloture timestamptz,
  statut text not null default 'en_cours' check (statut in ('en_cours', 'cloturee'))
);

create index if not exists idx_campagnes_inventaire_noeud on public.campagnes_inventaire (noeud_id);

-- RG-XX-04 — pointage terrain d'un bien lors d'une campagne d'inventaire.
-- ecart_detecte est calculé et figé au moment du pointage (enregistrement
-- d'audit, pas un solde courant).
create table if not exists public.pointages_inventaire (
  id uuid primary key,
  campagne_id uuid not null references public.campagnes_inventaire(id) on delete cascade,
  bien_id uuid not null references public.biens(id),
  etat_constate text not null check (etat_constate in ('neuf', 'bon', 'a_reparer', 'hors_service', 'cede')),
  quantite_constatee integer,
  ecart_detecte boolean not null default false,
  commentaire text,
  date_du_pointage timestamptz not null
);

create index if not exists idx_pointages_inventaire_campagne on public.pointages_inventaire (campagne_id);
create index if not exists idx_pointages_inventaire_bien on public.pointages_inventaire (bien_id);

alter table public.categories_bien enable row level security;
alter table public.biens enable row level security;
alter table public.reservations_bien enable row level security;
alter table public.mouvements_stock enable row level security;
alter table public.campagnes_inventaire enable row level security;
alter table public.pointages_inventaire enable row level security;
