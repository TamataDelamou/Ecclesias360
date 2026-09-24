/// Erreur métier applicative, distincte des exceptions techniques (réseau,
/// stockage). Le [code] est stable et testable, [message] est destiné à
/// l'utilisateur.
class AppError implements Exception {
  const AppError(this.code, this.message);

  final String code;
  final String message;

  factory AppError.rootAlreadyExists() => const AppError(
        'root_already_exists',
        "Une racine unique (siège) existe déjà pour cette plateforme.",
      );

  factory AppError.parentNotFound() => const AppError(
        'parent_not_found',
        "Le nœud parent indiqué est introuvable.",
      );

  factory AppError.codeInterneAlreadyUsed() => const AppError(
        'code_interne_already_used',
        "Ce code interne est déjà utilisé par un autre nœud.",
      );

  factory AppError.nodeHasBlockingReferences() => const AppError(
        'node_has_blocking_references',
        "Ce nœud ne peut pas être supprimé : des éléments y sont encore rattachés.",
      );

  factory AppError.statutDisciplineReserveAuModuleX() => const AppError(
        'statut_discipline_reserve_au_module_x',
        "Le statut « en discipline » ne peut être déclenché que depuis le module Discipline.",
      );

  factory AppError.fideleHasBlockingReferences() => const AppError(
        'fidele_has_blocking_references',
        "Ce fidèle ne peut pas être supprimé : des éléments y sont encore rattachés. Utilisez l'archivage.",
      );

  factory AppError.mineurSansTuteur() => const AppError(
        'mineur_sans_tuteur',
        "Un tuteur légal doit être enregistré avant de valider le baptême d'un fidèle mineur.",
      );

  factory AppError.referentielEnUsage() => const AppError(
        'referentiel_en_usage',
        "Cette valeur de référentiel est utilisée par des enregistrements existants : "
            "désactivez-la plutôt que de la supprimer.",
      );

  factory AppError.responsableMinistereDejaActif() => const AppError(
        'responsable_ministere_deja_actif',
        "Ce ministère a déjà un responsable actif : clôturez son mandat avant d'en affecter un autre.",
      );

  factory AppError.typeMinistereStandardProtege() => const AppError(
        'type_ministere_standard_protege',
        "Ce type de ministère standard ne peut pas être désactivé.",
      );

  factory AppError.derogationRequisePourAffectationManuelle() => const AppError(
        'derogation_requise_pour_affectation_manuelle',
        "Ce fidèle ne correspond pas aux critères automatiques de ce groupe : "
            "indiquez un motif de dérogation pour l'affecter quand même.",
      );

  factory AppError.quorumNonAtteintPourAdoption() => const AppError(
        'quorum_non_atteint_pour_adoption',
        "Cette décision ne peut être adoptée : le quorum de la séance n'est pas atteint (ou non configuré).",
      );

  factory AppError.procesVerbalValideImmuable() => const AppError(
        'proces_verbal_valide_immuable',
        "Ce procès-verbal est validé et immuable : toute correction doit passer par un erratum tracé.",
      );

  factory AppError.modePresenceIncompatible() => const AppError(
        'mode_presence_incompatible',
        "Ce culte utilise l'autre mode de présence : les deux modes sont mutuellement exclusifs.",
      );

  factory AppError.nomenclatureArchivageIntrouvable() => const AppError(
        'nomenclature_archivage_introuvable',
        "Aucune nomenclature de numérotation n'est configurée pour ce type de document.",
      );

  factory AppError.documentArchiveNonPurgeable() => const AppError(
        'document_archive_non_purgeable',
        "Ce document ne peut pas être purgé : le délai de corbeille n'est pas écoulé (ou le document n'est pas en corbeille).",
      );

  factory AppError.roleInsuffisantPourPurgeDocument() => const AppError(
        'role_insuffisant_pour_purge_document',
        "Seul un pasteur (ou rôle supérieur) peut purger définitivement un document archivé.",
      );

  factory AppError.administrationParametresReservee() => const AppError(
        'administration_parametres_reservee',
        "La modification des paramètres de l'application est réservée à un administrateur.",
      );

