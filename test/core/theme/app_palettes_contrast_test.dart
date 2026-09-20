import 'package:ecclesias_360/core/theme/app_palettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cahier §8.3 — « respect des contrastes pour une lisibilité en plein
/// soleil ». Contrôle chaque palette actuelle et future (`AppPalette.all`) :
/// - texte normal (`textPrimary`/`textSecondary`) sur fond/carte : WCAG AA
///   texte normal, 4.5:1 minimum ;
/// - texte sur une couleur de remplissage (`onPrimary`/`primary`,
///   `onSecondary`/`secondary`, `onDanger`/`danger`, typiquement un libellé
///   de bouton ou de badge, en gras) : WCAG AA texte large, 3:1 minimum.
double _contrast(Color a, Color b) {
  final l1 = a.computeLuminance();
  final l2 = b.computeLuminance();
  final lighter = l1 > l2 ? l1 : l2;
  final darker = l1 > l2 ? l2 : l1;
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  const normalTextMin = 4.5;
  const largeTextMin = 3.0;

  for (final palette in AppPalette.all) {
    group('Palette ${palette.nom}', () {
      test('texte principal lisible sur le fond et les cartes', () {
        expect(_contrast(palette.textPrimary, palette.background), greaterThanOrEqualTo(normalTextMin));
        expect(_contrast(palette.textPrimary, palette.cardBackground), greaterThanOrEqualTo(normalTextMin));
      });

      test('texte secondaire lisible sur le fond et les cartes', () {
        expect(_contrast(palette.textSecondary, palette.background), greaterThanOrEqualTo(normalTextMin));
        expect(_contrast(palette.textSecondary, palette.cardBackground), greaterThanOrEqualTo(normalTextMin));
      });

      test('libellés sur fond coloré (boutons/badges) lisibles', () {
        expect(_contrast(palette.onPrimary, palette.primary), greaterThanOrEqualTo(largeTextMin));
        expect(_contrast(palette.onSecondary, palette.secondary), greaterThanOrEqualTo(largeTextMin));
        expect(_contrast(palette.onDanger, palette.danger), greaterThanOrEqualTo(largeTextMin));
      });
    });
  }
}
