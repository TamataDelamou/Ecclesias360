import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/telechargement/telechargement_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Service générique de téléchargement : taille et empreinte exactes, sinon
/// rejet ; nouvelle tentative sur erreur réseau, jamais sur empreinte fausse.
void main() {
  final contenu = List<int>.generate(5000, (i) => i % 251);
  final empreinte = sha256.convert(contenu).toString();
  late Directory dossier;

  setUp(() async => dossier = await Directory.systemTemp.createTemp('telechargement'));

  Future<void> telecharger(http.Client client, {int? taille, String? sha, void Function(double)? progression}) =>
      TelechargementService(client, delaiEntreTentatives: Duration.zero).telecharger(
        url: Uri.parse('http://test/fichier'),
        cible: File('${dossier.path}/fichier'),
        tailleAttendue: taille ?? contenu.length,
        sha256Attendu: sha ?? empreinte,
        onProgression: progression,
      );

  test('conforme : écrit, progression jusqu\'à 1', () async {
    final progressions = <double>[];
    await telecharger(MockClient((_) async => http.Response.bytes(contenu, 200)), progression: progressions.add);
    expect(await File('${dossier.path}/fichier').readAsBytes(), contenu);
    expect(progressions.last, 1.0);
    expect(File('${dossier.path}/fichier.partiel').existsSync(), isFalse);
  });

  test('empreinte fausse : rejeté sans nouvelle tentative, rien n\'est écrit', () async {
    var appels = 0;
    await expectLater(
      telecharger(MockClient((_) async {
        appels++;
        return http.Response.bytes(contenu, 200);
      }), sha: '0' * 64),
      throwsA(isA<AppError>().having((e) => e.code, 'code', 'telechargement_invalide')),
    );
    expect(appels, 1);
    expect(dossier.listSync(), isEmpty);
  });

  test('fichier tronqué ou trop long : rejeté', () async {
    await expectLater(
      telecharger(MockClient((_) async => http.Response.bytes(contenu.sublist(0, 100), 200))),
      throwsA(isA<AppError>().having((e) => e.code, 'code', 'telechargement_invalide')),
    );
    await expectLater(
      telecharger(MockClient((_) async => http.Response.bytes([...contenu, 1], 200))),
      throwsA(isA<AppError>().having((e) => e.code, 'code', 'telechargement_invalide')),
    );
  });

  test('erreur réseau passagère : nouvelle tentative, puis succès', () async {
    var appels = 0;
    await telecharger(MockClient((_) async {
      appels++;
      return appels < 3 ? http.Response('indisponible', 503) : http.Response.bytes(contenu, 200);
    }));
    expect(appels, 3);
  });

  test('échec persistant : abandon après les tentatives prévues', () async {
    var appels = 0;
    await expectLater(
      telecharger(MockClient((_) async {
        appels++;
        return http.Response('indisponible', 503);
      })),
      throwsA(isA<AppError>().having((e) => e.code, 'code', 'telechargement_echoue')),
    );
    expect(appels, 3);
  });
}
