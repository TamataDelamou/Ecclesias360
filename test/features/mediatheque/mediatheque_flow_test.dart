import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_gateway_memoire.dart';
import '../../helpers/parcours.dart';

void main() {
  testWidgets(
    'accueil -> créer siège -> créer un fidèle -> créer un culte -> publier (audio+vidéo, archivage '
    'automatique RG-XIII-02) -> catalogue médiathèque -> favoris et commentaire (RG-XIII-03/04) -> '
    'favoris médiathèque du fidèle',
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

      await tester.pumpWidget(EcclesiasApp(database: database, authGateway: AuthGatewayMemoire.connecte()));
      await tester.pumpAndSettle();

      final navOrganisation =
          find.descendant(of: find.byType(GridView), matching: find.text('Organisation'));
      final navFideles = find.descendant(of: find.byType(GridView), matching: find.text('Fidèles'));
      final navMediatheque =
          find.descendant(of: find.byType(GridView), matching: find.text('Catalogue médiathèque'));

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

      // Crée un fidèle.
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
      // Favoris et commentaires tracent une personne du registre :
      // l'administrateur d'amorçage lie d'abord son compte à sa fiche.
      await lierMonCompteALaFiche(tester, 'Jean Doe');
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Va au nœud, crée un culte avec thème.
      await tester.tap(navOrganisation);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Global Service Groupe'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Cultes'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Cultes'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Type de culte (ex. Culte dominical)'),
        'culte_dominical',
      );
      await tester.enterText(find.widgetWithText(TextField, 'Thème (optionnel)'), 'Culte de test');

      await tester.tap(find.text('Date et heure'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
      await tester.pumpAndSettle();

      // Ouvre le culte créé, publie avec un lien audio et un lien vidéo :
      // archivage automatique dans la médiathèque (RG-XII-03/RG-XIII-02).
      await tester.tap(find.text('Culte de test'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Lien audio'), 'https://exemple.org/audio.mp3');
      await tester.enterText(find.widgetWithText(TextField, 'Lien vidéo'), 'https://exemple.org/video.mp4');
      // `dragUntilVisible` s'appuie sur des drags incrémentaux et peut
      // laisser le bouton hors-cadre après la saisie des deux champs liens
      // (ListView non `.builder`, tous les enfants déjà construits) :
      // `ensureVisible` scrolle directement vers le RenderObject de la cible.
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Publier'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Publier'));
      await tester.pumpAndSettle();

      // Retourne à l'accueil (fiche de culte -> liste -> fiche de nœud ->
      // liste d'organisation -> accueil : 4 niveaux, comme à l'aller).
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Catalogue médiathèque : les deux médias archivés (audio + vidéo)
      // apparaissent, tous deux sous le même thème/titre (RG-XIII-02). Dans
      // chaque tuile, le titre ET le sous-titre (thème) affichent ce même
      // libellé, d'où 4 occurrences pour 2 contenus.
      // La tuile est loin dans la grille de modules de l'accueil (ajoutée en
      // fin de liste) : `ensureVisible` la fait défiler dans le viewport
      // avant le tap.
      await tester.ensureVisible(navMediatheque);
      await tester.pumpAndSettle();
      await tester.tap(navMediatheque);
      await tester.pumpAndSettle();
      expect(find.text('Culte de test'), findsNWidgets(4));

      // Ouvre la fiche du premier contenu.
      await tester.tap(find.text('Culte de test').first);
      await tester.pumpAndSettle();
      expect(find.text('Aucun commentaire pour le moment.'), findsOneWidget);

      // Ajoute aux favoris (au nom de la fiche liée à la session).
      await tester.tap(find.widgetWithText(OutlinedButton, 'Ajouter aux favoris'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(OutlinedButton, 'Retirer des favoris'), findsOneWidget);

      // Dépose un commentaire (modération a posteriori par défaut : publié
      // immédiatement, RG-XIII-03).
      await tester.enterText(find.widgetWithText(TextField, 'Votre commentaire'), 'Très édifiant, merci !');
      await tester.pumpAndSettle();
      // Le bouton « Publier » du commentaire est au-delà de la fenêtre de
      // rendu paresseux initiale de la sliver list (RenderSliverList ne
      // monte que viewport + cacheExtent) : `ensureVisible` exige un
      // élément déjà monté, alors que `dragUntilVisible` fait défiler par
      // petits pas, ce qui force le montage progressif des éléments
      // suivants — seule approche qui fonctionne ici (même remarque que
      // pour les boutons « Cultes »/« Comptabilité » de la fiche de nœud).
      await tester.dragUntilVisible(
        find.widgetWithText(FilledButton, 'Publier'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Publier'));
      await tester.pumpAndSettle();
      expect(find.text('Très édifiant, merci !'), findsOneWidget);
      expect(find.text('En attente de modération'), findsNothing);

      // Retourne à l'accueil, va sur la fiche du fidèle, vérifie ses favoris
      // médiathèque.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // La grille de modules est restée scrollée à la position atteinte
      // pour « Catalogue médiathèque » (ensureVisible) : remonter avant de
      // taper sur « Fidèles ».
      await tester.ensureVisible(navFideles);
      await tester.pumpAndSettle();
      await tester.tap(navFideles);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jean Doe'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(OutlinedButton, 'Favoris médiathèque'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.tap(find.widgetWithText(OutlinedButton, 'Favoris médiathèque'));
      await tester.pumpAndSettle();
      // Un seul favori, mais titre et thème affichent le même libellé dans
      // la tuile (même remarque que pour le catalogue) : 2 occurrences.
      expect(find.text('Culte de test'), findsNWidgets(2));

      await database.close();
    },
  );
}
