import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/finances/data/finances_repository.dart';
import 'package:ecclesias_360/features/finances/domain/models/origine_contribution.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';

void main() {
  testWidgets(
    'offrande saisie par un fidèle -> validée par l\'administrateur (autre personne, RG-XI-02) -> '
    'consulter la caisse, le journal des écritures et le rapport financier rapide (RG-XXI-01/02/06)',
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

      // Données préalables (hors du faux temps du harnais) : l'offrande est
      // saisie par Paul ; l'administrateur (fiche de Jean, liée
      // automatiquement à son compte par son e-mail) la validera — jamais la
      // personne qui a saisi (RG-XI-02, séparation stricte des tâches).
      await tester.runAsync(() async {
        final siege = await OrganisationNodeRepository(database, SyncCoordinator(database)).creerNoeud(
          typeNoeud: TypeNoeud.siege,
          noeudParentId: null,
          nom: 'Global Service Groupe',
          codeInterne: 'GSG-SIEGE',
        );
        final fideles = FideleRepository(database, SyncCoordinator(database));
        Future<String> fiche(String prenoms, {String? email}) async => (await fideles.creerFidele(
              noeudId: siege.id,
              nom: 'Doe',
              prenoms: prenoms,
              dateNaissance: DateTime(1980, 1, 1),
              sexe: Sexe.masculin,
              statutCivil: StatutCivil.celibataire,
              email: email,
            ))
                .id;
        final jeanId = await fiche('Jean', email: 'admin@ecclesias.test');
        await (database.update(database.fideles)..where((t) => t.id.equals(jeanId)))
            .write(const FidelesCompanion(role: Value('administrateur')));
        final paulId = await fiche('Paul');
        await FinancesRepository(database, fideles).saisirContribution(
          fideleId: paulId,
          typeOffrandeId: (await database.select(database.typesOffrande).get()).first.id,
          montant: 5000,
          devise: 'GNF',
          noeudId: siege.id,
          modePaiement: 'especes',
          origine: OrigineContribution.mobile,
          saisieParFideleId: paulId,
        );
      });

      await tester.pumpWidget(EcclesiasApp(database: database, authGateway: AuthGatewayMemoire.connecte()));
      await tester.pumpAndSettle();

      final navOrganisation =
          find.descendant(of: find.byType(GridView), matching: find.text('Organisation'));

      // Va au nœud, ouvre Contributions et valide l'offrande — génère
      // automatiquement l'écriture miroir (RG-XXI-02).
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

      // Le bouton de la fiche et celui du dialogue partagent le libellé
      // « Valider » ; `.last` cible celui du dialogue une fois ouvert.
      await tester.tap(find.widgetWithText(FilledButton, 'Valider').last);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Valider').last);
      await tester.pumpAndSettle();
      expect(find.widgetWithText(OutlinedButton, 'Contre-passer'), findsOneWidget);

      // Retourne au nœud (fiche de contribution -> liste -> fiche de nœud),
      // ouvre l'écran Comptabilité.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Comptabilité'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Comptabilité'));
      await tester.pumpAndSettle();

      // Onglet Caisse (par défaut) : la validation a débité le compte
      // caisse (530000) de 5000.
      expect(find.text('5000 GNF'), findsOneWidget);

      // Onglet Écritures : les deux lignes équilibrées de la validation
      // (débit caisse / crédit produits des contributions, RG-XXI-01/02).
      await tester.tap(find.text('Écritures'));
      await tester.pumpAndSettle();
      expect(find.text('Aucune écriture enregistrée.'), findsNothing);
      expect(find.textContaining('Débit'), findsOneWidget);
      expect(find.textContaining('Crédit'), findsOneWidget);

      // Onglet Rapport : recettes de 5000, aucune dépense, solde net 5000
      // (RG-XXI-06, aucun sous-nœud ici donc pas de consolidation à vérifier).
      await tester.tap(find.text('Rapport'));
      await tester.pumpAndSettle();
      expect(find.text('5000 GNF'), findsWidgets);
      expect(find.text('0 GNF'), findsOneWidget);

      await database.close();
    },
  );
}
