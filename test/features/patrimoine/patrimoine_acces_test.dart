import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/patrimoine/data/patrimoine_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// Module XX — l'accès suit la session réelle : un membre ne voit pas le
/// patrimoine du nœud (policy `biens_acces`, approchée par le rang
/// responsable) ; un responsable le voit mais ne sort pas un bien, acte
/// réservé à un pasteur ou plus (RG-XX-02).
void main() {
  const email = 'marie@ecclesias.test';
  const noeudId = 'noeud-1';

  Future<AppDatabase> preparer(String role) async {
    final db = AppDatabase(NativeDatabase.memory());
    await db.into(db.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: noeudId,
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG-SIEGE',
            path: '/$noeudId/',
            depth: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
    final marie = await FideleRepository(db, SyncCoordinator(db)).creerFidele(
      noeudId: noeudId,
      nom: 'Doe',
      prenoms: 'Marie',
      dateNaissance: DateTime(1980, 1, 1),
      sexe: Sexe.feminin,
      statutCivil: StatutCivil.celibataire,
      email: email,
    );
    await (db.update(db.fideles)..where((t) => t.id.equals(marie.id))).write(FidelesCompanion(role: Value(role)));
    await PatrimoineRepository(db).ajouterBien(
      idInventaire: 'INV-001',
      categorieId: (await db.select(db.categoriesBien).get()).first.id,
      noeudId: noeudId,
      designation: 'Sonorisation',
      valeurAcquisition: 1000,
      valeurVenale: 500,
      devise: 'GNF',
      dateAcquisition: DateTime(2025, 1, 1),
    );
    return db;
  }

  Future<void> ouvrirFicheNoeud(WidgetTester tester, AppDatabase db) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(
      EcclesiasApp(capacites: capacitesDeTest, 
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: const UtilisateurAuthentifie(id: 'compte-marie', identifiant: IdentifiantEmail(email)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(GridView), matching: find.text('Organisation')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('GSG'));
    await tester.pumpAndSettle();
  }

  testWidgets('un membre ne voit pas le patrimoine du nœud', (tester) async {
    final db = (await tester.runAsync(() => preparer('membre')))!;

    await ouvrirFicheNoeud(tester, db);
    // Fait défiler la fiche jusqu'en bas : tous les boutons ont été construits.
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Biens'), findsNothing);

    await db.close();
  });

  testWidgets('un responsable voit le patrimoine mais ne sort pas un bien (RG-XX-02)', (tester) async {
    final db = (await tester.runAsync(() => preparer('responsable')))!;

    await ouvrirFicheNoeud(tester, db);
    await tester.dragUntilVisible(find.widgetWithText(OutlinedButton, 'Biens'), find.byType(ListView), const Offset(0, -200));
    await tester.tap(find.widgetWithText(OutlinedButton, 'Biens'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Sonorisation'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, "Signaler l'état"), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Sortir le bien'), findsNothing);

    await db.close();
  });
}
