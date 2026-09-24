import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> évaluer un don -> apparaît dans la liste et l\'historique',
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

      await tester.pumpWidget(EcclesiasApp(capacites: capacitesDeTest, database: database, authGateway: AuthGatewayMemoire.connecte()));
      await tester.pumpAndSettle();

      // « Organisation » et « Fidèles » apparaissent à la fois comme tuile du
      // tableau de bord ; on cible spécifiquement la grille (`GridView`) pour
      // éviter toute ambiguïté avec le libellé identique de la barre de navigation.
      final navOrganisation =
          find.descendant(of: find.byType(GridView), matching: find.text('Organisation'));
      final navFideles = find.descendant(of: find.byType(GridView), matching: find.text('Fidèles'));

      // Crée le siège.
      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Global Service Groupe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Code interne'), 'GSG-SIEGE');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // La création du siège fait déjà un pop automatique vers l'arbre :
      // un seul retour suffit pour revenir à l'accueil.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Crée un fidèle.
      await tester.tap(navFideles);
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

      // Ouvre la fiche du fidèle -> dons spirituels.
      await tester.tap(find.textContaining('Jean Doe'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(OutlinedButton, 'Dons spirituels'));
      await tester.pumpAndSettle();

      expect(find.text('Non évalué'), findsWidgets);

      await tester.tap(find.text('Prophétie'));
      await tester.pumpAndSettle();

      expect(find.text('Aucune évaluation enregistrée.'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Nouvelle évaluation'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('niveau_maturite_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('confirme').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Observations'), 'Bon discernement en réunion.');

      await tester.tap(find.widgetWithText(FilledButton, "Enregistrer l'évaluation"));
      await tester.pumpAndSettle();

      // Revenu sur l'historique du don : l'évaluation apparaît.
      expect(find.text('confirme'), findsOneWidget);
      expect(find.textContaining('Bon discernement en réunion.'), findsOneWidget);

      // Revient à la liste des dons du fidèle : le niveau est maintenant affiché.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.text('confirme'), findsOneWidget);

      await database.close();
    },
  );
}
