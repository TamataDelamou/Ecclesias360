// RG-SEC-01 — vérification par exécution réelle : l'application complète,
// lancée sur un vrai appareil (Windows), se connecte à la stack Supabase
// locale (`supabase start`) exactement comme `main.dart` — configuration lue
// depuis `.env`, session dans flutter_secure_storage — et exerce le vrai
// `signInWithOtp` / `verifyOtp`. Le code e-mail est relevé dans Mailpit ; le
// SMS utilise un numéro de test de `supabase/config.toml` ([auth.sms.test_otp]).
//
// Exécution : supabase start, puis
//   flutter test integration_test/connexion_otp_reelle_test.dart -d windows
import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/core/config/app_config.dart';
import 'package:ecclesias_360/features/auth/data/remote/session_securisee_storage.dart';
import 'package:ecclesias_360/features/auth/data/remote/supabase_auth_gateway.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _mailpit = 'http://127.0.0.1:54324';

/// Numéro de test déclaré dans `[auth.sms.test_otp]` : code fixe, aucun envoi.
const _telephoneTest = '+224 620 00 00 01';
const _codeTelephoneTest = '123456';

Future<Map<String, dynamic>> _getJson(HttpClient client, String url) async {
  final requete = await client.getUrl(Uri.parse(url));
  final reponse = await requete.close();
  return jsonDecode(await reponse.transform(utf8.decoder).join()) as Map<String, dynamic>;
}

