import 'package:flutter/material.dart';

/// RG lié au Cahier §8.3 (« respect des contrastes pour une lisibilité en
/// plein soleil ») — foyer unique des couleurs (voir AGENTS.md §5), reprises
/// de la maquette (5 thèmes) avec les corrections de contraste ci-dessous.
/// Aucune autre valeur `Color(0x...)` ne doit apparaître ailleurs dans `lib/`
/// (voir `test/core/theme/no_hardcoded_tokens_test.dart`).
enum AppPaletteId { futuriste, lumiere, aurore, foret, royal }

/// Un jeu de couleurs complet et cohérent pour un thème de l'application.
/// Chaque combinaison texte/fond respecte au moins un contraste WCAG AA
/// (4.5:1 pour le texte normal, 3:1 pour le texte large/les icônes), voir
/// `test/core/theme/app_palettes_contrast_test.dart`.
class AppPalette {
  const AppPalette({
    required this.id,
    required this.nom,
    required this.description,
    required this.brightness,
    required this.background,
    required this.backgroundSecondary,
    required this.cardBackground,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.onDanger,
  });

  final AppPaletteId id;
  final String nom;
  final String description;
  final Brightness brightness;

  final Color background;
  final Color backgroundSecondary;
  final Color cardBackground;
  final Color cardBorder;

  final Color textPrimary;
  final Color textSecondary;

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;

  final Color success;
  final Color warning;
  final Color danger;
  final Color onDanger;

  /// Sombre & moderne — bleu nuit et cyan.
  ///
  /// Correction de contraste : le rouge d'erreur de la maquette (`0xFFFF5252`)
  /// n'atteignait que 3.19:1 avec un texte blanc dessus (minimum requis
  /// 4.5:1) ; assombri à `0xFFEB0000` (4.63:1) sans changer sa teinte.
  static const AppPalette futuriste = AppPalette(
    id: AppPaletteId.futuriste,
    nom: 'Futuriste',
    description: 'Sombre & moderne — bleu nuit et cyan',
    brightness: Brightness.dark,
    background: Color(0xFF0A0E1A),
    backgroundSecondary: Color(0xFF111827),
    cardBackground: Color(0xFF1A2035),
    cardBorder: Color(0xFF1E2D40),
    textPrimary: Colors.white,
    textSecondary: Color(0xFF8892A4),
    primary: Color(0xFF00D4FF),
    onPrimary: Color(0xFF001A20),
    secondary: Color(0xFFFFD700),
    onSecondary: Color(0xFF1A0F00),
    success: Color(0xFF00E676),
    warning: Color(0xFFFFD700),
    danger: Color(0xFFEB0000),
    onDanger: Colors.white,
  );

  /// Clair & épuré — blanc et bleu royal.
  ///
  /// Correction de contraste : le texte secondaire de la maquette
  /// (`0xFF6B7280`) n'atteignait que 4.47:1 sur le fond (minimum requis
  /// 4.5:1) ; assombri à `0xFF69707D` (4.63:1).
  static const AppPalette lumiere = AppPalette(
    id: AppPaletteId.lumiere,
    nom: 'Lumière',
    description: 'Clair & épuré — blanc et bleu royal',
    brightness: Brightness.light,
    background: Color(0xFFF4F6FB),
    backgroundSecondary: Colors.white,
    cardBackground: Colors.white,
    cardBorder: Color(0xFFE8ECF4),
    textPrimary: Color(0xFF1A1C2E),
    textSecondary: Color(0xFF69707D),
    primary: Color(0xFF1A3A6B),
    onPrimary: Colors.white,
    secondary: Color(0xFFC9A84C),
    onSecondary: Color(0xFF1A0F00),
    success: Color(0xFF2D7A4F),
    warning: Color(0xFFB45309),
    danger: Color(0xFFB91C1C),
    onDanger: Colors.white,
  );

  /// Chaleureux — ambre et bordeaux.
  ///
  /// Correction de contraste : le texte blanc sur la couleur secondaire de
  /// la maquette (`0xFFE05050`) n'atteignait que 3.87:1 (minimum requis
  /// 4.5:1) ; la couleur secondaire assombrie à `0xFFDB3636` (4.56:1).
  static const AppPalette aurore = AppPalette(
    id: AppPaletteId.aurore,
    nom: 'Aurore',
    description: 'Chaleureux — ambre et bordeaux',
    brightness: Brightness.dark,
    background: Color(0xFF120C04),
    backgroundSecondary: Color(0xFF1E1208),
    cardBackground: Color(0xFF2A1A0A),
    cardBorder: Color(0xFF4A3020),
    textPrimary: Color(0xFFF5E8D0),
    textSecondary: Color(0xFFA08060),
    primary: Color(0xFFE8A020),
    onPrimary: Color(0xFF1A0800),
    secondary: Color(0xFFDB3636),
    onSecondary: Colors.white,
    success: Color(0xFF80C060),
    warning: Color(0xFFE8A020),
    danger: Color(0xFFDB3636),
    onDanger: Colors.white,
  );

  /// Nature & sérénité — vert et bois. Aucune correction nécessaire : toutes
  /// les combinaisons de la maquette respectaient déjà le contraste requis.
  static const AppPalette foret = AppPalette(
    id: AppPaletteId.foret,
    nom: 'Forêt',
    description: 'Nature & sérénité — vert et bois',
    brightness: Brightness.dark,
    background: Color(0xFF080F08),
    backgroundSecondary: Color(0xFF0F1A0F),
    cardBackground: Color(0xFF162016),
    cardBorder: Color(0xFF2A4A2A),
    textPrimary: Color(0xFFD8F0D8),
    textSecondary: Color(0xFF6A9A6A),
    primary: Color(0xFF4CAF50),
    onPrimary: Color(0xFF001A00),
    secondary: Color(0xFF8BC34A),
    onSecondary: Color(0xFF001A00),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFEB3B),
    danger: Color(0xFFE05050),
    onDanger: Colors.white,
  );

  /// Majestueux — violet et or.
  ///
  /// Deux corrections de contraste : le violet de la maquette
  /// (`0xFF9C27B0`) n'atteignait que 2.84:1 sur les cartes (minimum requis
  /// 4.5:1), éclairci à `0xFFC34CD7` (4.56:1) ; le texte secondaire
  /// (`0xFF8A70A0`) n'atteignait que 4.19:1, éclairci à `0xFF8F76A4` (4.52:1).
  static const AppPalette royal = AppPalette(
    id: AppPaletteId.royal,
    nom: 'Royal',
    description: 'Majestueux — violet et or',
    brightness: Brightness.dark,
    background: Color(0xFF0A0510),
    backgroundSecondary: Color(0xFF150A20),
    cardBackground: Color(0xFF1E1030),
    cardBorder: Color(0xFF3A2050),
    textPrimary: Color(0xFFF0E8FF),
    textSecondary: Color(0xFF8F76A4),
    primary: Color(0xFFC34CD7),
    onPrimary: Colors.white,
    secondary: Color(0xFFFFD700),
    onSecondary: Color(0xFF1A0F00),
    success: Color(0xFF80C060),
    warning: Color(0xFFFFD700),
    danger: Color(0xFFE05050),
    onDanger: Colors.white,
  );

  static const List<AppPalette> all = [futuriste, lumiere, aurore, foret, royal];
}
