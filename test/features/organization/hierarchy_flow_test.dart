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

      await tester.pumpWidget(EcclesiasApp(database: database));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Organisation'));
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
