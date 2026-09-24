import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Depuis la liste des fidèles : l'administrateur d'amorçage (sans fiche)
/// lie son compte à la fiche [nomComplet] — prérequis de toute action qui
/// trace une personne du registre (validation, sortie d'un bien, favori,
/// commentaire…). Revient ensuite à la liste des fidèles.
Future<void> lierMonCompteALaFiche(WidgetTester tester, String nomComplet) async {
  await tester.tap(find.text(nomComplet));
  await tester.pumpAndSettle();
  await tester.tap(find.byTooltip('Lier mon compte à cette fiche'));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, 'Lier mon compte'));
  await tester.pumpAndSettle();
  expect(find.text('Compte lié à votre fiche.'), findsOneWidget);
  expect(find.byTooltip('Lier mon compte à cette fiche'), findsNothing);
  // Laisse la notification expirer : elle recouvrirait les boutons du bas.
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}