/// Relève dans Mailpit le code à 6 chiffres envoyé à [email].
Future<String> _codeRecu(String email) async {
  final client = HttpClient();
  try {
    for (var tentative = 0; tentative < 40; tentative++) {
      final recherche = await _getJson(client, '$_mailpit/api/v1/search?query=${Uri.encodeQueryComponent('to:"$email"')}');
      final messages = (recherche['messages'] as List<dynamic>?) ?? const [];
      if (messages.isNotEmpty) {
        final id = (messages.first as Map<String, dynamic>)['ID'] as String;
        final message = await _getJson(client, '$_mailpit/api/v1/message/$id');
        final code = RegExp(r'\b(\d{6})\b').firstMatch(message['Text'] as String? ?? message['HTML'] as String);
        if (code != null) return code.group(1)!;
      }
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    throw StateError('Aucun e-mail reçu dans Mailpit pour $email');
  } finally {
    client.close();
  }
}

/// Sur bureau, un second enterText sur un même champ ne l'atteint qu'après
/// un nouveau focus explicite (artefact du harnais, pas de l'application) :
/// le champ est donc focalisé puis relu.
Future<void> _saisir(WidgetTester tester, String cle, String texte) async {
  final champ = find.byKey(ValueKey(cle));
  await tester.tap(champ);
  await tester.pump();
  await tester.enterText(champ, texte);
  await tester.pump();
  final editable = tester.widget<EditableText>(find.descendant(of: champ, matching: find.byType(EditableText)));
  expect(editable.controller.text, texte);
}

/// Attend qu'un appel réseau réel aboutisse (pumpAndSettle ne l'attend pas).
Future<void> _attendre(WidgetTester tester, Finder cible) async {
  for (var i = 0; i < 100; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (cible.evaluate().isNotEmpty) return;
  }
  final textes = find.byType(Text).evaluate().map((e) => (e.widget as Text).data).whereType<String>().join(' | ');
  throw TestFailure("Introuvable après 10 s : $cible\nÀ l'écran : $textes");
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'connexion OTP réelle : code e-mail (Mailpit) -> mauvais code refusé -> administrateur '
    "d'amorçage -> miroir serveur -> déconnexion -> SMS (numéro de test) (RG-SEC-01)",
    (tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('fr');
      tester.platformDispatcher.localesTestValue = const [Locale('fr')];
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);

      // Même chargement que main.dart : un .env non embarqué laisserait
      // l'accès fermé (AuthGatewayNonConfigure).
      await AppConfig.load();
      final config = AppConfig.instance;
      expect(config.supabaseUrl, isNotEmpty, reason: '.env doit être lu depuis le bundle, comme dans main.dart');
      await Supabase.initialize(
        url: config.supabaseUrl,
        publishableKey: config.supabasePublishableKey,
        authOptions: const FlutterAuthClientOptions(localStorage: SessionSecuriseeStorage()),
      );
      final client = Supabase.instance.client;
      if (client.auth.currentSession != null) await client.auth.signOut();

      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      await tester.pumpWidget(EcclesiasApp(database: database, authGateway: SupabaseAuthGateway(client.auth)));
      await tester.pumpAndSettle();

      // Aucune session : la garde mène à l'écran de connexion.
      expect(find.text('Connexion'), findsOneWidget);

      // --- Branche e-mail : code réellement envoyé, relevé dans Mailpit ---
      final email = 'e2e-${DateTime.now().millisecondsSinceEpoch}@ecclesias.test';
      await tester.tap(find.text('E-mail'));
      await tester.pumpAndSettle();
      await _saisir(tester, 'champIdentifiant', email);
      await tester.tap(find.text('Code par e-mail'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Recevoir le code'));
      await _attendre(tester, find.byKey(const ValueKey('champCode')));
      await tester.pumpAndSettle();

      final code = await _codeRecu(email);

      // Un mauvais code est refusé par le serveur, avec un message métier.
      await _saisir(tester, 'champCode', code == '000000' ? '111111' : '000000');
      await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
      await _attendre(tester, find.text('Ce code est invalide ou a expiré. Demandez un nouveau code.'));

      await _saisir(tester, 'champCode', code);
      await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
      await _attendre(tester, find.byType(NavigationBar));
      await tester.pumpAndSettle();

      final compte = client.auth.currentUser;
      expect(compte?.email, email);

      // Base locale vide : premier compte = administrateur d'amorçage.
      await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Paramètres')));
      await tester.pumpAndSettle();
      expect(find.text('Connecté : $email'), findsOneWidget);
      expect(find.text('Administrateur'), findsOneWidget);

      // Miroir serveur (0018) : même décision, prise par le vrai auth.uid().
      final issueServeur = await client.rpc<String>('enregistrer_compte_courant');
      expect(issueServeur, anyOf('administrateur_amorcage', 'aucune_correspondance'));
      final roleServeur = await client.rpc<String>('role_courant');
      expect(roleServeur, issueServeur == 'administrateur_amorcage' ? 'administrateur' : 'utilisateur_simple');

      // Session réellement conservée dans le stockage sécurisé (RG-OFF).
      expect(await const SessionSecuriseeStorage().hasAccessToken(), isTrue);

      await tester.tap(find.text('Se déconnecter'));
      await _attendre(tester, find.text('Connexion'));
      expect(client.auth.currentSession, isNull);
      expect(await const SessionSecuriseeStorage().hasAccessToken(), isFalse);

      // --- Branche téléphone : vrai verifyOtp, numéro de test (aucun SMS) ---
      await _saisir(tester, 'champIdentifiant', '620000001');
      await tester.tap(find.text('Recevoir le code'));
      await tester.pumpAndSettle();
      // KER-ID-06 : numéro national refusé côté client, aucun appel serveur.
      expect(find.byKey(const ValueKey('champCode')), findsNothing);

      await _saisir(tester, 'champIdentifiant', _telephoneTest);
      await tester.tap(find.text('Recevoir le code'));
      await _attendre(tester, find.byKey(const ValueKey('champCode')));
      await tester.pumpAndSettle();
      await _saisir(tester, 'champCode', _codeTelephoneTest);
      await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
      await _attendre(tester, find.byType(NavigationBar));
      await tester.pumpAndSettle();
      expect(client.auth.currentUser?.phone, '224620000001');

      await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Paramètres')));
      await tester.pumpAndSettle();
      expect(find.text('Connecté : +224620000001'), findsOneWidget);

      await tester.tap(find.text('Se déconnecter'));
      await _attendre(tester, find.text('Connexion'));
    },
  );
}
