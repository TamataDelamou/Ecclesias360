-- RG-SEC-01 / RG-XI-02 — un administrateur sans fiche (typiquement
-- l'administrateur d'amorçage) lie son propre compte à sa fiche fidèle, pour
-- être tracé comme une personne du registre lors des validations
-- financières et patrimoniales (séparation des tâches) — jamais comme un
-- compte technique.
--
-- Miroir SQL de `LiaisonCompteRules.raisonBlocageLiaisonAdministrateur` /
-- `CompteRepository.lierMonCompteAFiche` (Dart) : les deux doivent rester
-- strictement équivalents, même précédent que `enregistrer_compte_courant()`.
-- Les colonnes `auth_user_id` et `role` de `fideles` ne sont jamais
-- modifiables par un client (privilèges de colonne, 0018) : cette fonction
-- est le seul chemin.

create or replace function public.lier_mon_compte_a_fiche(p_fidele_id uuid)
returns void
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $$
declare
  v_uid uuid := auth.uid();
  v_identifiant text;
  v_fiche public.fideles%rowtype;
begin
  if v_uid is null then
    raise exception 'authentification requise' using errcode = '28000';
  end if;
  if public.role_courant() is distinct from 'administrateur' then
    raise exception 'action réservée à un administrateur' using errcode = '42501';
  end if;
  if exists (select 1 from public.fideles where auth_user_id = v_uid) then
    raise exception 'compte déjà lié à une fiche' using errcode = '22023';
  end if;

  select * into v_fiche from public.fideles where id = p_fidele_id for update;
  if not found then
    raise exception 'fiche introuvable' using errcode = '22023';
  end if;
  -- Même garde-fou que la liaison automatique (recyclage de numéros) : une
  -- fiche liée, maintenant ou par le passé, passe par la résolution d'un conflit.
  if v_fiche.auth_user_id is not null or exists (
    select 1 from public.journal_liaisons_comptes j
    where j.fidele_id = p_fidele_id
      and (j.issue = 'lie_automatiquement' or j.statut = 'resolu_lie')
  ) then
    raise exception 'fiche déjà liée à un compte' using errcode = '22023';
  end if;

  select identifiant into v_identifiant from public.comptes_utilisateurs where auth_user_id = v_uid;

  -- Le rôle de la fiche devient administrateur : sinon son rôle propre
  -- (membre par défaut) rétrograderait le compte en le liant.
  update public.fideles set auth_user_id = v_uid, role = 'administrateur' where id = p_fidele_id;

  insert into public.journal_liaisons_comptes
    (auth_user_id, identifiant, fidele_id, issue, statut, resolu_par_auth_user_id, resolu_le)
  values
    (v_uid, coalesce(v_identifiant, ''), p_fidele_id, 'administrateur_amorcage', 'resolu_lie', v_uid, now());
end;
$$;

revoke all on function public.lier_mon_compte_a_fiche(uuid) from public, anon;
grant execute on function public.lier_mon_compte_a_fiche(uuid) to authenticated;
