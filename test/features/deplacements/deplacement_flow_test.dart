import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'demande de mutation -> validation des deux côtés -> rattachement change '
    '-> lettre de recommandation archivée (RG-IX-01/02/03/04)',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      // Les écrans utilisent l10n.* : fige la locale pour que les libellés
      // tapés dans ce test (français) correspondent, quelle que soit la
      // locale système de la machine qui exécute les tests.
      tester.platformDispatcher.localeTestValue = const Locale('fr');
      tester.platformDispatcher.localesTestValue = const [Locale('fr')];
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);

      await tester.pumpWidget(EcclesiasApp(database: database));
      await tester.pumpAndSettle();

      final navOrganisation =
          find.descendant(of: find.byType(GridView), matching: find.text('Organisation'));
      final navFideles = find.descendant(of: find.byType(GridView), matching: find.text('Fidèles'));

      // --- Prépare le terrain : un siège, un fidèle rattaché, un second nœud ---

      // Crée le siège.
      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Global Service Groupe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Code interne'), 'GSG-SIEGE');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Crée un fidèle rattaché au siège.
      await tester.tap(navFideles);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('champ_noeud')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Doe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Prénoms'), 'Jean');

      await tester.tap(find.text('Date de naissance'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('champ_sexe')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('masculin').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('champ_statut_civil')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('celibataire').last);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Depuis la fiche du siège, crée un second nœud (destination de la
      // future mutation).
      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.widgetWithText(OutlinedButton, 'Ajouter un nœud enfant'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Ajouter un nœud enfant'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<TypeNoeud>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('district').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'District Nord');
      await tester.enterText(find.widgetWithText(TextFormField, 'Code interne'), 'GSG-NORD');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // --- Module IX : demande de mutation (RG-IX-01) ---

      await tester.scrollUntilVisible(
        find.widgetWithText(OutlinedButton, 'Mutations'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Mutations'));
      await tester.pumpAndSettle();

      expect(find.text('Aucune mutation.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Demander une mutation'), findsOneWidget);
      await tester.enterText(find.widgetWithText(TextField, 'Motif'), 'Déménagement professionnel');
      await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
      await tester.pumpAndSettle();

      expect(find.text('Jean Doe'), findsOneWidget);
      expect(find.textContaining('Global Service Groupe → District Nord'), findsOneWidget);
      expect(find.text('En attente'), findsWidgets);

      // --- Validation pastorale des deux côtés (RG-IX-01) ---

      await tester.tap(find.text('Jean Doe'));
      await tester.pumpAndSettle();

      expect(find.text('En attente'), findsWidgets);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Valider (origine)'));
      await tester.pumpAndSettle();

      // Une seule des deux validations : la mutation reste en attente et le
      // bouton d'origine est désormais désactivé (déjà validé de ce côté).
      expect(find.text('En attente'), findsWidgets);
      final boutonOrigine = tester.widget<OutlinedButton>(
        find.ancestor(of: find.text('Valider (origine)'), matching: find.byType(OutlinedButton)),
      );
      expect(boutonOrigine.onPressed, isNull, reason: 'Validation unilatérale non autorisée par défaut (RG-IX-01).');

      await tester.tap(find.widgetWithText(OutlinedButton, 'Valider (destination)'));
      await tester.pumpAndSettle();

      // Les deux côtés ont validé : la mutation devient validée, le
      // rattachement change (RG-IX-03) et la lettre de recommandation est
      // archivée (RG-IX-02).
      expect(find.text('Validée'), findsWidgets);
      expect(find.widgetWithText(OutlinedButton, 'Voir la lettre de recommandation'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Voir la lettre de recommandation'));
      await tester.pumpAndSettle();

      expect(find.text('lettre_recommandation'), findsOneWidget);

      // --- RG-IX-03 : l'historique des déplacements du fidèle reflète la
      // mutation validée. ---

      // 5 écrans empilés depuis l'accueil : document -> mutation -> liste des
      // mutations -> fiche du nœud -> arbre organisationnel -> accueil.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(navFideles);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jean Doe'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.widgetWithText(OutlinedButton, 'Historique des déplacements'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Historique des déplacements'));
      await tester.pumpAndSettle();

      expect(find.text('Validée'), findsWidgets);
      expect(find.textContaining('Global Service Groupe → District Nord'), findsWidgets);

      await database.close();
    },
  );
}
