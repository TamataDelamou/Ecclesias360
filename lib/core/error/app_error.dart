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

  @override
  String toString() => 'AppError($code): $message';
}
