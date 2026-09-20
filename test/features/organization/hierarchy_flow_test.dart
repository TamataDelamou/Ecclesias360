import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'accueil -> organisation -> créer la racine -> apparaît dans l\'arbre',
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

      // « Organisation » apparaît à la fois comme tuile du tableau de bord et
      // comme libellé de la barre de navigation basse (AppShell) : on cible
      // spécifiquement la grille (`GridView`) pour éviter toute ambiguïté.
      await tester.tap(find.descendant(of: find.byType(GridView), matching: find.text('Organisation')));
      await tester.pumpAndSettle();

      expect(find.text('Aucun nœud — créez la racine (siège).'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Global Service Groupe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Code interne'), 'GSG-SIEGE');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      expect(find.text('Global Service Groupe'), findsOneWidget);
      expect(find.text('Aucun nœud — créez la racine (siège).'), findsNothing);

      await database.close();
    },
  );
}
