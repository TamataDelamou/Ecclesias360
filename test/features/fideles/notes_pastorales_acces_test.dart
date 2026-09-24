import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/audit/acteur.dart';
import 'package:ecclesias_360/core/constants/app_routes.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/data/notes_pastorales_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// RG-II-11 — notes pastorales privées avec la session réelle : Marie,
/// liée à sa fiche par son e-mail, rédige et ouvre une note sur Paul si elle
/// est pasteure ; responsable, elle n'y accède ni par la fiche ni par les
/// routes directes ; Paul, concerné par une note, ne la lit jamais, même
/// pasteur de son propre nœud.
void main() {
  const emailMarie = 'marie@ecclesias.test';
  const emailPaul = 'paul@ecclesias.test';
  const noeudId = 'noeud-1';
  const accesReserve =
      'Accès réservé : les notes pastorales ne sont lisibles que par leur auteur et les pasteurs, jamais par le fidèle concerné.';

  Future<({AppDatabase db, String marieId, String paulId, String? noteId})> preparer({
    required String roleMarie,
    String rolePaul = 'membre',
    bool avecNote = false,
  }) async {
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
    Future<String> fiche(String prenoms, String email, String role) async {
      final id = (await fideles.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: prenoms,
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.celibataire,
        email: email,
      ))
          .id;
      await (db.update(db.fideles)..where((t) => t.id.equals(id))).write(FidelesCompanion(role: Value(role)));
      return id;
    }

    final marieId = await fiche('Marie', emailMarie, roleMarie);
    final paulId = await fiche('Paul', emailPaul, rolePaul);
    final redacteurId = await fiche('Jean', 'jean@ecclesias.test', 'pasteur');
    final noteId = avecNote
        ? (await NotesPastoralesRepository(db).rediger(
            acteur: Acteur(authUserId: 'compte-jean', fideleId: redacteurId, role: Role.pasteur),
            fideleId: paulId,
            contenu: 'Entretien confidentiel',
          ))
            .id
        : null;
    return (db: db, marieId: marieId, paulId: paulId, noteId: noteId);
  }

  Future<void> demarrer(WidgetTester tester, AppDatabase db, String email) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(
      EcclesiasApp(
        capacites: capacitesDeTest,
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: UtilisateurAuthentifie(id: 'compte-$email', identifiant: IdentifiantEmail(email)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> ouvrirFiche(WidgetTester tester, String nom) async {
    await tester.tap(find.descendant(of: find.byType(GridView), matching: find.text('Fidèles')));
    await tester.pumpAndSettle();
    await tester.tap(find.text(nom));
    await tester.pumpAndSettle();
  }

  Future<void> allerA(WidgetTester tester, String route) async {
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push(route);
    await tester.pumpAndSettle();
  }

  Future<int> journal(WidgetTester tester, AppDatabase db) async =>
      (await tester.runAsync(() => db.select(db.consultationsNotesPastorales).get()))!.length;

  testWidgets('la pasteure rédige depuis la fiche ; la liste cache le contenu ; l\'ouverture est journalisée',
      (tester) async {
    final donnees = (await tester.runAsync(() => preparer(roleMarie: 'pasteur')))!;
    await demarrer(tester, donnees.db, emailMarie);
    await ouvrirFiche(tester, 'Paul Doe');

    final bouton = find.widgetWithText(OutlinedButton, 'Notes pastorales privées');
    await tester.dragUntilVisible(bouton, find.byType(ListView), const Offset(0, -200));
    await tester.tap(bouton);
    await tester.pumpAndSettle();
    expect(find.text('Aucune note pastorale.'), findsOneWidget);

    await tester.tap(find.byTooltip('Rédiger une note'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Contenu de la note'), 'Accompagnement après le deuil');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    // Liste : l'auteur et la date, jamais le contenu ; rien de journalisé.
    expect(find.textContaining('Par Marie Doe'), findsOneWidget);
    expect(find.textContaining('Accompagnement'), findsNothing);
    expect(await journal(tester, donnees.db), 0);

    // Ouverture : contenu, puis journal (une ligne à son nom).
    await tester.tap(find.textContaining('Par Marie Doe'));
    await tester.pumpAndSettle();
    expect(find.text('Accompagnement après le deuil'), findsOneWidget);
    expect(await journal(tester, donnees.db), 1);
    expect(find.text('Journal des consultations'), findsOneWidget);
    expect(find.text('Marie Doe · Pasteur'), findsOneWidget);
    // Auteur : peut modifier.
    expect(find.byTooltip('Modifier la note'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets('une responsable ne voit pas le bouton et reste bloquée par les routes directes, sans trace',
      (tester) async {
    final donnees = (await tester.runAsync(() => preparer(roleMarie: 'responsable', avecNote: true)))!;
    await demarrer(tester, donnees.db, emailMarie);
    await ouvrirFiche(tester, 'Paul Doe');
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Notes pastorales privées'), findsNothing);

    await allerA(tester, AppRoutes.notesPastoralesDuFidele(donnees.paulId));
    expect(find.text(accesReserve), findsOneWidget);
    await allerA(tester, AppRoutes.notePastorale(donnees.noteId!));
    expect(find.text(accesReserve), findsOneWidget);
    expect(find.text('Entretien confidentiel'), findsNothing);
    expect(await journal(tester, donnees.db), 0);

    await donnees.db.close();
  });

  testWidgets('le fidèle concerné, même pasteur, ne lit jamais la note écrite sur lui', (tester) async {
    final donnees =
        (await tester.runAsync(() => preparer(roleMarie: 'membre', rolePaul: 'pasteur', avecNote: true)))!;
    await demarrer(tester, donnees.db, emailPaul);
    await ouvrirFiche(tester, 'Paul Doe');
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Notes pastorales privées'), findsNothing);

    await allerA(tester, AppRoutes.notesPastoralesDuFidele(donnees.paulId));
    expect(find.text(accesReserve), findsOneWidget);
    await allerA(tester, AppRoutes.notePastorale(donnees.noteId!));
    expect(find.text(accesReserve), findsOneWidget);
    expect(find.text('Entretien confidentiel'), findsNothing);
    expect(await journal(tester, donnees.db), 0);

    await donnees.db.close();
  });
}
