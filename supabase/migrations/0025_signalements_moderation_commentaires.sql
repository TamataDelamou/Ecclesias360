-- Module XIII (RG-XIII-03) — signalements attribués et modération tracée.
--
-- 1. signalements_commentaire : un signalement par fidèle et par commentaire
--    (contrainte unique), jamais sur son propre commentaire. Remplace le
--    simple compteur `nombre_signalements`, qui n'était attribué à personne :
--    un seul fidèle pouvait masquer n'importe quel commentaire en le
--    signalant trois fois.
-- 2. Masquage automatique par déclencheur : un commentaire publié est masqué
--    quand les **signaleurs distincts** depuis la dernière décision de
--    modération atteignent le seuil. `nombre_signalements` devient une valeur
--    dérivée, recalculée par ce déclencheur. Le seuil est défini une seule
--    fois ici (`seuil_masquage_commentaire()`) ; il doit rester égal à
--    `AppDefaults.mediathequeSeuilSignalementsAvantMasquage` — un test Dart
--    (`seuil_masquage_coherence_test.dart`) lit cette migration et échoue si
--    les deux valeurs divergent.
-- 3. Modération tracée : `modere_par` (fiche du modérateur, obligatoirement
--    celle du compte réel) et `date_moderation`. Un modérateur ne modifie plus
--    que le statut et la trace de sa décision — plus le texte ni l'auteur
--    (la policy de 0019 lui ouvrait toutes les colonnes).

-- ---------------------------------------------------------------------
-- 1. Signalements attribués
-- ---------------------------------------------------------------------
create table if not exists public.signalements_commentaire (
  id uuid primary key,
  commentaire_id uuid not null references public.commentaires(id),
  fidele_id uuid not null references public.fideles(id),
  motif text,
  created_at timestamptz not null default now(),
  constraint signalements_commentaire_unique unique (commentaire_id, fidele_id)
);

create index if not exists idx_signalements_commentaire_commentaire
  on public.signalements_commentaire (commentaire_id);

alter table public.signalements_commentaire enable row level security;

revoke all on public.signalements_commentaire from anon;
revoke update, delete, truncate on public.signalements_commentaire from authenticated;

create or replace function public.contenu_du_commentaire(p_commentaire uuid)
returns uuid
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  select contenu_id from public.commentaires where id = p_commentaire;
$$;

revoke all on function public.contenu_du_commentaire(uuid) from public, anon;
grant execute on function public.contenu_du_commentaire(uuid) to authenticated;

-- Lecture : ses propres signalements, ou le modérateur du contenu (contexte
-- de décision). Le fidèle signalé ne voit pas qui l'a signalé.
create policy signalements_commentaire_lecture on public.signalements_commentaire
  for select to authenticated
  using (fidele_id = (select public.fidele_courant_id())
         or public.moderateur_du_contenu(public.contenu_du_commentaire(commentaire_id)));

-- Écriture : en son nom seul, sur un commentaire publié d'autrui qu'il peut
-- lire, sans date future (une date future compterait après toute décision).
create policy signalements_commentaire_creation on public.signalements_commentaire
  for insert to authenticated
  with check ((select public.a_role_minimal('membre'))
              and fidele_id = (select public.fidele_courant_id())
              and created_at <= now() + interval '5 minutes'
              and exists (select 1 from public.commentaires c
                          where c.id = commentaire_id
                            and c.statut_moderation = 'publie'
                            and c.fidele_id <> (select public.fidele_courant_id())));

-- ---------------------------------------------------------------------
-- 2. Masquage automatique sur signaleurs distincts
-- ---------------------------------------------------------------------
create or replace function public.seuil_masquage_commentaire()
returns integer
language sql
immutable
as $$ select 3 $$;

create or replace function public.appliquer_signalement_commentaire()
returns trigger
language plpgsql
security definer
set search_path = pg_catalog, pg_temp
as $$
declare
  depuis timestamptz;
  signaleurs integer;
begin
  select date_moderation into depuis from public.commentaires where id = new.commentaire_id;
  select count(distinct s.fidele_id) into signaleurs
    from public.signalements_commentaire s
    where s.commentaire_id = new.commentaire_id
      and (depuis is null or s.created_at > depuis);
  update public.commentaires
    set nombre_signalements = signaleurs,
        statut_moderation = case
          when statut_moderation = 'publie' and signaleurs >= public.seuil_masquage_commentaire() then 'masque'
          else statut_moderation
        end
    where id = new.commentaire_id;
  return null;
end;
$$;

revoke all on function public.appliquer_signalement_commentaire() from public, anon, authenticated;

drop trigger if exists appliquer_signalement_commentaire on public.signalements_commentaire;
create trigger appliquer_signalement_commentaire
  after insert on public.signalements_commentaire
  for each row execute function public.appliquer_signalement_commentaire();

-- ---------------------------------------------------------------------
-- 3. Modération tracée, bornée au statut
-- ---------------------------------------------------------------------
alter table public.commentaires
  add column if not exists modere_par uuid references public.fideles(id),
  add column if not exists date_moderation timestamptz;

revoke update on public.commentaires from anon, authenticated;
grant update (statut_moderation, modere_par, date_moderation, nombre_signalements) on public.commentaires to authenticated;

drop policy if exists commentaires_moderation on public.commentaires;
create policy commentaires_moderation on public.commentaires for update to authenticated
  using (public.moderateur_du_contenu(contenu_id))
  with check (public.moderateur_du_contenu(contenu_id)
              and modere_par = (select public.fidele_courant_id())
              and date_moderation is not null);
