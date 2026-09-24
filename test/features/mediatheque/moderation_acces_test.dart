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
import 'package:ecclesias_360/features/mediatheque/data/mediatheque_repository.dart';
import 'package:ecclesias_360/features/mediatheque/domain/models/type_contenu_mediatheque.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// RG-XIII-03 — écran de modération avec la session réelle : la pasteure
/// voit le commentaire masqué par trois signaleurs distincts, avec leurs
/// noms, et l'approuve (décision tracée à sa fiche) ; une membre n'y accède
/// pas, même par la route.
void main() {
  const email = 'marie@ecclesias.test';
  const noeudId = 'noeud-1';

  Future<({AppDatabase db, String marieId, String commentaireId})> preparer(String roleMarie) async {
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
    await (db.update(db.fideles)..where((t) => t.id.equals(marieId))).write(FidelesCompanion(role: Value(roleMarie)));
    final auteurId = await fiche('Auteur');

    final mediatheque = MediathequeRepository(db);
    final contenu = await mediatheque.ajouterContenu(
      typeContenu: TypeContenuMediatheque.audio,
      titre: 'Prédication',
      noeudEditeurId: noeudId,
      theme: 'Foi',
      dateContenu: DateTime(2026, 1, 1),
    );
    await mediatheque.publierContenu(contenu.id);
    final commentaire =
        await mediatheque.ajouterCommentaire(contenuId: contenu.id, fideleId: auteurId, texte: 'Commentaire déplacé');
    for (final prenoms in ['Luc', 'Rita', 'Paul']) {
      await mediatheque.signalerCommentaire(
        commentaireId: commentaire.id,
        fideleId: await fiche(prenoms),
        motif: prenoms == 'Luc' ? 'Hors sujet' : null,
      );
    }
    return (db: db, marieId: marieId, commentaireId: commentaire.id);
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
          connecte: const UtilisateurAuthentifie(id: 'compte-marie', identifiant: IdentifiantEmail(email)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push(AppRoutes.mediathequeModeration);
    await tester.pumpAndSettle();
  }

  testWidgets('la pasteure voit les signaleurs et approuve : décision tracée', (tester) async {
    final donnees = (await tester.runAsync(() => preparer('pasteur')))!;
    await demarrer(tester, donnees.db);

    expect(find.text('Commentaire déplacé'), findsOneWidget);
    expect(find.textContaining('Masqué'), findsOneWidget);
    expect(find.text('Signalé par Luc Doe : Hors sujet'), findsOneWidget);
    expect(find.text('Signalé par Rita Doe'), findsOneWidget);
    expect(find.text('Signalé par Paul Doe'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Approuver'));
    await tester.pumpAndSettle();

    final commentaire = (await tester.runAsync(
      () => (donnees.db.select(donnees.db.commentaires)..where((t) => t.id.equals(donnees.commentaireId))).getSingle(),
    ))!;
    expect(commentaire.statutModeration, 'publie');
    expect(commentaire.moderePar, donnees.marieId);
    expect(commentaire.dateModeration, isNotNull);
    expect(find.text('Aucun commentaire à modérer.'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets('une membre n\'accède pas à la modération, même par la route', (tester) async {
    final donnees = (await tester.runAsync(() => preparer('membre')))!;
    await demarrer(tester, donnees.db);

    expect(find.text('Modération réservée à un pasteur (ou rôle supérieur).'), findsOneWidget);
    expect(find.text('Commentaire déplacé'), findsNothing);

    await donnees.db.close();
  });
}
