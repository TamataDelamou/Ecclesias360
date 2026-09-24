import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

void main() {
  testWidgets(
    'valider un PV archive automatiquement le document -> bibliothèque -> nouvelle version -> '
    'corbeille -> restauration (RG-VIII-01/02/04/05, RG-VII-03)',
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

      final navOrganisation =
          find.descendant(of: find.byType(GridView), matching: find.text('Organisation'));
      final navFideles = find.descendant(of: find.byType(GridView), matching: find.text('Fidèles'));

      // --- Reprend le scénario du Module VII pour produire un PV validé -----

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

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Va au nœud, nomme un membre du comité.
      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Membres du comité'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Membres du comité'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Fonction (ex. Pasteur, Diacre)'), 'Pasteur');
      await tester.tap(find.widgetWithText(FilledButton, 'Nommer'));
      await tester.pumpAndSettle();

      // Revient au nœud, crée une séance avec le fidèle présent.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Séances du comité'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Séances du comité'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Ordre du jour'), 'Budget annuel');
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Jean Doe'));
      await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer la séance'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Budget annuel'));
      await tester.pumpAndSettle();

      // Rédige et valide le procès-verbal : ceci déclenche l'archivage
      // automatique (RG-VII-03) via `ArchivageRepository.archiver`.
      await tester.enterText(
        find.widgetWithText(TextField, 'Brouillon du procès-verbal'),
        'Compte-rendu de la séance du comité.',
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Enregistrer le brouillon'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Valider (immuable)'));
      await tester.pumpAndSettle();

      expect(find.text('Ce procès-verbal est validé et immuable.'), findsOneWidget);

      // --- Module VIII : le PV validé apparaît dans la bibliothèque documentaire ---

      // Séance -> liste des séances -> fiche du nœud.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Documents archivés'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Documents archivés'));
      await tester.pumpAndSettle();

      expect(find.textContaining('PV-GSG-SIEGE-'), findsOneWidget);

      await tester.tap(find.textContaining('PV-GSG-SIEGE-'));
      await tester.pumpAndSettle();

      expect(find.textContaining('comite ·'), findsOneWidget);
      expect(find.textContaining('Version 1'), findsOneWidget);

      // Ajoute une nouvelle version (RG-VIII-02 : l'original reste consultable).
      await tester.tap(find.widgetWithText(TextButton, 'Nouvelle version'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, 'Référence du fichier (nom, lien...)'),
        'pv_budget_v2.pdf',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Version 1'), findsOneWidget);
      expect(find.textContaining('Version 2'), findsOneWidget);

      // Met le document en corbeille (RG-VIII-05) : retour automatique à la
      // bibliothèque, où il ne doit plus apparaître.
      await tester.tap(find.widgetWithText(OutlinedButton, 'Mettre en corbeille'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun document archivé.'), findsOneWidget);

      // Corbeille : le document y apparaît, pas encore purgeable (délai non écoulé).
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      expect(find.textContaining('PV-GSG-SIEGE-'), findsOneWidget);
      expect(find.textContaining('Mis en corbeille le'), findsOneWidget);
      expect(find.textContaining('Purgeable à partir du'), findsOneWidget);

      final purgerButton = tester.widget<OutlinedButton>(
        find.ancestor(of: find.text('Purger définitivement'), matching: find.byType(OutlinedButton)),
      );
      expect(purgerButton.onPressed, isNull, reason: 'Purge refusée avant le délai (RG-VIII-05).');

      // Restaure le document : il disparaît de la corbeille.
      await tester.tap(find.widgetWithText(OutlinedButton, 'Restaurer'));
      await tester.pumpAndSettle();

      expect(find.text('Corbeille vide.'), findsOneWidget);

      await database.close();
    },
  );
}
