import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/constants/app_routes.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/auth/domain/models/methode_otp.dart';
import 'package:ecclesias_360/features/auth/presentation/connexion_screen.dart';
import 'package:ecclesias_360/features/auth/presentation/liaisons_comptes_screen.dart';
import 'package:ecclesias_360/features/auth/presentation/verification_code_screen.dart';
import 'package:ecclesias_360/features/home/presentation/home_screen.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:ecclesias_360/features/parametres/presentation/parametres_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

void main() {
  testWidgets(
    'sans session : connexion -> E.164 refusé -> SMS -> code faux -> bon code -> accueil -> déconnexion',
    (tester) async {
      // Libellés l10n : locale figée (même précédent que les autres flux).
      tester.platformDispatcher.localeTestValue = const Locale('fr');
      tester.platformDispatcher.localesTestValue = const [Locale('fr')];
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final gateway = AuthGatewayMemoire();

      await tester.pumpWidget(EcclesiasApp(capacites: capacitesDeTest, database: database, authGateway: gateway));
      await tester.pumpAndSettle();

      // Garde d'accès : aucune route applicative sans session.
      expect(find.byType(ConnexionScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);

      // Numéro national : refusé côté client, aucun appel au serveur.
      await tester.enterText(find.byKey(const ValueKey('champIdentifiant')), '620000001');
      await tester.tap(find.text('Recevoir le code'));
      await tester.pumpAndSettle();
      expect(find.textContaining('indicatif pays'), findsOneWidget);
      expect(gateway.codesEnvoyes, isEmpty);

      await tester.enterText(find.byKey(const ValueKey('champIdentifiant')), '+224 620 00 00 01');
      await tester.tap(find.text('WhatsApp'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Recevoir le code'));
      await tester.pumpAndSettle();
      expect(gateway.codesEnvoyes.single, (const IdentifiantTelephone('+224620000001'), MethodeOtp.whatsapp));
      expect(find.byType(VerificationCodeScreen), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('champCode')), '000000');
      await tester.tap(find.text('Se connecter'));
      await tester.pumpAndSettle();
      expect(find.textContaining('invalide ou a expiré'), findsOneWidget);
      expect(find.byType(VerificationCodeScreen), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('champCode')), '123456');
      await tester.tap(find.text('Se connecter'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      // Base vide : premier compte administrateur d'amorçage.
      await tester.tap(find.text('Paramètres').last);
      await tester.pumpAndSettle();
      expect(find.byType(ParametresScreen), findsOneWidget);
      expect(find.text('Connecté : +224620000001'), findsOneWidget);
      expect(find.text('Administrateur'), findsOneWidget);
      expect(find.text('Liaisons de comptes'), findsOneWidget);

      await tester.tap(find.text('Se déconnecter'));
      await tester.pumpAndSettle();
      expect(find.byType(ConnexionScreen), findsOneWidget);

      await database.close();
    },
  );

  testWidgets('branche e-mail : Magic Link et code e-mail seuls proposés, bascule depuis la branche téléphone',
      (tester) async {
    // Libellés l10n : locale figée (même précédent que les autres flux).
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final gateway = AuthGatewayMemoire();

    await tester.pumpWidget(EcclesiasApp(capacites: capacitesDeTest, database: database, authGateway: gateway));
    await tester.pumpAndSettle();

    expect(find.text('SMS'), findsOneWidget);
    await tester.tap(find.text('Recevoir plutôt un code par e-mail'));
    await tester.pumpAndSettle();
    expect(find.text('SMS'), findsNothing);
    expect(find.text('Lien de connexion (Magic Link)'), findsOneWidget);
    expect(find.text('Code par e-mail'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('champIdentifiant')), ' Pasteur@Eglise.org ');
    await tester.tap(find.text('Recevoir le code'));
    await tester.pumpAndSettle();
    expect(gateway.codesEnvoyes.single, (const IdentifiantEmail('pasteur@eglise.org'), MethodeOtp.magicLink));
    expect(find.textContaining('ouvrir le lien du même e-mail'), findsOneWidget);

    await database.close();
  });

  testWidgets('utilisateur simple : pas d\'accès au journal des liaisons (garde du routeur)', (tester) async {
    // Libellés l10n : locale figée (même précédent que les autres flux).
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    // Base non vide et aucune fiche correspondante : utilisateur simple.
    await tester.runAsync(() => OrganisationNodeRepository(database, SyncCoordinator(database)).creerNoeud(
          typeNoeud: TypeNoeud.siege,
          noeudParentId: null,
          nom: 'Siège',
          codeInterne: 'SIEGE',
        ));
    final gateway = AuthGatewayMemoire(
      connecte: const UtilisateurAuthentifie(id: 'visiteur', identifiant: IdentifiantEmail('visiteur@exemple.org')),
    );

    await tester.pumpWidget(EcclesiasApp(capacites: capacitesDeTest, database: database, authGateway: gateway));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Paramètres').last);
    await tester.pumpAndSettle();
    expect(find.text('Utilisateur simple'), findsOneWidget);
    expect(find.text('Liaisons de comptes'), findsNothing);

    GoRouter.of(tester.element(find.byType(ParametresScreen))).go(AppRoutes.liaisonsComptes);
    await tester.pumpAndSettle();
    expect(find.byType(LiaisonsComptesScreen), findsNothing);
    expect(find.byType(ParametresScreen), findsOneWidget);

    await database.close();
  });
}
