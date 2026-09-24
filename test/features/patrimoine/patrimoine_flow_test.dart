import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/etat_bien.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/objet_reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> Biens -> ajouter un bien -> signaler état -> '
    'réserver -> sortir -> ajouter un bien à gestion de stock -> mouvement de stock -> alerte de seuil -> '
    'démarrer une campagne -> pointage avec écart -> clôturer',
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
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Crée un fidèle (nécessaire à la validation d'une sortie de bien,
      // RG-XX-02).
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

      // L'administrateur d'amorçage lie son compte à cette fiche : la sortie
      // d'un bien trace une personne du registre (RG-XX-02).
      await tester.tap(find.text('Jean Doe'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Lier mon compte à cette fiche'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Lier mon compte'));
      await tester.pumpAndSettle();
      // Laisse la notification expirer : elle recouvrirait les boutons du bas.
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Va au nœud, ouvre l'écran Biens (Module XX).
      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Biens'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Biens'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun bien enregistré.'), findsOneWidget);

      // --- RG-XX-01 : ajoute un bien (catégorie Mobilier) ---

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mobilier').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, "Identifiant d'inventaire"), 'INV-0001');
      await tester.enterText(find.widgetWithText(TextField, 'Désignation'), 'Chaises de la salle');
      await tester.enterText(find.widgetWithText(TextField, "Valeur d'acquisition"), '500000');
      await tester.enterText(find.widgetWithText(TextField, 'Valeur vénale'), '300000');
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      // Navigation automatique vers la fiche du bien créé.
      expect(find.text('Chaises de la salle'), findsOneWidget);
      expect(find.text('État : Neuf'), findsOneWidget);

      // --- RG-XX-01 : signale un changement d'état ---

      await tester.tap(find.widgetWithText(OutlinedButton, "Signaler l'état"));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<EtatBien>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bon').last);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, "Signaler l'état"));
      await tester.pumpAndSettle();

      expect(find.text('État : Bon'), findsOneWidget);

      // --- RG-XX-03 : réserve le bien (aucun culte disponible : objet libre) ---

      await tester.tap(find.widgetWithText(OutlinedButton, 'Réserver'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun culte disponible pour ce nœud.'), findsOneWidget);

      await tester.tap(find.byType(DropdownButtonFormField<ObjetReservation>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Autre').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, "Description de l'objet"), 'Réunion des jeunes');
      await tester.tap(find.widgetWithText(FilledButton, 'Réserver'));
      await tester.pumpAndSettle();

      expect(find.text('Réunion des jeunes'), findsOneWidget);

      // --- RG-XX-02 : sortie définitive du bien du patrimoine ---

      await tester.tap(find.widgetWithText(OutlinedButton, 'Sortir le bien'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Motif'), 'Bien obsolète');
      await tester.tap(find.widgetWithText(FilledButton, 'Sortir le bien'));
      await tester.pumpAndSettle();

      expect(find.text('État : Cédé'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, "Signaler l'état"), findsNothing);

      // --- RG-XX-05 : ajoute un bien à gestion de stock ---

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Stocks (fournitures)').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, "Identifiant d'inventaire"), 'INV-0002');
      await tester.enterText(find.widgetWithText(TextField, 'Désignation'), 'Craie blanche');
      await tester.enterText(find.widgetWithText(TextField, "Valeur d'acquisition"), '10000');
      await tester.enterText(find.widgetWithText(TextField, 'Valeur vénale'), '5000');
      await tester.enterText(find.widgetWithText(TextField, "Seuil d'alerte de stock"), '5');
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Craie blanche'), findsOneWidget);
      expect(find.text('Gestion de stock'), findsOneWidget);
      expect(find.text('Quantité actuelle : 0'), findsOneWidget);
      expect(find.text("Seuil d'alerte : 5"), findsOneWidget);

      // --- RG-XX-05 : enregistre un mouvement de stock (entrée) ---

      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter un mouvement'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Quantité'), '3');
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Quantité actuelle : 3'), findsOneWidget);

      // Retourne à la liste : la craie (3 < seuil 5) apparaît dans l'alerte
      // de seuil (RG-XX-05).
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.text('Biens sous le seuil d\'alerte de stock'), findsOneWidget);
      expect(find.textContaining('Craie blanche'), findsWidgets);

      // --- RG-XX-04 : démarre une campagne d'inventaire ---

      await tester.tap(find.byIcon(Icons.fact_check_outlined));
      await tester.pumpAndSettle();

      expect(find.text("Aucune campagne d'inventaire enregistrée."), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Libellé de la campagne'), 'Inventaire annuel 2026');
      await tester.tap(find.widgetWithText(FilledButton, 'Démarrer'));
      await tester.pumpAndSettle();

      // Navigation automatique vers la fiche de la campagne créée.
      expect(find.text('Inventaire annuel 2026'), findsOneWidget);
      expect(find.text('En cours'), findsOneWidget);
      expect(find.text('Aucun pointage enregistré.'), findsOneWidget);

      // --- RG-XX-04 : pointage terrain avec écart détecté ---

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Craie blanche').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<EtatBien>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bon').last);
      await tester.pumpAndSettle();

      // Quantité déclarée (3) différente de la quantité constatée (2) :
      // écart détecté (`PatrimoineRules.detecterEcart`).
      await tester.enterText(find.widgetWithText(TextField, 'Quantité constatée'), '2');
      await tester.enterText(find.widgetWithText(TextField, 'Commentaire'), 'Il manque une craie.');
      await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer le pointage'));
      await tester.pumpAndSettle();

      expect(find.text('Craie blanche'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);

      // --- RG-XX-04 : clôture la campagne ---

      await tester.tap(find.widgetWithText(OutlinedButton, 'Clôturer la campagne'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Clôturer la campagne'));
      await tester.pumpAndSettle();

      expect(find.text('Clôturée'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Clôturer la campagne'), findsNothing);
      expect(find.byIcon(Icons.add), findsNothing);

      await database.close();
    },
  );
}
