import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
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

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// RG-XIII-03 / RG-SEC-06bis — l'auteur des actions est la session : un
/// utilisateur simple (compte sans fiche) lit la médiathèque sans agir et
/// ne voit pas un commentaire en attente de modération ; plus aucun
/// sélecteur « agir en tant que ».
void main() {
  testWidgets('un utilisateur simple lit un contenu publié sans agir', (tester) async {
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
      final paul = await FideleRepository(db, SyncCoordinator(db)).creerFidele(
        noeudId: 'noeud-1',
        nom: 'Doe',
        prenoms: 'Paul',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      final mediatheque = MediathequeRepository(db);
      final contenu = await mediatheque.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'La grâce',
        noeudEditeurId: 'noeud-1',
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
        moderationAPriori: true,
      );
      await mediatheque.publierContenu(contenu.id);
      // Modération a priori : ce commentaire reste en attente.
      await mediatheque.ajouterCommentaire(contenuId: contenu.id, fideleId: paul.id, texte: 'En attente');
    });

    // Base non vide, aucune fiche ne correspond : utilisateur simple.
    await tester.pumpWidget(
      EcclesiasApp(capacites: capacitesDeTest, 
        database: db,
        authGateway: AuthGatewayMemoire(
          connecte: const UtilisateurAuthentifie(id: 'visiteur', identifiant: IdentifiantEmail('visiteur@exemple.org')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final tuile = find.descendant(of: find.byType(GridView), matching: find.text('Catalogue médiathèque'));
    await tester.dragUntilVisible(tuile, find.byType(Scrollable).first, const Offset(0, -200));
    await tester.ensureVisible(tuile);
    await tester.pumpAndSettle();
    await tester.tap(tuile);
    await tester.pumpAndSettle();
    await tester.tap(find.text('La grâce').first);
    await tester.pumpAndSettle();

    expect(find.text('Agir en tant que'), findsNothing);
    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pumpAndSettle();
    expect(find.textContaining('Lecture seule'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Ajouter aux favoris'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Publier'), findsNothing);
    expect(find.text('En attente'), findsNothing);
    expect(find.text('Aucun commentaire pour le moment.'), findsOneWidget);

    await db.close();
  });
}
