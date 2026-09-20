import 'package:flutter/material.dart';

import 'app_dimensions.dart';
import 'app_palettes.dart';

/// Construit les `ThemeData` Flutter à partir des jetons de `app_palettes.dart`
/// et `app_dimensions.dart` (voir AGENTS.md §5) — seul endroit qui assemble un
/// `ThemeData` complet. Pas de sélecteur de thème ici : lequel des 5 thèmes
/// sert de thème clair/sombre par défaut n'est pas tranché par le Cahier
/// (décision produit en attente, voir AGENTS.md) — `light()`/`dark()`
/// utilisent pour l'instant Lumière et Futuriste, les deux thèmes déjà les
/// plus proches d'un clair/sombre Material standard.
abstract final class DesignTokens {
  static ThemeData light() => themeFor(AppPalette.lumiere);

  static ThemeData dark() => themeFor(AppPalette.futuriste);

  static ThemeData themeFor(AppPalette palette) {
    final colorScheme = ColorScheme(
      brightness: palette.brightness,
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      onSecondary: palette.onSecondary,
      error: palette.danger,
      onError: palette.onDanger,
      surface: palette.cardBackground,
      onSurface: palette.textPrimary,
      outline: palette.cardBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: palette.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.background,
      appBarTheme: AppBarTheme(
        backgroundColor: palette.backgroundSecondary,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: palette.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          side: BorderSide(color: palette.cardBorder),
        ),
      ),
      extensions: [EcclesiasPaletteColors.fromPalette(palette)],
    );
  }
}

/// Accès à la palette complète (au-delà des rôles standards de
/// [ColorScheme]) depuis un `BuildContext` : `Theme.of(context).extension()`.
class EcclesiasPaletteColors extends ThemeExtension<EcclesiasPaletteColors> {
  const EcclesiasPaletteColors({
    required this.textSecondary,
    required this.success,
    required this.warning,
    required this.cardBorder,
  });

  factory EcclesiasPaletteColors.fromPalette(AppPalette palette) => EcclesiasPaletteColors(
        textSecondary: palette.textSecondary,
        success: palette.success,
        warning: palette.warning,
        cardBorder: palette.cardBorder,
      );

  final Color textSecondary;
  final Color success;
  final Color warning;
  final Color cardBorder;

  @override
  EcclesiasPaletteColors copyWith({Color? textSecondary, Color? success, Color? warning, Color? cardBorder}) {
    return EcclesiasPaletteColors(
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  EcclesiasPaletteColors lerp(EcclesiasPaletteColors? other, double t) {
    if (other == null) return this;
    return EcclesiasPaletteColors(
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
    );
  }
}
