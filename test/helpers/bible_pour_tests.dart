import 'dart:io';

import 'package:ecclesias_360/core/telechargement/telechargement_service.dart';
import 'package:ecclesias_360/features/bible/data/bible_repository.dart';
import 'package:ecclesias_360/features/bible/data/catalogue_versions_initial.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Corpus LSG 1910 réel (asset du dépôt), décompressé une fois par appel
/// dans un dossier temporaire. À appeler **hors du temps simulé** des tests
/// d'écran (`tester.runAsync`) : l'écriture disque ne progresse pas en
/// temps simulé. Les marqueurs de décompression sont posés, pour que
/// l'application n'ait rien à décompresser pendant le test.
Future<BibleRepository> bibleDeTest(
  AppDatabase db, {
  http.Client? client,
  String? baseStockage,
}) async {
  final dossier = await Directory.systemTemp.createTemp('ecclesias_bible_test');
  final asset = await File('assets/bible/lsg1910.db.gz').readAsBytes();
  await File('${dossier.path}/lsg1910.db').writeAsBytes(gzip.decode(asset));
  SharedPreferences.setMockInitialValues({
    BibleRepository.cleFormatCorpus: formatCorpusBiblique,
    BibleRepository.cleTailleCorpusEmbarque: asset.length,
  });
  return BibleRepository(
    database: db,
    dossier: () async => dossier,
    chargerAsset: (chemin) async => File(chemin).readAsBytes(),
    telechargement: TelechargementService(
      client ?? MockClient((_) async => http.Response('indisponible', 503)),
      delaiEntreTentatives: Duration.zero,
    ),
    baseStockage: baseStockage,
  );
}
