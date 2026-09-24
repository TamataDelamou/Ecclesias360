-- Module VIII (RG-VIII-03) et Module X (RG-X-05) — confidentialité des
-- archives tirée de leur source, et journal des consultations
-- disciplinaires (RG-SEC-06).
--
-- 1. Une pièce disciplinaire archivée n'est plus protégée par son seul niveau
--    stocké (`restreint`), que la policy documents_archive_modification de
--    0019 laissait un pasteur du périmètre abaisser à `standard` — ce qui la
--    rendait lisible par tout responsable du périmètre, hors de la règle du
--    dossier. Désormais :
--    - un document rattaché à un dossier disciplinaire (origine `discipline`
--      ou pièce de `pieces_dossier`) n'est lu que si CHACUN de ces dossiers
--      l'est (dossier_disciplinaire_accessible : pasteur du périmètre ou
--      commission assignée), quel que soit son niveau ;
--    - le niveau, l'origine, le nœud et le numéro d'un document archivé sont
--      immuables (privilèges de colonne) : seules les colonnes que l'archivage
--      modifie réellement (nouvelle version, corbeille) restent modifiables.
-- 2. Table consultations_disciplinaires : ajout seul, jamais modifiée ni
--    supprimée par un utilisateur (RG-SEC-06, RG-SEC-11) ; l'auteur tracé est
--    toujours le compte réel.

-- ---------------------------------------------------------------------
-- 1. Confidentialité tirée de la source
-- ---------------------------------------------------------------------
create or replace function public.document_archive_accessible(p_document uuid)
returns boolean
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  with doc as (
    select d.* from public.documents_archive d where d.id = p_document
  ),
  dossiers_rattaches as (
    select x.id from public.dossiers_disciplinaires x join doc on doc.module_origine = 'discipline'
      and x.id::text = doc.objet_id_origine
    union
    select p.dossier_id from public.pieces_dossier p where p.document_archive_id = p_document
  )
  select case
    when exists (select 1 from doc where doc.module_origine = 'discipline')
      or exists (select 1 from public.pieces_dossier p where p.document_archive_id = p_document)
    then
      -- Origine disciplinaire introuvable : refus, jamais un repli sur le niveau.
      not exists (select 1 from doc where doc.module_origine = 'discipline'
                    and not exists (select 1 from public.dossiers_disciplinaires x
                                    where x.id::text = doc.objet_id_origine))
      and not exists (select 1 from dossiers_rattaches r
                      where not public.dossier_disciplinaire_accessible(r.id))
    else exists (
      select 1 from doc
      where public.dans_perimetre(doc.noeud_id)
        and (doc.niveau_confidentialite = 'standard' or public.a_role_minimal('pasteur'))
    )
  end;
$$;

revoke update on public.documents_archive from anon, authenticated;
grant update (fichier, statut, date_mise_corbeille, updated_at) on public.documents_archive to authenticated;

-- ---------------------------------------------------------------------
-- 2. Journal des consultations disciplinaires
-- ---------------------------------------------------------------------
-- document_archive_id sans clé étrangère : la purge d'un document
-- (RG-VIII-05) ne doit ni échouer ni effacer la trace d'audit.
create table if not exists public.consultations_disciplinaires (
  id uuid primary key,
  dossier_id uuid not null references public.dossiers_disciplinaires(id),
  document_archive_id uuid,
  auth_user_id uuid not null,
  fidele_id uuid references public.fideles(id),
  role text not null,
  consulte_le timestamptz not null default now()
);

create index if not exists idx_consultations_disciplinaires_dossier
  on public.consultations_disciplinaires (dossier_id);

alter table public.consultations_disciplinaires enable row level security;

revoke all on public.consultations_disciplinaires from anon;
revoke update, delete, truncate on public.consultations_disciplinaires from authenticated;

-- Lecture : pasteur (ou plus) du périmètre du dossier — le journal révèle qui
-- s'est intéressé à un dossier, il n'est pas ouvert à la commission.
create policy consultations_disciplinaires_lecture on public.consultations_disciplinaires
  for select to authenticated
  using ((select public.a_role_minimal('pasteur'))
         and exists (select 1 from public.dossiers_disciplinaires d
                     where d.id = dossier_id and public.dans_perimetre(d.noeud_id)));

-- Écriture : uniquement sa propre consultation (compte, fiche et rôle réels),
-- d'un dossier — et, le cas échéant, d'une pièce — qu'on peut effectivement
-- lire. Pas de date future (une consultation hors ligne peut arriver en retard).
create policy consultations_disciplinaires_creation on public.consultations_disciplinaires
  for insert to authenticated
  with check (auth_user_id = (select auth.uid())
              and fidele_id is not distinct from (select public.fidele_courant_id())
              and role = (select public.role_courant())
              and consulte_le <= now() + interval '5 minutes'
              and public.dossier_disciplinaire_accessible(dossier_id)
              and (document_archive_id is null or public.document_archive_accessible(document_archive_id)));
