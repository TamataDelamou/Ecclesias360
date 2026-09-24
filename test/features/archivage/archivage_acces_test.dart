import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/constants/app_routes.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/archivage/data/archivage_repository.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/discipline/data/discipline_repository.dart';
import 'package:ecclesias_360/features/discipline/domain/models/nature_piece_dossier.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/ministeres/data/ministere_repository.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';

/// Module VIII — la confidentialité d'une archive suit la session réelle et,
/// pour une pièce disciplinaire, la règle de son dossier (RG-X-05) ; toute
/// lecture d'une pièce ou ouverture d'un dossier est journalisée (RG-SEC-06).
/// Marie : responsable (hors commission), membre de la commission, ou pasteure.
void main() {
  const email = 'marie@ecclesias.test';
  const noeudId = 'noeud-1';
  const compteMarie = 'compte-marie';

  Future<({AppDatabase db, String dossierId, String pieceId})> preparer(String role, {bool commission = false}) async {
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
    Future<String> fiche(String prenoms, {String? email}) async => (await fideles.creerFidele(
          noeudId: noeudId,
          nom: 'Doe',
          prenoms: prenoms,
          dateNaissance: DateTime(1980, 1, 1),
          sexe: Sexe.feminin,
          statutCivil: StatutCivil.celibataire,
          email: email,
        ))
            .id;
    final marieId = await fiche('Marie', email: email);
    await (db.update(db.fideles)..where((t) => t.id.equals(marieId))).write(FidelesCompanion(role: Value(role)));
    final concerneId = await fiche('Paul');

    final archivage = ArchivageRepository(db);
    final discipline = DisciplineRepository(db, fideles, MinistereRepository(db, SyncCoordinator(db)),
        archivageRepository: archivage);
    final k = await discipline.creerCommission(noeudId: noeudId, nom: 'Commission K');
    if (commission) await discipline.ajouterMembreCommission(commissionId: k.id, fideleId: marieId);
    final dossier = await discipline.ouvrirDossier(
      fideleId: concerneId,
      noeudId: noeudId,
      natureFauteId: (await db.select(db.naturesFaute).get()).first.id,
      roleActeur: Role.pasteur,
    );
    await discipline.assignerCommission(dossierId: dossier.id, commissionId: k.id);
    final piece = await discipline.ajouterPiece(
      dossierId: dossier.id,
      nature: NaturePieceDossier.temoignage,
      contenu: 'Témoignage confidentiel',
      noeudId: noeudId,
    );
    await archivage.archiver(
      typeDocument: 'proces_verbal_comite',
      moduleOrigine: 'comite',
      objetIdOrigine: 'seance-1',
      noeudId: noeudId,
      fichier: 'pv.pdf',
    );
    return (db: db, dossierId: dossier.id, pieceId: piece.documentArchiveId!);
  }

  Future<void> demarrer(WidgetTester tester, AppDatabase db) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(
      EcclesiasApp(
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: const UtilisateurAuthentifie(id: compteMarie, identifiant: IdentifiantEmail(email)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> allerA(WidgetTester tester, String route) async {
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push(route);
    await tester.pumpAndSettle();
  }

  Future<List<ConsultationDisciplinaireRow>> journal(WidgetTester tester, AppDatabase db) async =>
      (await tester.runAsync(() => db.select(db.consultationsDisciplinaires).get()))!;

  testWidgets('un responsable hors commission voit le PV, jamais la pièce, même par la route', (tester) async {
    final donnees = (await tester.runAsync(() => preparer('responsable')))!;
    await demarrer(tester, donnees.db);

    await allerA(tester, AppRoutes.documentsArchive(noeudId));
    expect(find.textContaining('PV-GSG-SIEGE-'), findsOneWidget);
    expect(find.textContaining('PD-GSG-SIEGE-'), findsNothing);

    await allerA(tester, AppRoutes.documentArchive(donnees.pieceId));
    expect(find.textContaining('Accès réservé'), findsOneWidget);
    expect(find.text('Version 1'), findsNothing);
    expect(await journal(tester, donnees.db), isEmpty);

    await donnees.db.close();
  });

  testWidgets('membre de la commission : lit la pièce, la lecture est journalisée ; pas de bibliothèque', (tester) async {
    final donnees = (await tester.runAsync(() => preparer('membre', commission: true)))!;
    await demarrer(tester, donnees.db);

    await allerA(tester, AppRoutes.documentsArchive(noeudId));
    expect(find.textContaining('Accès réservé'), findsOneWidget);

    await allerA(tester, AppRoutes.documentArchive(donnees.pieceId));
    expect(find.text('Version 1'), findsOneWidget);

    final lignes = await journal(tester, donnees.db);
    expect(lignes, hasLength(1));
    expect(lignes.single.authUserId, compteMarie);
    expect(lignes.single.dossierId, donnees.dossierId);
    expect(lignes.single.documentArchiveId, donnees.pieceId);

    // La commission n'a pas accès au journal lui-même (réservé au pasteur).
    await allerA(tester, AppRoutes.dossierDisciplinaire(donnees.dossierId));
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.text('Journal des consultations'), findsNothing);
    expect(await journal(tester, donnees.db), hasLength(2));

    await donnees.db.close();
  });

  testWidgets('une pasteure ouvre le dossier et voit sa consultation au journal', (tester) async {
    final donnees = (await tester.runAsync(() => preparer('pasteur')))!;
    await demarrer(tester, donnees.db);

    await allerA(tester, AppRoutes.dossierDisciplinaire(donnees.dossierId));
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.text('Journal des consultations'), findsOneWidget);
    expect(find.textContaining('Marie Doe'), findsOneWidget);
    expect(find.textContaining('Fiche du dossier'), findsOneWidget);

    await donnees.db.close();
  });
}
