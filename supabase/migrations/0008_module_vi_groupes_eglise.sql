-- Module VI — Gestion des groupes de l'Église (RG-VI-01 à 03). Dépend de
-- fideles (0002), créée avant ce fichier — respecte l'ordre de dépendance.

-- RG-VI-01/02 — segment démographique ou fonctionnel de l'assemblée.
-- criteres_json n'est renseigné que pour type_regle = 'auto' (format
-- CriteresGroupe.toJson() côté Dart).
create table if not exists public.groupes_eglise (
  id uuid primary key,
  code text not null,
  libelle text not null,
  type_regle text not null check (type_regle in ('auto', 'manuel')),
  criteres_json jsonb,
  constraint groupes_eglise_code_key unique (code)
);

-- RG-VI-01/02 — non exclusif : un fidèle peut appartenir à plusieurs
-- groupes simultanément (contrainte UNIQUE seulement pour éviter un
-- doublon fidèle/groupe, jamais pour restreindre le nombre de groupes).
create table if not exists public.appartenances_groupe (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id) on delete cascade,
  groupe_id uuid not null references public.groupes_eglise(id) on delete cascade,
  date_affectation timestamptz not null,
  origine text not null check (origine in ('auto', 'manuel')),
  motif_derogation text,
  constraint appartenances_groupe_fidele_groupe_key unique (fidele_id, groupe_id)
);

create index if not exists idx_appartenances_groupe_fidele on public.appartenances_groupe (fidele_id);
create index if not exists idx_appartenances_groupe_groupe on public.appartenances_groupe (groupe_id);

alter table public.groupes_eglise enable row level security;
alter table public.appartenances_groupe enable row level security;

-- RG-VI-01 — sept groupes démographiques calculables + quatre groupes
-- fonctionnels manuels, mêmes codes que `groupesEgliseDeDepart`
-- (lib/features/organization/data/local/app_database.dart).
insert into public.groupes_eglise (id, code, libelle, type_regle, criteres_json)
values
  (gen_random_uuid(), 'hommes', 'Hommes', 'auto', '{"sexe":"masculin"}'),
  (gen_random_uuid(), 'femmes', 'Femmes', 'auto', '{"sexe":"feminin"}'),
  (gen_random_uuid(), 'jeunesse', 'Jeunesse', 'auto', '{"ageMin":12,"ageMax":35}'),
  (gen_random_uuid(), 'couples', 'Couples', 'auto', '{"statutCivil":"marie"}'),
  (gen_random_uuid(), 'celibataires', 'Célibataires', 'auto', '{"statutCivil":"celibataire"}'),
  (gen_random_uuid(), 'veuves', 'Veuves', 'auto', '{"statutCivil":"veuf"}'),
  (gen_random_uuid(), 'nouveaux_convertis', 'Nouveaux convertis', 'auto', '{"statutSpirituel":"nouveau_converti"}'),
  (gen_random_uuid(), 'missionnaires', 'Missionnaires', 'manuel', null),
  (gen_random_uuid(), 'pasteurs', 'Pasteurs', 'manuel', null),
  (gen_random_uuid(), 'anciens', 'Anciens', 'manuel', null),
  (gen_random_uuid(), 'diacres', 'Diacres', 'manuel', null)
on conflict (code) do nothing;
