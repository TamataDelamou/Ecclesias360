-- Module II, écran 13 (RG-II-11) — notes pastorales privées.
--
-- Première table créée après l'activation groupée des policies (0019) :
-- ses policies sont actives dès cette migration (AGENTS.md §10).
--
-- 1. notes_pastorales : table dédiée (jamais un champ de `fideles` ni de
--    `historique_fideles`). `noeud_id` fige le nœud du fidèle à la
--    rédaction : la note reste à ce nœud, elle ne suit pas une mutation
--    (Module IX) vers les pasteurs d'une autre église.
-- 2. Confidentialité (RG-II-11, RG-SEC-06) : lecture par l'auteur ou un
--    pasteur (ou plus) du périmètre du nœud de la note ; le fidèle concerné
--    est exclu **avant tout le reste**, même pasteur de son propre nœud ;
--    l'administrateur lit par son rang (`dans_perimetre()` non borné, même
--    modèle que le Module X). Rédaction : pasteur du périmètre, auteur =
--    compte réel, jamais sur sa propre fiche. Modification : l'auteur seul,
--    contenu seulement (privilèges de colonne) — fidèle, auteur et nœud sont
--    immuables. Aucune suppression par un client.
-- 3. consultations_notes_pastorales : journal des ouvertures, ajout seul
--    (RG-SEC-06 étendu par analogie aux notes pastorales, RG-II-11). Lu par
--    qui lit la note (auteur, pasteurs du périmètre), jamais par le fidèle
--    concerné ; une ligne ne s'écrit qu'en son propre nom, pour une note
--    effectivement lisible.

-- ---------------------------------------------------------------------
-- 1. Table
-- ---------------------------------------------------------------------
create table if not exists public.notes_pastorales (
  id uuid primary key,
  fidele_id uuid not null references public.fideles(id),
  auteur_fidele_id uuid not null references public.fideles(id),
  noeud_id uuid not null references public.organisation_nodes(id),
  contenu text not null check (length(btrim(contenu)) > 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint notes_pastorales_jamais_sur_soi check (fidele_id <> auteur_fidele_id)
);

create index if not exists idx_notes_pastorales_fidele on public.notes_pastorales (fidele_id);
create index if not exists idx_notes_pastorales_noeud on public.notes_pastorales (noeud_id);

alter table public.notes_pastorales enable row level security;

revoke all on public.notes_pastorales from anon;
revoke update, delete, truncate on public.notes_pastorales from authenticated;
grant update (contenu, updated_at) on public.notes_pastorales to authenticated;

-- ---------------------------------------------------------------------
-- 2. Règle de confidentialité
-- ---------------------------------------------------------------------
-- Une seule définition, partagée par la policy de lecture et par le journal.
create or replace function public.note_pastorale_accessible(p_note uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select exists (
    select 1 from public.notes_pastorales n
    where n.id = p_note
      and n.fidele_id is distinct from public.fidele_courant_id()
      and (n.auteur_fidele_id = public.fidele_courant_id()
           or (public.a_role_minimal('pasteur') and public.dans_perimetre(n.noeud_id)))
  );
$$;

revoke all on function public.note_pastorale_accessible(uuid) from public, anon;
grant execute on function public.note_pastorale_accessible(uuid) to authenticated;

drop policy if exists notes_pastorales_lecture on public.notes_pastorales;
drop policy if exists notes_pastorales_redaction on public.notes_pastorales;
drop policy if exists notes_pastorales_modification on public.notes_pastorales;

create policy notes_pastorales_lecture on public.notes_pastorales
  for select to authenticated
  using (fidele_id is distinct from (select public.fidele_courant_id())
         and (auteur_fidele_id = (select public.fidele_courant_id())
              or ((select public.a_role_minimal('pasteur')) and public.dans_perimetre(noeud_id))));

-- Le nœud figé est celui du fidèle au moment de la rédaction : un pasteur ne
-- peut pas rattacher la note à un nœud de son périmètre autre que celui du
-- fidèle pour s'ouvrir un accès.
create policy notes_pastorales_redaction on public.notes_pastorales
  for insert to authenticated
  with check ((select public.a_role_minimal('pasteur'))
              and auteur_fidele_id = (select public.fidele_courant_id())
              and fidele_id <> (select public.fidele_courant_id())
              and noeud_id = public.noeud_du_fidele(fidele_id)
              and public.dans_perimetre(noeud_id)
              and created_at <= now() + interval '5 minutes');

create policy notes_pastorales_modification on public.notes_pastorales
  for update to authenticated
  using (auteur_fidele_id = (select public.fidele_courant_id())
         and fidele_id <> (select public.fidele_courant_id()))
  with check (auteur_fidele_id = (select public.fidele_courant_id())
              and fidele_id <> (select public.fidele_courant_id()));

-- ---------------------------------------------------------------------
-- 3. Journal des consultations
-- ---------------------------------------------------------------------
create table if not exists public.consultations_notes_pastorales (
  id uuid primary key,
  note_id uuid not null references public.notes_pastorales(id),
  auth_user_id uuid not null,
  fidele_id uuid references public.fideles(id),
  role text not null,
  consulte_le timestamptz not null default now()
);

create index if not exists idx_consultations_notes_pastorales_note
  on public.consultations_notes_pastorales (note_id);

alter table public.consultations_notes_pastorales enable row level security;

revoke all on public.consultations_notes_pastorales from anon;
revoke update, delete, truncate on public.consultations_notes_pastorales from authenticated;

drop policy if exists consultations_notes_pastorales_lecture on public.consultations_notes_pastorales;
drop policy if exists consultations_notes_pastorales_creation on public.consultations_notes_pastorales;

create policy consultations_notes_pastorales_lecture on public.consultations_notes_pastorales
  for select to authenticated
  using (public.note_pastorale_accessible(note_id));

-- Sa propre consultation seulement (compte, fiche et rôle réels), d'une note
-- qu'on peut effectivement lire. Pas de date future (une consultation hors
-- ligne peut arriver en retard).
create policy consultations_notes_pastorales_creation on public.consultations_notes_pastorales
  for insert to authenticated
  with check (auth_user_id = (select auth.uid())
              and fidele_id is not distinct from (select public.fidele_courant_id())
              and role = (select public.role_courant())
              and consulte_le <= now() + interval '5 minutes'
              and public.note_pastorale_accessible(note_id));
