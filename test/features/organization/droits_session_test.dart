import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/constants/app_routes.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// Modules I, II et XXIII — les droits suivent la session réelle (miroir des
/// policies de 0019, RG-XXIII-06 et RG-II-05). Marie se connecte par son
/// e-mail ; sans fiche correspondante sur une base non vide, elle est
/// utilisateur simple (RG-SEC-06bis).
void main() {
  const emailMarie = 'marie@ecclesias.test';
  const siegeId = 'noeud-siege';
  const egliseId = 'noeud-eglise';

  Future<({AppDatabase db, String paulId})> preparer({String? roleMarie}) async {
    final db = AppDatabase(NativeDatabase.memory());
    for (final (id, type, nom, parent, path) in [
      (siegeId, 'siege', 'GSG', null, '/$siegeId/'),
      (egliseId, 'eglise_locale', 'Église A', siegeId, '/$siegeId/$egliseId/'),
    ]) {
      await db
          .into(db.organisationNodes)
          .insert(
            OrganisationNodesCompanion.insert(
              id: id,
              typeNoeud: type,
              nom: nom,
              codeInterne: 'CODE-$id',
              noeudParentId: Value(parent),
              path: path,
              depth: parent == null ? 0 : 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
    }
    final fideles = FideleRepository(db, SyncCoordinator(db));
    Future<String> fiche(String prenoms, {String? email}) async => (await fideles.creerFidele(
      noeudId: siegeId,
      nom: 'Doe',
      prenoms: prenoms,
      dateNaissance: DateTime(1980, 1, 1),
      sexe: Sexe.feminin,
      statutCivil: StatutCivil.celibataire,
      email: email,
    )).id;
    if (roleMarie != null) {
      final marieId = await fiche('Marie', email: emailMarie);
      await (db.update(db.fideles)..where((t) => t.id.equals(marieId))).write(FidelesCompanion(role: Value(roleMarie)));
    }
    final paulId = await fiche('Paul');
    return (db: db, paulId: paulId);
  }

  Future<void> demarrer(WidgetTester tester, AppDatabase db) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(
      EcclesiasApp(
        capacites: capacitesDeTest,
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: const UtilisateurAuthentifie(id: 'compte-marie', identifiant: IdentifiantEmail(emailMarie)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> onglet(WidgetTester tester, String libelle) async {
    // Revient dans la coquille de navigation (une route poussée en sort).
    GoRouter.of(tester.element(find.byType(Scaffold).first)).go(AppRoutes.home);
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text(libelle)));
    await tester.pumpAndSettle();
  }

  Future<void> allerA(WidgetTester tester, String route) async {
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push(route);
    await tester.pumpAndSettle();
  }

  testWidgets('utilisateur simple : ni organisation, ni fidèles, ni paramètres administrés (RG-SEC-06bis)', (
    tester,
  ) async {
    final donnees = (await tester.runAsync(() => preparer()))!;
    await demarrer(tester, donnees.db);

    await onglet(tester, 'Organisation');
    expect(find.text('GSG'), findsNothing);
    expect(find.textContaining('Accès réservé'), findsOneWidget);

    await onglet(tester, 'Fidèles');
    expect(find.text('Paul Doe'), findsNothing);
    expect(find.byType(FloatingActionButton), findsNothing);

    await allerA(tester, AppRoutes.fidele(donnees.paulId));
    expect(find.textContaining('Accès réservé'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets('membre : son église et sa fiche, en lecture seule', (tester) async {
    final donnees = (await tester.runAsync(() => preparer(roleMarie: 'membre')))!;
    await demarrer(tester, donnees.db);

    await onglet(tester, 'Organisation');
    expect(find.text('GSG'), findsOneWidget);
    expect(find.text('Église A'), findsNothing);
    expect(find.byType(FloatingActionButton), findsNothing);
    expect(find.byIcon(Icons.church_outlined), findsNothing);
    await tester.tap(find.text('GSG'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.text('Ajouter un nœud enfant'), findsNothing);
    expect(find.text('Responsables'), findsNothing);

    await allerA(tester, AppRoutes.organisationNoeud(egliseId));
    expect(find.textContaining('Accès réservé'), findsOneWidget);

    await onglet(tester, 'Fidèles');
    expect(find.text('Marie Doe'), findsOneWidget);
    expect(find.text('Paul Doe'), findsNothing);
    expect(find.byType(FloatingActionButton), findsNothing);
    await tester.tap(find.text('Marie Doe'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Modifier les coordonnées'), findsNothing);
    expect(find.byTooltip('Historique des modifications'), findsOneWidget);

    await allerA(tester, AppRoutes.fidele(donnees.paulId));
    expect(find.textContaining('Accès réservé'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets('responsable : modifie une fiche, l\'historique nomme l\'auteur (RG-II-05) ; pas de racine', (
    tester,
  ) async {
    final donnees = (await tester.runAsync(() => preparer(roleMarie: 'responsable')))!;
    await demarrer(tester, donnees.db);

    await onglet(tester, 'Organisation');
    expect(find.text('GSG'), findsOneWidget);
    // Créer la racine (niveau supérieur, RG-I-03) exige la capacité d'administrateur.
    expect(find.byType(FloatingActionButton), findsNothing);
    // Annuaire : capacité consulter_annuaire_eglises (rang responsable).
    expect(find.byIcon(Icons.church_outlined), findsOneWidget);

    await onglet(tester, 'Fidèles');
    await tester.tap(find.text('Paul Doe'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Modifier les coordonnées'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Téléphone'), '+22890000000');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Historique des modifications'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Par Marie Doe'), findsWidgets);

    await donnees.db.close();
  });

  testWidgets('administrateur : zone créée puis lue au journal des modifications (RG-XXIII-06)', (tester) async {
    final donnees = (await tester.runAsync(() => preparer(roleMarie: 'administrateur')))!;
    await demarrer(tester, donnees.db);

    await onglet(tester, 'Paramètres');
    await tester.tap(find.text('Zones géographiques'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Libellé'), 'Togo');
    await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
    await tester.pumpAndSettle();
    expect(find.text('Togo'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Journal des modifications'));
    await tester.pumpAndSettle();
    expect(find.text('Création · zones_geographiques'), findsOneWidget);
    expect(find.textContaining('Marie Doe'), findsOneWidget);
    expect(find.textContaining('Togo'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets('pasteur : ni zones ni journal, même par la route (RG-XXIII-06)', (tester) async {
    final donnees = (await tester.runAsync(() => preparer(roleMarie: 'pasteur')))!;
    await demarrer(tester, donnees.db);

    await onglet(tester, 'Paramètres');
    expect(find.text('Zones géographiques'), findsNothing);
    expect(find.text('Journal des modifications'), findsNothing);
    expect(find.text('Rôles'), findsWidgets);

    await allerA(tester, AppRoutes.zonesGeographiques);
    expect(find.byType(FloatingActionButton), findsNothing);
    await allerA(tester, AppRoutes.journalParametres);
    expect(find.text('Aucune modification enregistrée.'), findsNothing);

    await donnees.db.close();
  });
}
