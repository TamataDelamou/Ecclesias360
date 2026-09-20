/// Foyer unique des espacements, rayons et durées (voir AGENTS.md §5).
/// Aucun nombre de mise en page en dur ne doit apparaître dans les écrans
/// migrés (voir `test/core/theme/no_hardcoded_tokens_test.dart`) : utiliser
/// ces constantes plutôt que des `EdgeInsets`/`SizedBox` littéraux.
abstract final class AppDimensions {
  // --- Espacements (padding, gaps) -----------------------------------------
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 24;
  static const double spacingXxl = 32;

  // --- Rayons de bordure -----------------------------------------------------
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;

  // --- Durées d'animation ------------------------------------------------
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);

  // --- Mises en page spécifiques ---------------------------------------------
  /// Largeur de la colonne de libellé dans les fiches en paires libellé/valeur
  /// (voir `_LigneInfo` de `node_detail_screen.dart`).
  static const double labelColumnWidth = 200;

  /// Décalage horizontal par niveau de profondeur dans un arbre navigable
  /// (voir `HierarchyScreen`).
  static const double treeIndentPerDepth = 16;
}
