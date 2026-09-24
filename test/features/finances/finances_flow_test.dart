import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/constants/app_routes.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/parcours.dart';
import '../../helpers/capacites_pour_tests.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> saisir une offrande -> le saisissant ne valide pas -> '
    'une trésorière se connecte et valide -> contre-passer -> '
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

      await tester.pumpWidget(EcclesiasApp(capacites: capacitesDeTest, database: database, authGateway: AuthGatewayMemoire.connecte()));
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

      // L'administrateur d'amorçage, sans fiche, n'est pas encore un valideur
      // traçable : il lie son compte à cette fiche (RG-XI-02 — le valideur
      // tracé est toujours une personne du registre).
      await lierMonCompteALaFiche(tester, 'Jean Doe');

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

      // Navigation automatique vers le reçu. L'administrateur a saisi cette
      // contribution : il ne peut ni la valider ni la rejeter (RG-XI-02,
      // séparation stricte des tâches — l'administrateur n'y fait pas
      // exception). Elle attend une autre personne habilitée : comportement
      // voulu, pas un défaut.
      expect(find.text('5000 GNF'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Valider'), findsNothing);
      expect(find.widgetWithText(OutlinedButton, 'Rejeter'), findsNothing);
      expect(find.textContaining('Vous avez saisi cette contribution'), findsOneWidget);

      // Une seconde personne habilitée est nécessaire. Par les écrans réels :
      // l'administrateur crée la fiche de Marie (avec son téléphone), la
      // désigne trésorière du nœud (rang membre), puis se déconnecte ; Marie
      // se connecte (liaison automatique à sa fiche) et valide.
      for (var i = 0; i < 4; i++) {
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
      await tester.tap(navFideles);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('champ_noeud')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe').last);
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Sow');
      await tester.enterText(find.widgetWithText(TextFormField, 'Prénoms'), 'Marie');
      await tester.tap(find.text('Date de naissance'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('champ_sexe')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('feminin').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('champ_statut_civil')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('marie').last);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Marie Sow'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Modifier les coordonnées'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Téléphone'), '+224620000077');
      await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
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
      await tester.tap(find.byIcon(Icons.badge_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Désigner un trésorier'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Marie Sow').last);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Désigner'));
      await tester.pumpAndSettle();
      expect(find.text('Marie Sow'), findsOneWidget);

      // Trésoriers -> contributions -> nœud -> arbre, puis déconnexion.
      for (var i = 0; i < 3; i++) {
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
      await tester.tap(find.text('Paramètres').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Se déconnecter'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey('champIdentifiant')), '+224620000077');
      await tester.tap(find.text('Recevoir le code'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('champCode')), '123456');
      await tester.tap(find.text('Se connecter'));
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
      await tester.tap(find.textContaining('5000').first);
      await tester.pumpAndSettle();

      // Valide la contribution : l'acteur est la session (Marie, trésorière,
      // tracée par sa fiche liée), RG-XI-02.
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

      // Marie (membre, trésorière) ne lit pas la fiche de Jean (policy
      // `fideles` de 0019 : soi-même ou le périmètre) — la liste des fidèles
      // ne lui montre que sa fiche. Les engagements de Jean lui restent
      // ouverts (trésorière de son nœud, AccesFinances) : ouverts par leur route.
      await tester.tap(navFideles);
      await tester.pumpAndSettle();
      expect(find.text('Jean Doe'), findsNothing);
      final jeanId = (await tester.runAsync(
        () => (database.select(database.fideles)..where((t) => t.prenoms.equals('Jean'))).getSingle(),
      ))!
          .id;
      GoRouter.of(tester.element(find.byType(Scaffold).first)).push(AppRoutes.engagementsDuFidele(jeanId));
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
