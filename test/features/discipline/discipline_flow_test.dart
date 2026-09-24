import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> ouvrir un dossier -> assigner une commission -> '
    'ajouter une pièce -> prononcer une décision -> clôturer',
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
      // tableau de bord et comme libellé de la barre de navigation basse
      // (AppShell) : on cible spécifiquement la grille (`GridView`) pour
      // éviter toute ambiguïté.
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

      // Revient à l'accueil, va au nœud, ouvre l'écran Discipline.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      // Bouton loin dans la liste de la fiche de nœud (`ensureVisible` exige
      // que l'élément soit déjà construit ; `dragUntilVisible` le fait défiler
      // dans le champ de vision au préalable, même motif que
      // professions_flow_test.dart).
      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Dossiers disciplinaires'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Dossiers disciplinaires'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun dossier disciplinaire.'), findsOneWidget);

      // Ouvre un dossier (un seul fidèle et une seule nature de faute
      // disponibles : les sélecteurs sont déjà pré-remplis). L'acteur est la
      // session — ici l'administrateur d'amorçage, qui satisfait RG-X-01.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // Navigation automatique vers la fiche du dossier créé.
      expect(find.text('Jean Doe'), findsOneWidget);
      expect(find.text('En instruction'), findsOneWidget);
      expect(find.text('Aucune commission assignée.'), findsOneWidget);

      // Assigne une commission (aucune existante : passe par la création).
      await tester.tap(find.widgetWithText(OutlinedButton, 'Assigner une commission'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Créer une nouvelle commission'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Nom de la commission'), 'Commission ordinaire');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      expect(find.text('Commission ordinaire'), findsOneWidget);

      // Ajoute une pièce (témoignage écrit, texte).
      await tester.tap(find.widgetWithText(TextButton, 'Ajouter une pièce'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, 'Contenu (texte)'),
        'Témoignage écrit du responsable de nœud.',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Témoignage'), findsOneWidget);

      // Prononce la décision (durée indéterminée, sans suspension). La
      // section est désormais plus bas dans la fiche (une pièce vient de
      // s'ajouter) : la faire défiler dans le champ de vision au préalable.
      await tester.dragUntilVisible(
        find.widgetWithText(TextField, 'Décision motivée'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.enterText(find.widgetWithText(TextField, 'Décision motivée'), 'Avertissement écrit.');
      await tester.dragUntilVisible(
        find.widgetWithText(FilledButton, 'Prononcer la décision'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Prononcer la décision'));
      await tester.pumpAndSettle();

      // La position de défilement est conservée après le rafraîchissement :
      // fait défiler vers chaque élément avant de vérifier sa présence.
      await tester.dragUntilVisible(find.text('Sanctionné'), find.byType(ListView), const Offset(0, 200));
      expect(find.text('Sanctionné'), findsOneWidget);
      await tester.dragUntilVisible(
        find.text('Avertissement écrit.'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      expect(find.text('Avertissement écrit.'), findsOneWidget);
      expect(find.text('Durée indéterminée'), findsOneWidget);

      // Clôture / réintègre.
      await tester.dragUntilVisible(
        find.widgetWithText(FilledButton, 'Clôturer / Réintégrer'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Clôturer / Réintégrer'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(find.text('Clos'), find.byType(ListView), const Offset(0, 200));
      expect(find.text('Clos'), findsOneWidget);
      await tester.dragUntilVisible(
        find.text('Dossier clos — le fidèle a retrouvé son statut antérieur.'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      expect(find.text('Dossier clos — le fidèle a retrouvé son statut antérieur.'), findsOneWidget);

      await database.close();
    },
  );
}
