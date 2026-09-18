import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle célibataire -> recalculer le groupe -> apparaît dans les membres',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      await tester.pumpWidget(EcclesiasApp(database: database));
      await tester.pumpAndSettle();

      // Crée le siège.
      await tester.tap(find.text('Organisation'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Global Service Groupe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Code interne'), 'GSG-SIEGE');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // La création du siège fait déjà un pop automatique vers l'arbre :
      // un seul retour suffit pour revenir à l'accueil.
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Crée un fidèle célibataire (statut civil par défaut du formulaire).
      await tester.tap(find.text('Fidèles'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('champ_noeud')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Doe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Prénoms'), 'Jean');

      await tester.tap(find.text('Date de naissance'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('champ_sexe')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('masculin').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('champ_statut_civil')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('celibataire').last);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // La création du fidèle fait déjà un pop automatique vers la liste :
      // un seul retour suffit pour revenir à l'accueil.
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Groupes de l\'Église'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Célibataires'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun membre dans ce groupe.'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Recalculer'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Jean Doe'), findsOneWidget);
      expect(find.text('Automatique'), findsOneWidget);
      expect(find.text('1 membre(s)'), findsOneWidget);

      await database.close();
    },
  );
}
