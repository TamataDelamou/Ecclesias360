import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/discipline/data/discipline_repository.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_spirituel.dart';
import 'package:ecclesias_360/features/ministeres/data/ministere_repository.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';

/// RG-X-05 — la restriction d'accès au Module X suit la session réelle : un
/// membre (lié automatiquement à sa fiche par son e-mail) ne voit pas le
/// module ; membre d'une commission, il ne voit que le dossier qu'elle
/// instruit — jamais le sien à ce seul titre.
void main() {
  const emailMembre = 'marie@ecclesias.test';
  const noeudId = 'noeud-1';

  Future<({AppDatabase db, DisciplineRepository discipline, String marieId, String paulId, String natureId})>
      preparer() async {
    final db = AppDatabase(NativeDatabase.memory());
    final fideles = FideleRepository(db, SyncCoordinator(db));
    final discipline = DisciplineRepository(db, fideles, MinistereRepository(db, SyncCoordinator(db)));
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

    Future<String> fidele(String prenoms, {String? email}) async {
      final f = await fideles.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: prenoms,
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.celibataire,
        email: email,
      );
      await fideles.modifierStatutSpirituel(fideleId: f.id, cible: StatutSpirituel.membreActif, sautHistorique: true);
      return f.id;
    }

    return (
      db: db,
      discipline: discipline,
      marieId: await fidele('Marie', email: emailMembre),
      paulId: await fidele('Paul'),
      natureId: (await db.select(db.naturesFaute).get()).first.id,
    );
  }

  /// Connecte Marie (rôle membre par défaut de sa fiche) et ouvre la fiche du nœud.
  Future<void> ouvrirFicheNoeud(WidgetTester tester, AppDatabase db) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(
      EcclesiasApp(
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: const UtilisateurAuthentifie(id: 'compte-marie', identifiant: IdentifiantEmail(emailMembre)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(GridView), matching: find.text('Organisation')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('GSG'));
    await tester.pumpAndSettle();
  }

  testWidgets('un membre sans commission ne voit pas le module Discipline', (tester) async {
    final donnees = (await tester.runAsync(preparer))!;

    await ouvrirFicheNoeud(tester, donnees.db);

    await tester.dragUntilVisible(
      find.widgetWithText(OutlinedButton, 'Biens'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Dossiers disciplinaires'), findsNothing);
    await donnees.db.close();
  });

  testWidgets('un membre de commission ne voit que le dossier que sa commission instruit', (tester) async {
    final donnees = (await tester.runAsync(preparer))!;
    final discipline = donnees.discipline;

    // Écritures Drift hors du faux temps du harnais (même précédent que connexion_flow_test).
    await tester.runAsync(() async {
      final commissionA = await discipline.creerCommission(noeudId: noeudId, nom: 'Commission A');
      await discipline.ajouterMembreCommission(commissionId: commissionA.id, fideleId: donnees.marieId);
      final commissionB = await discipline.creerCommission(noeudId: noeudId, nom: 'Commission B');

      final dossierPaul = await discipline.ouvrirDossier(
        fideleId: donnees.paulId,
        noeudId: noeudId,
        natureFauteId: donnees.natureId,
        roleActeur: Role.pasteur,
      );
      await discipline.assignerCommission(dossierId: dossierPaul.id, commissionId: commissionA.id);
      // Dossier de Marie elle-même, instruit par une autre commission.
      await donnees.db.into(donnees.db.dossiersDisciplinaires).insert(
            DossiersDisciplinairesCompanion.insert(
              id: 'dossier-marie',
              fideleId: donnees.marieId,
              noeudId: noeudId,
              natureFauteId: donnees.natureId,
              dateOuverture: DateTime.now(),
              commissionId: Value(commissionB.id),
            ),
          );
    });

    await ouvrirFicheNoeud(tester, donnees.db);

    await tester.dragUntilVisible(
      find.widgetWithText(OutlinedButton, 'Dossiers disciplinaires'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Dossiers disciplinaires'));
    await tester.pumpAndSettle();

    expect(find.text('Paul Doe'), findsOneWidget);
    expect(find.text('Marie Doe'), findsNothing);
    await donnees.db.close();
  });
}
