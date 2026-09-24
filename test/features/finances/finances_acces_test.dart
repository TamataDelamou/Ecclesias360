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
import 'package:ecclesias_360/features/finances/domain/models/origine_contribution.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/capacites_pour_tests.dart';

/// RG-SEC-06 / RG-XI-02 — l'accès aux finances suit la session réelle :
/// Marie, membre liée à sa fiche par son e-mail, ne voit ni les finances du
/// nœud ni les contributions d'autrui ; désignée trésorière du nœud (sans
/// changer de rang), elle y accède et peut décider d'une contribution.
void main() {
  const emailMembre = 'marie@ecclesias.test';
  const noeudId = 'noeud-1';

  Future<({AppDatabase db, FinancesRepository finances, String marieId, String paulId})> preparer() async {
    final db = AppDatabase(NativeDatabase.memory());
    final fideles = FideleRepository(db, SyncCoordinator(db));
    final finances = FinancesRepository(db, fideles);
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
    Future<String> fidele(String prenoms, {String? email}) async => (await fideles.creerFidele(
          noeudId: noeudId,
          nom: 'Doe',
          prenoms: prenoms,
          dateNaissance: DateTime(1980, 1, 1),
          sexe: Sexe.feminin,
          statutCivil: StatutCivil.celibataire,
          email: email,
        ))
            .id;
    final marieId = await fidele('Marie', email: emailMembre);
    final paulId = await fidele('Paul');
    final typeId = (await db.select(db.typesOffrande).get()).first.id;
    for (final (donateur, montant) in [(marieId, 1000), (paulId, 7000)]) {
      await finances.saisirContribution(
        fideleId: donateur,
        typeOffrandeId: typeId,
        montant: montant,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: donateur,
      );
    }
    return (db: db, finances: finances, marieId: marieId, paulId: paulId);
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

  testWidgets('un membre ne voit ni les finances du nœud ni les contributions d\'autrui', (tester) async {
    final donnees = (await tester.runAsync(preparer))!;

    await ouvrirFicheNoeud(tester, donnees.db);
    // Fait défiler la fiche jusqu'en bas : tous les boutons ont été construits.
    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Contributions'), findsNothing);
    expect(find.widgetWithText(OutlinedButton, 'Projets'), findsNothing);

    // Son propre historique reste accessible, limité à ses contributions.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(GridView), matching: find.text('Fidèles')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marie Doe'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.widgetWithText(OutlinedButton, 'Historique des contributions'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Historique des contributions'));
    await tester.pumpAndSettle();
    expect(find.textContaining('1000'), findsWidgets);
    expect(find.textContaining('7000'), findsNothing);

    await donnees.db.close();
  });

  testWidgets('désignée trésorière du nœud, une membre accède aux finances et décide', (tester) async {
    final donnees = (await tester.runAsync(preparer))!;
    await tester.runAsync(() => donnees.finances.designerTresorier(fideleId: donnees.marieId, noeudId: noeudId));

    await ouvrirFicheNoeud(tester, donnees.db);
    await tester.dragUntilVisible(
      find.widgetWithText(OutlinedButton, 'Contributions'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Contributions'));
    await tester.pumpAndSettle();

    // Trésorière (rang membre) : pas de désignation de trésoriers.
    expect(find.byIcon(Icons.badge_outlined), findsNothing);
    await tester.tap(find.textContaining('7000').first);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Valider'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Rejeter'), findsOneWidget);

    // Sa propre saisie (1000) : aucune décision possible, elle attend une
    // autre personne habilitée (RG-XI-02).
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('1000').first);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Valider'), findsNothing);
    expect(find.textContaining('Vous avez saisi cette contribution'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets(
      'trésorière de rang membre : engagements d\'un fidèle depuis Contributions, '
      'sans jamais ouvrir sa fiche (route directe comprise)', (tester) async {
    final donnees = (await tester.runAsync(preparer))!;
    await tester.runAsync(() => donnees.finances.designerTresorier(fideleId: donnees.marieId, noeudId: noeudId));

    await ouvrirFicheNoeud(tester, donnees.db);
    await tester.dragUntilVisible(
      find.widgetWithText(OutlinedButton, 'Contributions'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Contributions'));
    await tester.pumpAndSettle();

    // Point d'entrée « Engagements des fidèles » du nœud : noms seuls.
    await tester.tap(find.byTooltip('Engagements des fidèles'));
    await tester.pumpAndSettle();
    expect(find.text('Engagements des fidèles'), findsOneWidget);
    await tester.tap(find.text('Paul Doe'));
    await tester.pumpAndSettle();

    // Engagements de Paul : lus et créés par la trésorière.
    expect(find.text('Engagements et échéances'), findsOneWidget);
    expect(find.text('Aucun engagement.'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Montant prévu'), '2500');
    await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
    await tester.pumpAndSettle();
    expect(find.textContaining('2500 GNF'), findsOneWidget);
    // Rien de la fiche n'est exposé sur ces écrans.
    expect(find.text('Historique'), findsNothing);
    expect(find.textContaining('Statut spirituel'), findsNothing);

    // La fiche de Paul reste fermée, même par sa route directe.
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push('/fideles/${donnees.paulId}');
    await tester.pumpAndSettle();
    expect(find.text('Accès réservé : vous ne pouvez consulter que votre propre fiche.'), findsOneWidget);
    expect(find.text('Paul Doe'), findsNothing);
    // Son historique aussi.
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push('/fideles/${donnees.paulId}/historique');
    await tester.pumpAndSettle();
    expect(find.text('Accès réservé : vous ne pouvez consulter que votre propre fiche.'), findsOneWidget);

    await donnees.db.close();
  });

  testWidgets('sans désignation, une membre n\'ouvre ni le point d\'entrée ni les engagements d\'autrui par la route',
      (tester) async {
    final donnees = (await tester.runAsync(preparer))!;

    await ouvrirFicheNoeud(tester, donnees.db);
    GoRouter.of(tester.element(find.byType(Scaffold).first)).push(AppRoutes.engagementsDuNoeud(noeudId));
    await tester.pumpAndSettle();
    expect(find.text('Accès réservé à un pasteur, au trésorier du nœud ou au fidèle concerné.'), findsOneWidget);
    expect(find.text('Paul Doe'), findsNothing);

    GoRouter.of(tester.element(find.byType(Scaffold).first)).push(AppRoutes.engagementsDuFidele(donnees.paulId));
    await tester.pumpAndSettle();
    expect(find.text('Accès réservé à un pasteur, au trésorier du nœud ou au fidèle concerné.'), findsOneWidget);

    await donnees.db.close();
  });
}
