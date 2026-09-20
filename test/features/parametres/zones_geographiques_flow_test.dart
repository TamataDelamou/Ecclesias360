import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'accueil -> zones géographiques -> créer une zone -> apparaît dans la liste',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      // Les écrans utilisent l10n.* : fige la locale pour que les libellés
      // tapés dans ce test (français) correspondent, quelle que soit la
      // locale système de la machine qui exécute les tests.
      tester.platformDispatcher.localeTestValue = const Locale('fr');
      tester.platformDispatcher.localesTestValue = const [Locale('fr')];
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);

      await tester.pumpWidget(EcclesiasApp(database: database));
      await tester.pumpAndSettle();

      // Tuile plus bas dans la grille du tableau de bord : la faire défiler
      // dans le champ de vision avant de taper dessus.
      await tester.ensureVisible(find.text('Zones géographiques'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Zones géographiques'));
      await tester.pumpAndSettle();

      expect(find.text('Aucune zone géographique enregistrée.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Libellé'), 'Togo');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      expect(find.text('Togo'), findsOneWidget);

      await database.close();
    },
  );
}
