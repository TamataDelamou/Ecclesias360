import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> déclarer une profession -> vérifier -> solliciter le groupe',
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

      await tester.pumpWidget(EcclesiasApp(database: database, authGateway: AuthGatewayMemoire.connecte()));
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

      // Ouvre la fiche du fidèle -> compétences professionnelles.
      await tester.tap(find.textContaining('Jean Doe'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Compétences professionnelles'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Compétences professionnelles'));
      await tester.pumpAndSettle();

      expect(find.text('Aucune profession déclarée.'), findsOneWidget);

      await tester.tap(find.widgetWithText(TextButton, 'Déclarer une profession'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, "Années d'expérience"), '5');
      await tester.tap(find.widgetWithText(FilledButton, 'Déclarer'));
      await tester.pumpAndSettle();

      expect(find.text('Déclaré (non vérifié)'), findsOneWidget);

      // Vérifie la déclaration.
      await tester.tap(find.widgetWithText(TextButton, 'Vérifier'));
      await tester.pumpAndSettle();

      expect(find.text('Vérifié'), findsOneWidget);

      // Depuis l'accueil, ouvre le groupe professionnel correspondant.
      // Pile de navigation : accueil -> liste fidèles -> fiche fidèle ->
      // compétences, donc trois retours pour revenir à l'accueil.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Tuile plus bas dans la grille du tableau de bord : la faire défiler
      // dans le champ de vision avant de taper dessus.
      await tester.ensureVisible(find.text('Groupes professionnels'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Groupes professionnels'));
      await tester.pumpAndSettle();

      // Filtre pour éviter toute dépendance à l'ordre/défilement de la
      // liste complète des métiers.
      await tester.enterText(
        find.widgetWithText(TextField, 'Rechercher par métier ou catégorie'),
        'Médecin',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Médecin').last);
      await tester.pumpAndSettle();

      expect(find.textContaining('Jean Doe'), findsOneWidget);
      expect(find.text('Vérifié'), findsOneWidget);

      await tester.tap(find.widgetWithText(FloatingActionButton, 'Solliciter ce groupe'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Objet de la sollicitation'),
        'Campagne de sensibilisation santé',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Solliciter'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Sollicitation envoyée'), findsOneWidget);

      await database.close();
    },
  );
}
