import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer fidèle -> nommer membre -> créer séance -> ajouter décision -> rédiger et valider le PV',
    (tester) async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      await tester.pumpWidget(EcclesiasApp(database: database));
      await tester.pumpAndSettle();

      // Crée le siège.
      await tester.tap(find.text('Organisation'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Nom'), 'Global Service Groupe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Code interne'), 'GSG-SIEGE');
      await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
      await tester.pumpAndSettle();

      // La création du siège fait déjà un pop automatique vers l'arbre :
      // un seul retour suffit pour revenir à l'accueil.
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Crée un fidèle.
      await tester.tap(find.text('Fidèles'));
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

      // La création du fidèle fait déjà un pop automatique vers la liste :
      // un seul retour suffit pour revenir à l'accueil.
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Va au nœud, nomme un membre du comité.
      await tester.tap(find.text('Organisation'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Membres du comité'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Membres du comité'));
      await tester.pumpAndSettle();

      expect(find.text('Aucun membre nommé.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Fonction (ex. Pasteur, Diacre)'), 'Pasteur');
      await tester.tap(find.widgetWithText(FilledButton, 'Nommer'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Jean Doe'), findsOneWidget);

      // Revient au nœud, crée une séance avec le fidèle présent.
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Séances du comité'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Séances du comité'));
      await tester.pumpAndSettle();

      expect(find.text('Aucune séance enregistrée.'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Ordre du jour'), 'Budget annuel');
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Jean Doe'));
      await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer la séance'));
      await tester.pumpAndSettle();

      expect(find.text('Budget annuel'), findsOneWidget);
      expect(find.text('Quorum non configuré'), findsOneWidget);

      // Ouvre la séance, ajoute une décision, l'adopte (autorisé même sans
      // quorum configuré n'est PAS le cas : quorum non configuré bloque
      // l'adoption, RG-VII-05) puis vérifie le blocage, avant de tester le
      // PV qui lui n'est pas soumis au quorum.
      await tester.tap(find.text('Budget annuel'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Ajouter'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, 'Libellé'), 'Adopter le budget');
      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Adopter le budget'), findsOneWidget);

      // Rédige et valide le procès-verbal (indépendant du quorum).
      await tester.enterText(
        find.widgetWithText(TextField, 'Brouillon du procès-verbal'),
        'Compte-rendu de la séance du comité.',
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Enregistrer le brouillon'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Valider (immuable)'));
      await tester.pumpAndSettle();

      expect(find.text('Ce procès-verbal est validé et immuable.'), findsOneWidget);
      expect(find.text('Compte-rendu de la séance du comité.'), findsOneWidget);

      await database.close();
    },
  );
}
