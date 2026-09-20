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

  @override
  String toString() => 'AppError($code): $message';
}
