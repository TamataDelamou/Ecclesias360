-- RG-XXIII-06 — toute modification des paramètres est historisée avec auteur,
-- date et valeur précédente ; RG-II-05 — l'auteur d'une modification de fiche
-- fidèle est la personne réelle.
--
-- 1. journal_parametres : alimenté par un déclencheur sur CHACUN des
--    référentiels administrés (les mêmes que la boucle « G » de 0019), et non
--    par le client : une écriture qui passe la policy (administrateur) ne peut
--    pas échapper à sa trace. Aucun client n'écrit, ne modifie ni n'efface le
--    journal ; seul l'administrateur le lit.
-- 2. historique_fideles : l'auteur inscrit doit être la fiche liée au compte
--    réel (ou vide pour un compte sans fiche) — jamais un tiers.

-- ---------------------------------------------------------------------
-- 1. Journal des modifications des paramètres
-- ---------------------------------------------------------------------
create table if not exists public.journal_parametres (
  id uuid primary key default gen_random_uuid(),
  referentiel text not null,
  objet_id text not null,
  action text not null check (action in ('insert', 'update', 'delete')),
  ancienne_valeur jsonb,
  nouvelle_valeur jsonb,
  auteur_auth_user_id uuid,
  auteur_fidele_id uuid,
  date timestamptz not null default now()
);

create index if not exists idx_journal_parametres_date on public.journal_parametres (date desc);

alter table public.journal_parametres enable row level security;

revoke all on public.journal_parametres from anon;
revoke insert, update, delete, truncate on public.journal_parametres from authenticated;

create policy journal_parametres_lecture on public.journal_parametres
  for select to authenticated
  using ((select public.est_administrateur()));

-- security definer : le déclencheur écrit au nom de l'application, le client
-- n'ayant aucun privilège d'écriture sur le journal. L'auteur est lu dans le
-- jeton (auth.uid()), jamais fourni par le client.
create or replace function public.historiser_parametre()
returns trigger
language plpgsql
security definer
set search_path = pg_catalog, pg_temp
as $$
begin
  insert into public.journal_parametres
    (referentiel, objet_id, action, ancienne_valeur, nouvelle_valeur, auteur_auth_user_id, auteur_fidele_id)
  values (
    tg_table_name,
    coalesce(
      case when tg_op = 'DELETE' then null else to_jsonb(new) ->> 'id' end,
      case when tg_op = 'INSERT' then null else to_jsonb(old) ->> 'id' end
    ),
    lower(tg_op),
    case when tg_op = 'INSERT' then null else to_jsonb(old) end,
    case when tg_op = 'DELETE' then null else to_jsonb(new) end,
    auth.uid(),
    public.fidele_courant_id()
  );
  return null;
end;
$$;

revoke all on function public.historiser_parametre() from public, anon, authenticated;

do $$
declare
  t text;
begin
  foreach t in array array[
    'zones_geographiques', 'types_ministeres', 'dons_spirituels', 'dons_ministeres_compatibles',
    'professions', 'groupes_eglise', 'nomenclatures_archivage', 'natures_faute', 'types_offrande',
    'categories_bien', 'comptes_comptables'
  ] loop
    execute format('drop trigger if exists historiser_parametre on public.%I', t);
    execute format(
      'create trigger historiser_parametre after insert or update or delete on public.%I
         for each row execute function public.historiser_parametre()', t);
  end loop;
end $$;

-- ---------------------------------------------------------------------
-- 2. Auteur réel de l'historique des fiches fidèles (RG-II-05)
-- ---------------------------------------------------------------------
drop policy if exists historique_fideles_creation on public.historique_fideles;
create policy historique_fideles_creation on public.historique_fideles for insert to authenticated
  with check (public.dans_perimetre(public.noeud_du_fidele(fidele_id))
              and auteur_fidele_id is not distinct from (select public.fidele_courant_id()));
