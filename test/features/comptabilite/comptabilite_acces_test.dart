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
import 'package:ecclesias_360/features/finances/data/finances_repository.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// Module XXI — l'accès à la comptabilité d'un nœud suit la session réelle
/// (policy `ecritures_comptables_lecture`, 0019) : un responsable non
/// trésorier ne la voit pas, même par la route directe ; une membre désignée
/// trésorière du nœud (sans changer de rang) la consulte.
void main() {
  const email = 'marie@ecclesias.test';
  const noeudId = 'noeud-1';

  Future<AppDatabase> preparer(String role, {bool tresoriere = false}) async {
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
    final fideles = FideleRepository(db, SyncCoordinator(db));
    final marie = await fideles.creerFidele(
      noeudId: noeudId,
      nom: 'Doe',
      prenoms: 'Marie',
      dateNaissance: DateTime(1980, 1, 1),
      sexe: Sexe.feminin,
      statutCivil: StatutCivil.celibataire,
      email: email,
    );
    await (db.update(db.fideles)..where((t) => t.id.equals(marie.id))).write(FidelesCompanion(role: Value(role)));
    if (tresoriere) {
      await FinancesRepository(db, fideles).designerTresorier(fideleId: marie.id, noeudId: noeudId);
    }
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

  testWidgets('un responsable non trésorier ne voit pas la comptabilité, même par la route', (tester) async {
    final db = (await tester.runAsync(() => preparer('responsable')))!;

    await ouvrirFicheNoeud(tester, db);
    // Fait défiler la fiche jusqu'en bas : tous les boutons ont été construits.
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Comptabilité'), findsNothing);

    GoRouter.of(tester.element(find.byType(ListView))).push(AppRoutes.comptabiliteDuNoeud(noeudId));
    await tester.pumpAndSettle();
    expect(find.text('Accès réservé à un pasteur ou au trésorier du nœud.'), findsOneWidget);
    expect(find.text('Caisse'), findsNothing);

    await db.close();
  });

  testWidgets('désignée trésorière du nœud, une membre consulte la comptabilité', (tester) async {
    final db = (await tester.runAsync(() => preparer('membre', tresoriere: true)))!;

    await ouvrirFicheNoeud(tester, db);
    // Défile jusqu'en bas : `dragUntilVisible` s'arrête dès que le bouton
    // dépasse, encore masqué par la barre de navigation.
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Comptabilité'));
    await tester.pumpAndSettle();
    expect(find.text('Caisse'), findsOneWidget);
    expect(find.text('0 GNF'), findsOneWidget);

    await db.close();
  });
}
