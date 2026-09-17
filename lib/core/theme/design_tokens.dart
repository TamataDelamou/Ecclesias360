import 'package:flutter/material.dart';

/// Jetons de thème centralisés — aucune valeur hexadécimale en dur ailleurs.
abstract final class DesignTokens {
  static const Color seed = Color(0xFF1B5E20);

  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      );

  static ThemeData dark() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );
}