  factory AppError.signalementSansFiche() => const AppError(
        'signalement_sans_fiche',
        "Un signalement doit être rattaché à une fiche fidèle : liez d'abord votre compte.",
      );

  factory AppError.signalementPropreCommentaire() => const AppError(
        'signalement_propre_commentaire',
        "Vous ne pouvez pas signaler votre propre commentaire.",
      );

  factory AppError.commentaireDejaSignale() => const AppError(
        'commentaire_deja_signale',
        "Vous avez déjà signalé ce commentaire.",
      );

  factory AppError.moderationReservee() => const AppError(
        'moderation_reservee',
        "La modération des commentaires est réservée à un pasteur (ou rôle supérieur).",
      );

  factory AppError.moderationSansFiche() => const AppError(
        'moderation_sans_fiche',
        "Une décision de modération doit tracer une personne du registre : liez d'abord votre compte à votre fiche.",
      );

  factory AppError.gestionOrganisationReservee() => const AppError(
        'gestion_organisation_reservee',
        "La gestion des nœuds de l'organisation est réservée à un responsable (ou rôle supérieur).",
      );

  factory AppError.capaciteNiveauSuperieurRequise() => const AppError(
        'capacite_niveau_superieur_requise',
        "Créer ou valider un nœud de niveau supérieur exige la capacité dédiée (RG-I-03).",
      );

  factory AppError.designationResponsablesReservee() => const AppError(
        'designation_responsables_reservee',
        "La désignation des responsables d'un nœud est réservée à un pasteur (ou rôle supérieur).",
      );

  factory AppError.suppressionNoeudReservee() => const AppError(
        'suppression_noeud_reservee',
        "La suppression d'un nœud est réservée à un administrateur.",
      );

  factory AppError.gestionFidelesReservee() => const AppError(
        'gestion_fideles_reservee',
        "La gestion des fiches fidèles est réservée à un responsable (ou rôle supérieur).",
      );

  factory AppError.engagementsAccesReserve() => const AppError(
        'engagements_acces_reserve',
        "Les engagements d'un fidèle sont réservés à lui-même, à un pasteur ou au trésorier de son nœud.",
      );

  factory AppError.dossierDisciplinaireAccesRefuse() => const AppError(
        'dossier_disciplinaire_acces_refuse',
        "Vous n'êtes pas habilité à consulter ce dossier disciplinaire.",
      );

  factory AppError.documentArchiveAccesRefuse() => const AppError(
        'document_archive_acces_refuse',
        "Vous n'êtes pas habilité à consulter ce document archivé.",
      );

  factory AppError.noeudOrigineEtDestinationIdentiques() => const AppError(
        'noeud_origine_et_destination_identiques',
        "Le nœud d'origine et le nœud de destination d'une mutation doivent être différents.",
      );

  factory AppError.mutationNonEnAttente() => const AppError(
        'mutation_non_en_attente',
        "Cette mutation a déjà été traitée (validée ou refusée) : elle ne peut plus être modifiée.",
      );

  factory AppError.roleInsuffisantPourOuvertureDossier() => const AppError(
        'role_insuffisant_pour_ouverture_dossier',
        "Seul un pasteur référent ou un membre de commission désigné peut ouvrir un dossier disciplinaire.",
      );

  factory AppError.commissionRequisePourDecision() => const AppError(
        'commission_requise_pour_decision',
        "Une commission instructrice doit être assignée au dossier avant de prononcer une décision.",
      );

  factory AppError.dossierDisciplinaireNonEnInstruction() => const AppError(
        'dossier_disciplinaire_non_en_instruction',
        "Ce dossier disciplinaire n'est plus en instruction : une décision a déjà été prononcée ou il est clos.",
      );

  factory AppError.dossierDisciplinaireNonSanctionne() => const AppError(
        'dossier_disciplinaire_non_sanctionne',
        "Ce dossier disciplinaire ne peut être clôturé qu'après qu'une décision a été prononcée.",
      );

  factory AppError.roleInsuffisantPourValidationContribution() => const AppError(
        'role_insuffisant_pour_validation_contribution',
        "Seul un pasteur (ou rôle supérieur) ou un trésorier désigné du nœud peut valider ou rejeter une contribution.",
      );

