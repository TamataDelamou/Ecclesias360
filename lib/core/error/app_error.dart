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

  @override
  String toString() => 'AppError($code): $message';
}
