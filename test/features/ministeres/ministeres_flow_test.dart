import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'accueil -> organisation -> créer siège -> ministères -> créer un ministère -> '
    'affecter un fidèle -> apparaît dans les membres',
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

      // Revient à l'accueil, puis au nœud pour créer un ministère.
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Organisation'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(OutlinedButton, 'Ministères'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun ministère créé pour ce nœud.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Nom du ministère'), 'Chorale principale');
      await tester.tap(find.byKey(const Key('ministere_type_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chorale').last);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Créer le ministère'));
      await tester.pumpAndSettle();

      expect(find.text('Chorale principale'), findsOneWidget);

      // Ouvre le ministère, affecte le fidèle comme responsable.
      await tester.tap(find.text('Chorale principale'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(OutlinedButton, 'Membres affectés'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun membre affecté.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('affectation_role_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('responsable').last);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Affecter'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Jean Doe'), findsOneWidget);
      expect(find.text('responsable'), findsOneWidget);

      await database.close();
    },
  );
}
