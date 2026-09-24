// Téléversement des versions bibliques à la demande (Module XXIV) dans le
// bucket public `corpus-bibliques` (migration 0027), puis vérification par
// exécution réelle.
//
// Exécution (stack locale) :
//   SUPABASE_URL=http://127.0.0.1:54321 \
//   SUPABASE_SERVICE_ROLE_KEY=<clé de service> \
//   SUPABASE_ANON_KEY=<clé anon> SUPABASE_JWT_SECRET=<secret JWT> \
//   dart run tool/bible/televerser_corpus.dart --verifier
//
// Les clés ne sont jamais affichées (AGENTS.md §10). Les fichiers viennent de
// build/bible/ (tool/bible/construire_corpus.dart) et doivent correspondre au
// catalogue généré (taille, empreinte) : un fichier qui ne correspond pas
// n'est pas téléversé.
//
// --verifier : chaque fichier est relu par son URL publique **sans aucune
// authentification** (lecture sans compte) et comparé au catalogue ; un dépôt
// par un client anonyme puis authentifié doit être refusé, et le fichier
// rester intact.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:ecclesias_360/features/bible/data/catalogue_versions_initial.dart';
import 'package:http/http.dart' as http;

const bucket = 'corpus-bibliques';

String env(String nom, {String? defaut}) {
  final valeur = Platform.environment[nom] ?? defaut;
  if (valeur == null || valeur.isEmpty) {
    stderr.writeln('Variable d\'environnement manquante : $nom');
    exit(64);
  }
  return valeur;
}

/// Jeton HS256 d'un utilisateur authentifié fictif (vérification locale).
String jetonAuthentifie(String secret) {
  String b64(List<int> octets) => base64Url.encode(octets).replaceAll('=', '');
  final entete = b64(utf8.encode(jsonEncode({'alg': 'HS256', 'typ': 'JWT'})));
  final maintenant = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final charge = b64(utf8.encode(jsonEncode({
    'sub': '00000000-0000-4000-8000-0000000b1b1e',
    'role': 'authenticated',
    'aud': 'authenticated',
    'iat': maintenant,
    'exp': maintenant + 600,
  })));
  final signature = b64(Hmac(sha256, utf8.encode(secret)).convert(utf8.encode('$entete.$charge')).bytes);
  return '$entete.$charge.$signature';
}

Future<(int, String)> deposer(String base, String cle, String fichier, List<int> octets, {bool ecraser = true}) async {
  final reponse = await http.post(
    Uri.parse('$base/storage/v1/object/$bucket/$fichier'),
    headers: {
      'Authorization': 'Bearer $cle',
      'apikey': cle,
      'Content-Type': 'application/gzip',
      if (ecraser) 'x-upsert': 'true',
    },
    body: octets,
  );
  return (reponse.statusCode, reponse.body);
}

Future<void> main(List<String> arguments) async {
  final verifier = arguments.contains('--verifier');
  final base = env('SUPABASE_URL', defaut: 'http://127.0.0.1:54321');
  final service = env('SUPABASE_SERVICE_ROLE_KEY');
  var echecs = 0;
  void constater(bool ok, String message) {
    stdout.writeln('${ok ? 'OK  ' : 'ÉCHEC'} $message');
    if (!ok) echecs++;
  }

  for (final version in catalogueVersionsInitial.where((v) => !v.embarquee)) {
    final octets = await File('build/bible/${version.fichier}').readAsBytes();
    final empreinte = sha256.convert(octets).toString();
    if (octets.length != version.taille || empreinte != version.sha256) {
      stderr.writeln('${version.fichier} ne correspond pas au catalogue : relancer construire_corpus.dart.');
      exit(65);
    }
    final (statut, _) = await deposer(base, service, version.fichier, octets);
    constater(statut == 200, '${version.code} : téléversé avec la clé de service (HTTP $statut)');

    if (!verifier) continue;
    final publique = await http.get(Uri.parse('$base/storage/v1/object/public/$bucket/${version.fichier}'));
    constater(
      publique.statusCode == 200 &&
          publique.bodyBytes.length == version.taille &&
          sha256.convert(publique.bodyBytes).toString() == version.sha256,
      '${version.code} : lu sans compte par l\'URL publique, taille et empreinte du catalogue',
    );

    final factice = utf8.encode('corpus falsifié');
    // Un refus doit venir de la RLS, jamais d'un jeton rejeté pour une autre
    // raison : le stockage renvoie 400 dans les deux cas.
    bool parRls((int, String) r) => r.$1 >= 400 && r.$2.contains('row-level security');
    final anon = await deposer(base, env('SUPABASE_ANON_KEY'), version.fichier, factice);
    constater(parRls(anon), '${version.code} : dépôt anonyme refusé par la RLS (HTTP ${anon.$1})');
    final authentifie = await deposer(base, jetonAuthentifie(env('SUPABASE_JWT_SECRET')), version.fichier, factice);
    constater(parRls(authentifie), '${version.code} : dépôt authentifié refusé par la RLS (HTTP ${authentifie.$1})');
    final nouveau = await deposer(base, env('SUPABASE_ANON_KEY'), 'intrus.db.gz', factice, ecraser: false);
    constater(parRls(nouveau), 'nouveau fichier anonyme refusé par la RLS (HTTP ${nouveau.$1})');
    final relu = await http.get(Uri.parse('$base/storage/v1/object/public/$bucket/${version.fichier}'));
    constater(sha256.convert(relu.bodyBytes).toString() == version.sha256, '${version.code} : fichier intact après ces tentatives');
  }

  if (echecs > 0) {
    stderr.writeln('$echecs vérification(s) en échec.');
    exit(1);
  }
  stdout.writeln(verifier ? 'OK — bucket corpus-bibliques vérifié par exécution réelle' : 'Téléversement terminé');
}
