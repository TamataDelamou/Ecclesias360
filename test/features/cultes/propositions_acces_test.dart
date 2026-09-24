import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/cultes/data/culte_repository.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';

/// RG-XII-06 — l'auteur des soumissions et des votes est la session : Marie
/// (liée à sa fiche par son e-mail) vote sur la proposition de Paul, jamais
/// sur la sienne ; plus aucun sélecteur « voter en tant que ».
void main() {
  testWidgets('une fidèle vote sur la proposition d\'autrui, jamais sur la sienne', (tester) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    final db = AppDatabase(NativeDatabase.memory());
    await tester.runAsync(() async {
      await db.into(db.organisationNodes).insert(
            OrganisationNodesCompanion.insert(
              id: 'noeud-1',
              typeNoeud: 'siege',
              nom: 'GSG',
              codeInterne: 'GSG-SIEGE',
              path: '/noeud-1/',
              depth: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
      final fideles = FideleRepository(db, SyncCoordinator(db));
      Future<String> fiche(String prenoms, {String? email}) async => (await fideles.creerFidele(
            noeudId: 'noeud-1',
            nom: 'Doe',
            prenoms: prenoms,
            dateNaissance: DateTime(1980, 1, 1),
            sexe: Sexe.feminin,
            statutCivil: StatutCivil.celibataire,
            email: email,
          ))
              .id;
      final marieId = await fiche('Marie', email: 'marie@ecclesias.test');
      final paulId = await fiche('Paul');
      final cultes = CulteRepository(db);
      await cultes.soumettreProposition(fideleId: paulId, titre: 'La grâce');
      await cultes.soumettreProposition(fideleId: marieId, titre: 'La foi');
    });

    await tester.pumpWidget(
      EcclesiasApp(
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: const UtilisateurAuthentifie(id: 'compte-marie', identifiant: IdentifiantEmail('marie@ecclesias.test')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.descendant(of: find.byType(GridView), matching: find.text('Propositions de thème')),
      find.byType(Scrollable).first,
      const Offset(0, -200),
    );
    await tester.ensureVisible(find.descendant(of: find.byType(GridView), matching: find.text('Propositions de thème')));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(GridView), matching: find.text('Propositions de thème')));
    await tester.pumpAndSettle();

    expect(find.text('Voter en tant que'), findsNothing);

    Finder carte(String titre) => find.ancestor(of: find.text(titre), matching: find.byType(Card));
    IconButton pouce(String titre) => tester.widget<IconButton>(
          find.descendant(of: carte(titre), matching: find.widgetWithIcon(IconButton, Icons.thumb_up_outlined)),
        );

    // Sa propre proposition : pas de vote, mention « Votre proposition ».
    expect(pouce('La foi').onPressed, isNull);
    expect(find.descendant(of: carte('La foi'), matching: find.text('Votre proposition')), findsOneWidget);

    // Celle de Paul : elle vote.
    expect(pouce('La grâce').onPressed, isNotNull);
    await tester.tap(find.descendant(of: carte('La grâce'), matching: find.widgetWithIcon(IconButton, Icons.thumb_up_outlined)));
    await tester.pumpAndSettle();
    expect(find.descendant(of: carte('La grâce'), matching: find.text('1')), findsOneWidget);

    await db.close();
  });
}
