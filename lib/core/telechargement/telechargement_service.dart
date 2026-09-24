import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../error/app_error.dart';

/// Service générique de téléchargement d'assets distants (Module XXIV :
/// versions bibliques à la demande ; mutualisé plus tard avec l'audio).
///
/// Le fichier n'est rendu que s'il a **exactement** la taille et l'empreinte
/// SHA-256 attendues : un fichier tronqué, corrompu ou substitué est rejeté
/// (`AppError.telechargementInvalide`), jamais installé. Une erreur réseau
/// est retentée jusqu'à [tentatives] fois ; une empreinte fausse ne l'est
/// pas (le même serveur renverrait le même fichier).
class TelechargementService {
  TelechargementService(this._client, {this.tentatives = 3, this.delaiEntreTentatives = const Duration(seconds: 2)});

  final http.Client _client;
  final int tentatives;
  final Duration delaiEntreTentatives;

  /// Télécharge [url] vers [cible] ; [onProgression] reçoit une fraction
  /// 0..1. Écrit d'abord un fichier temporaire, renommé seulement après
  /// vérification.
  Future<void> telecharger({
    required Uri url,
    required File cible,
    required int tailleAttendue,
    required String sha256Attendu,
    void Function(double progression)? onProgression,
  }) async {
    for (var essai = 1;; essai++) {
      try {
        await _essayer(url, cible, tailleAttendue, sha256Attendu, onProgression);
        return;
      } on AppError {
        rethrow;
      } on Object {
        if (essai >= tentatives) throw AppError.telechargementEchoue();
        await Future<void>.delayed(delaiEntreTentatives);
      }
    }
  }

  Future<void> _essayer(
    Uri url,
    File cible,
    int tailleAttendue,
    String sha256Attendu,
    void Function(double progression)? onProgression,
  ) async {
    final reponse = await _client.send(http.Request('GET', url));
    if (reponse.statusCode != 200) {
      await reponse.stream.drain<void>();
      throw HttpException('HTTP ${reponse.statusCode}', uri: url);
    }
    final temporaire = File('${cible.path}.partiel');
    await temporaire.parent.create(recursive: true);
    final sortie = temporaire.openWrite();
    final octets = <int>[];
    try {
      await for (final bloc in reponse.stream) {
        octets.addAll(bloc);
        sortie.add(bloc);
        if (octets.length > tailleAttendue) break;
        onProgression?.call(octets.length / tailleAttendue);
      }
    } finally {
      await sortie.close();
    }
    if (octets.length != tailleAttendue || sha256.convert(octets).toString() != sha256Attendu) {
      await temporaire.delete();
      throw AppError.telechargementInvalide();
    }
    await temporaire.rename(cible.path);
  }
}
