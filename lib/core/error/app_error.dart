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

  @override
  String toString() => 'AppError($code): $message';
}
