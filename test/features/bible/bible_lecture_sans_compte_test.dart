import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/constants/app_routes.dart';
import 'package:ecclesias_360/core/router/app_router.dart';
import 'package:ecclesias_360/features/auth/application/session_controller.dart';
import 'package:ecclesias_360/features/auth/data/compte_repository.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/bible_pour_tests.dart';
import '../../helpers/capacites_pour_tests.dart';

/// Module XXIV — lecture sans compte (RG-SEC-06bis amendé) et navigation du
/// lecteur (dossier de reconstruction §4) : bouton retour explicite, nom du
/// livre cliquable vers ses chapitres, tiroir latéral des chapitres.
void main() {
  group('garde du routeur : seule la lecture biblique est publique', () {
    late AppDatabase db;
    late SessionController session;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      session = SessionController(AuthGatewayMemoire(), CompteRepository(db));
      // Laisse la session sortir de l'état « chargement » (aucun compte).
      await Future<void>.delayed(Duration.zero);
    });
    tearDown(() async {
      session.dispose();
      await db.close();
    });

    test('sans session : /bible et /bible/recherche ouvertes, le reste fermé', () {
      expect(session.estConnecte, isFalse);
      expect(redirectionSession(session, AppRoutes.bible), isNull);
      expect(redirectionSession(session, AppRoutes.bibleRecherche), isNull);
      expect(redirectionSession(session, '/bibliotheque'), AppRoutes.connexion);
      expect(redirectionSession(session, AppRoutes.fideles), AppRoutes.connexion);
      expect(redirectionSession(session, AppRoutes.home), AppRoutes.connexion);
      expect(redirectionSession(session, AppRoutes.mediatheque), AppRoutes.connexion);
    });
  });

  testWidgets('sans compte : lire, changer de livre et de chapitre, chercher, revenir à la connexion', (tester) async {
    tester.platformDispatcher.localeTestValue = const Locale('fr');
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    final db = AppDatabase(NativeDatabase.memory());
    final bible = (await tester.runAsync(() => bibleDeTest(db)))!;
    await tester.pumpWidget(
      EcclesiasApp(capacites: capacitesDeTest, database: db, authGateway: AuthGatewayMemoire(), bibleRepository: bible),
    );
    await tester.pumpAndSettle();

    // Écran de connexion : lien vers la lecture sans compte.
    final lien = find.widgetWithText(OutlinedButton, 'Lire la Bible sans compte');
    await tester.ensureVisible(lien);
    await tester.tap(lien);
    await tester.pumpAndSettle();
    expect(find.text('Genèse 1'), findsOneWidget);
    expect(find.textContaining('Au commencement, Dieu créa les cieux et la terre.'), findsOneWidget);

    // Nom du livre cliquable → chapitres → « Changer de livre » → Jean → 3.
    await tester.tap(find.byKey(const ValueKey('bible-titre-livre')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Changer de livre'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Jean'), 300, scrollable: find.byType(Scrollable).last);
    await tester.tap(find.text('Jean'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '3'));
    await tester.pumpAndSettle();
    expect(find.text('Jean 3'), findsOneWidget);
    expect(find.textContaining('nommé Nicodème'), findsOneWidget);

    // Tiroir latéral des chapitres du livre courant.
    await tester.tap(find.byTooltip('Chapitres du livre'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chapitre 4'));
    await tester.pumpAndSettle();
    expect(find.text('Jean 4'), findsOneWidget);

    // Chapitre suivant.
    await tester.tap(find.byTooltip('Chapitre suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Jean 5'), findsOneWidget);

    // Recherche locale sans accents → Psaumes 23:1 → ouverture du passage.
    await tester.tap(find.byTooltip('Recherche'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Recherche locale, hors connexion'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'eternel est mon berger');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Psaumes 23:1'));
    await tester.pumpAndSettle();
    expect(find.text('Psaumes 23'), findsOneWidget);

    // Une version à télécharger, sans stockage configuré : échec affiché,
    // jamais d'installation silencieuse.
    await tester.tap(find.widgetWithText(TextButton, 'Louis Segond 1910'));
    await tester.pumpAndSettle();
    expect(find.text('Crampon'), findsOneWidget);
    await tester.tap(find.descendant(of: find.widgetWithText(ListTile, 'Crampon'), matching: find.byType(TextButton)));
    await tester.pumpAndSettle();
    expect(find.textContaining('Le téléchargement a échoué'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    // Bouton retour explicite jusqu'à l'écran de connexion.
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byTooltip('Retour').last);
      await tester.pumpAndSettle();
      if (find.text('Lire la Bible sans compte').evaluate().isNotEmpty) break;
    }
    expect(find.widgetWithText(OutlinedButton, 'Lire la Bible sans compte'), findsOneWidget);

    // Aucune autre route n'est ouverte sans compte.
    GoRouter.of(tester.element(find.byType(Scaffold).first)).go(AppRoutes.fideles);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Lire la Bible sans compte'), findsOneWidget);

    await tester.runAsync(bible.fermer);
    await db.close();
  });
}
