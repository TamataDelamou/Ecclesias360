-- Module XXIII — Paramètres de l'application (référentiel ZoneGeographique,
-- RG-XXIII-01/03). Dépend de organisation_nodes (0001), créée avant ce
-- fichier — respecte l'ordre de dépendance.

create table if not exists public.zones_geographiques (
  id uuid primary key,
  libelle text not null,
  niveau integer not null default 0,
  parent_id uuid references public.zones_geographiques(id) on delete restrict,
  statut text not null default 'actif' check (statut in ('actif', 'desactive'))
);

create index if not exists idx_zones_geographiques_parent on public.zones_geographiques (parent_id);

-- Complète la FK laissée non contrainte dans 0001_organisation_nodes.sql :
-- organisation_nodes existait avant que ce référentiel Module XXIII ne
-- soit construit (ordre de dépendance des modules, pas un oubli).
alter table public.organisation_nodes
  add constraint fk_organisation_nodes_zone_geo
  foreign key (zone_geo_id) references public.zones_geographiques(id) on delete set null;

alter table public.zones_geographiques enable row level security;
