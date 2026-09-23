import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> saisir une offrande -> valider -> contre-passer -> '
    'créer un projet -> ajouter une dépense -> créer un engagement -> honorer une échéance',
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

      // Revient à l'accueil, va au nœud, ouvre l'écran Contributions.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Contributions'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Contributions'));
      await tester.pumpAndSettle();

      expect(find.text('Aucune contribution saisie.'), findsOneWidget);

      // Saisit une offrande (un seul fidèle disponible : le sélecteur de
      // donateur est déjà pré-rempli).
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Montant'), '5000');
      await tester.tap(find.widgetWithText(FilledButton, 'Saisir'));
      await tester.pumpAndSettle();

      // Navigation automatique vers le reçu.
      expect(find.text('5000 GNF'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Valider'), findsOneWidget);

      // Valide la contribution (rôle « pasteur » par défaut suffit, RG-XI-02).
      // Le bouton de la fiche et celui du dialogue partagent le même
      // libellé « Valider » ; `.last` cible celui du dialogue une fois
      // ouvert (le premier tap n'a, lui, qu'une seule correspondance).
      await tester.tap(find.widgetWithText(FilledButton, 'Valider').last);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Valider').last);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(OutlinedButton, 'Contre-passer'), findsOneWidget);

      // Contre-passe la contribution (RG-XI-05).
      await tester.tap(find.widgetWithText(OutlinedButton, 'Contre-passer'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Contre-passer'));
      await tester.pumpAndSettle();

      // La contribution originale reste validée (RG-XI-05 ne modifie jamais
      // l'originale) : le reçu affiche toujours son montant et son statut
      // inchangés — rien n'interdit techniquement de la contre-passer à
      // nouveau, seule la lecture humaine du reçu prévient une double
      // correction.
      expect(find.text('5000 GNF'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Contre-passer'), findsOneWidget);

      // Retourne au nœud (2 niveaux : fiche de contribution -> liste des
      // contributions -> fiche de nœud), ouvre l'écran Projets, crée un projet.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Projets'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Projets'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun projet.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Nom du projet'), 'Rénovation toiture');
      await tester.enterText(find.widgetWithText(TextField, 'Budget prévisionnel'), '100000');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // Navigation automatique vers la fiche projet.
      expect(find.text('Rénovation toiture'), findsOneWidget);
      expect(find.textContaining('Solde : 0 GNF'), findsOneWidget);

      // Ajoute une dépense au-delà du solde disponible (0), avec dérogation
      // tracée (RG-XI-03).
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter une dépense'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Libellé de la dépense'), 'Avance fournisseur');
      await tester.enterText(find.widgetWithText(TextField, 'Montant'), '2000');
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Solde : -2000 GNF'), findsOneWidget);
      expect(find.text('Avance fournisseur'), findsOneWidget);

      // Retourne à l'accueil (4 niveaux : fiche projet -> liste des
      // projets -> fiche de nœud -> arbre d'organisation), ouvre la fiche du
      // fidèle, l'écran Engagements, crée un engagement et honore sa
      // première échéance.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(navFideles);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jean Doe'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Engagements et échéances'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Engagements et échéances'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun engagement.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Montant prévu'), '10000');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      expect(find.textContaining('10000 GNF'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Honorer'), findsWidgets);

      await tester.tap(find.widgetWithText(TextButton, 'Honorer').first);
      await tester.pumpAndSettle();

      expect(find.text('Honorée'), findsOneWidget);

      await database.close();
    },
  );
}