  factory AppError.contributionNonEnAttente() => const AppError(
        'contribution_non_en_attente',
        "Cette contribution a déjà été traitée (validée ou rejetée) : elle ne peut plus être validée ou rejetée.",
      );

  factory AppError.contributionNonValideePourContrePassation() => const AppError(
        'contribution_non_validee_pour_contre_passation',
        "Seule une contribution validée peut faire l'objet d'une contre-passation.",
      );

  factory AppError.depenseDepasseSoldeSansDerogation() => const AppError(
        'depense_depasse_solde_sans_derogation',
        "Cette dépense dépasse le solde disponible du projet : une dérogation tracée est requise.",
      );

  factory AppError.roleInsuffisantPourSortieBien() => const AppError(
    'role_insuffisant_pour_sortie_bien',
    "Seul un pasteur (ou rôle supérieur) peut valider la sortie d'un bien du patrimoine.",
  );

  factory AppError.bienDejaSorti() => const AppError(
    'bien_deja_sorti',
    "Ce bien est déjà sorti du patrimoine (cédé, donné ou mis au rebut).",
  );

  factory AppError.reservationConflitDetecte() => const AppError(
    'reservation_conflit_detecte',
    "Ce bien est déjà réservé sur une plage qui chevauche celle demandée.",
  );

  factory AppError.campagneInventaireDejaCloturee() => const AppError(
    'campagne_inventaire_deja_cloturee',
    "Cette campagne d'inventaire est déjà clôturée : aucun nouveau pointage n'est possible.",
  );

  factory AppError.periodeComptableCloturee() => const AppError(
    'periode_comptable_cloturee',
    "Cette période comptable est clôturée et immuable : toute correction doit passer par une écriture de régularisation dans la période courante.",
  );

  factory AppError.roleInsuffisantPourClotureComptable() => const AppError(
    'role_insuffisant_pour_cloture_comptable',
    "Seul un pasteur (ou rôle supérieur) peut clôturer une période comptable.",
  );

  factory AppError.authentificationNonConfiguree() => const AppError(
    'authentification_non_configuree',
    "Le service de connexion n'est pas configuré sur cet appareil (fichier .env absent).",
  );

  factory AppError.authentificationIndisponible() => const AppError(
    'authentification_indisponible',
    "Le service de connexion est injoignable. Vérifiez votre connexion puis réessayez.",
  );

  factory AppError.codeOtpInvalide() => const AppError(
    'code_otp_invalide',
    "Ce code est invalide ou a expiré. Demandez un nouveau code.",
  );

  factory AppError.tropDeTentativesOtp() => const AppError(
    'trop_de_tentatives_otp',
    "Trop de tentatives. Patientez quelques instants avant de redemander un code.",
  );

  factory AppError.conflitLiaisonDejaResolu() => const AppError(
    'conflit_liaison_deja_resolu',
    "Ce conflit de liaison a déjà été résolu.",
  );

  factory AppError.compteDejaLieAUneFiche() => const AppError(
    'compte_deja_lie_a_une_fiche',
    "Votre compte est déjà lié à une fiche fidèle.",
  );

  factory AppError.ficheDejaLieeAUnCompte() => const AppError(
    'fiche_deja_liee_a_un_compte',
    "Cette fiche est, ou a déjà été, liée à un compte : passez par la résolution d'un conflit de liaison.",
  );

  factory AppError.ficheLieeRequise() => const AppError(
    'fiche_liee_requise',
    "Cette action trace une personne du registre : liez d'abord votre compte à votre fiche fidèle.",
  );

  factory AppError.decisionParLeSaisissant() => const AppError(
    'decision_par_le_saisissant',
    "Séparation des tâches : la personne qui a saisi cette contribution ne peut pas la valider ni la rejeter. Une autre personne habilitée doit décider.",
  );

  factory AppError.voteSurSaPropreProposition() => const AppError(
    'vote_sur_sa_propre_proposition',
    "Les autres fidèles votent sur une proposition : son auteur ne vote pas sur la sienne.",
  );

  factory AppError.actionReserveeAdministrateur() => const AppError(
    'action_reservee_administrateur',
    "Cette action est réservée à un administrateur.",
  );

  @override
  String toString() => 'AppError($code): $message';
}
