import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/telechargement/telechargement_service.dart';
import 'package:ecclesias_360/features/bible/data/bible_repository.dart';
import 'package:ecclesias_360/features/bible/data/catalogue_versions_initial.dart';
import 'package:ecclesias_360/features/bible/domain/models/livre_biblique.dart';
import 'package:ecclesias_360/features/bible/domain/models/version_biblique.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;

import '../../helpers/bible_pour_tests.dart';

/// Module XXIV (RG-XXIV-01/05) — corpus embarqué réel, catalogue,
/// décompression au premier usage, installation d'une version à la demande.
void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  VersionBiblique lsg() => catalogueVersionsInitial.firstWhere((v) => v.code == 'lsg1910');

  group('corpus embarqué LSG 1910 (asset réel)', () {
    late BibleRepository repository;

    setUp(() async => repository = await bibleDeTest(db));
    tearDown(() => repository.fermer());

    test('66 livres protocanoniques, 1189 chapitres, 31 170 versets, dans l\'ordre protestant', () async {
      final corpus = await repository.ouvrir(lsg());
      final livres = await corpus.lireLivres();
      expect(livres, hasLength(66));
      expect(livres.every((l) => !l.deuterocanonique && l.bookId == l.ordre), isTrue);
      expect(livres.fold<int>(0, (n, l) => n + l.nbChapitres), 1189);
      expect(lsg().nbVersets, 31170);
      expect(livres.first.nom, 'Genèse');
      expect(livres.last.nom, 'Apocalypse');
    });

    test('Jean 3:16 et Genèse 1:1', () async {
      final corpus = await repository.ouvrir(lsg());
      expect((await corpus.verset(const ReferenceBiblique(bookId: 43, chapitre: 3, verset: 16)))!.texte,
          startsWith('Car Dieu a tant aimé le monde'));
      expect((await corpus.chapitre(1, 1)).first.texte, 'Au commencement, Dieu créa les cieux et la terre.');
    });

    test('recherche locale insensible aux accents : « eternel berger » trouve Psaumes 23:1', () async {
      final corpus = await repository.ouvrir(lsg());
      final resultats = await corpus.rechercher('eternel berger');
      expect(resultats.any((v) => v.bookId == 19 && v.chapitre == 23 && v.verset == 1), isTrue);
      expect(await corpus.rechercher('x'), isEmpty);
    });

    test('chaque verset de la rotation du verset du jour existe dans la version embarquée', () async {
      final corpus = await repository.ouvrir(lsg());
      for (final reference in repository.rotationVersetsDuJour) {
        expect(await corpus.verset(reference), isNotNull, reason: '$reference absent');
      }
    });

    test('le corpus est ouvert en lecture seule', () async {
      final corpus = await repository.ouvrir(lsg());
      await expectLater(corpus.customStatement("UPDATE versets SET texte = 'x'"), throwsA(anything));
    });
  });

  test('le catalogue amorcé liste les trois versions ; seule la LSG 1910 est embarquée', () async {
    final repository = await bibleDeTest(db);
    final versions = await repository.versions();
    expect(versions.map((v) => v.code), containsAll(['lsg1910', 'darby', 'crampon']));
    expect(versions.where((v) => v.embarquee).map((v) => v.code), ['lsg1910']);
    expect(versions.firstWhere((v) => v.code == 'crampon').nbLivres, 73);
    expect(await repository.estDisponible(versions.firstWhere((v) => v.code == 'darby')), isFalse);
  });

  test('décompression au premier usage, puis de nouveau si la taille de l\'asset change', () async {
    final dossier = await Directory.systemTemp.createTemp('bible_decompression');
    var lectures = 0;
    SharedPreferences.setMockInitialValues({});
    BibleRepository nouveau() => BibleRepository(
          database: db,
          dossier: () async => dossier,
          chargerAsset: (chemin) async {
            lectures++;
            return File(chemin).readAsBytes();
          },
          telechargement: TelechargementService(MockClient((_) async => http.Response('', 404))),
          baseStockage: null,
        );

    final premier = nouveau();
    await premier.ouvrir(lsg());
    await premier.fermer();
    expect(lectures, 1);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt(BibleRepository.cleFormatCorpus), formatCorpusBiblique);

    final second = nouveau();
    await second.ouvrir(lsg());
    await second.fermer();
    expect(lectures, 1, reason: 'marqueurs à jour : rien à décompresser');

    await prefs.setInt(BibleRepository.cleTailleCorpusEmbarque, 1);
    final troisieme = nouveau();
    await troisieme.ouvrir(lsg());
    await troisieme.fermer();
    expect(lectures, 2, reason: 'taille différente : nouvelle décompression');
  });

  group('installation d\'une version à la demande (écran 11)', () {
    late List<int> compresse;
    late VersionBiblique version;

    setUp(() async {
      // Petit corpus au schéma réel, compressé comme par l'outil.
      final temporaire = File('${(await Directory.systemTemp.createTemp('bible_mini')).path}/mini.db');
      final brut = sqlite3.sqlite3.open(temporaire.path);
      brut.execute('''
        CREATE TABLE livres (book_id INTEGER PRIMARY KEY, nom TEXT NOT NULL, abreviation TEXT NOT NULL,
          ordre INTEGER NOT NULL, deuterocanonique INTEGER NOT NULL, nb_chapitres INTEGER NOT NULL);
        CREATE TABLE versets (id INTEGER PRIMARY KEY, book_id INTEGER NOT NULL, chapitre INTEGER NOT NULL,
          verset INTEGER NOT NULL, texte TEXT NOT NULL);
        CREATE VIRTUAL TABLE versets_fts USING fts5(texte, content='versets', content_rowid='id',
          tokenize='unicode61 remove_diacritics 2');
        INSERT INTO livres VALUES (67, 'Tobie', 'Tb', 1, 1, 1);
        INSERT INTO versets (book_id, chapitre, verset, texte) VALUES (67, 1, 1, 'Livre de Tobie.');
        INSERT INTO versets_fts (versets_fts) VALUES ('rebuild');
        PRAGMA user_version = 1;
      ''');
      brut.close();
      compresse = gzip.encode(await temporaire.readAsBytes());
      version = VersionBiblique(
        code: 'mini',
        nom: 'Mini',
        langue: 'fr',
        edition: 'test',
        licence: 'test',
        source: 'test',
        embarquee: false,
        fichier: 'mini.db.gz',
        taille: compresse.length,
        sha256: sha256.convert(compresse).toString(),
        nbLivres: 1,
        nbVersets: 1,
      );
    });

    test('fichier conforme : installé depuis le bucket public, puis lisible hors connexion', () async {
      Uri? demandee;
      final repository = await bibleDeTest(
        db,
        baseStockage: 'http://stockage.test',
        client: MockClient((requete) async {
          demandee = requete.url;
          return http.Response.bytes(compresse, 200);
        }),
      );
      await expectLater(repository.ouvrir(version), throwsA(isA<AppError>()));
      await repository.installer(version);
      expect(demandee.toString(), 'http://stockage.test/storage/v1/object/public/corpus-bibliques/mini.db.gz');
      expect(await repository.estDisponible(version), isTrue);
      final corpus = await repository.ouvrir(version);
      expect((await corpus.lireLivres()).single.nom, 'Tobie');
      await repository.fermer();
    });

    test('fichier altéré : rejeté, jamais installé', () async {
      final altere = [...compresse]..[10] ^= 0xFF;
      final repository = await bibleDeTest(
        db,
        baseStockage: 'http://stockage.test',
        client: MockClient((_) async => http.Response.bytes(altere, 200)),
      );
      await expectLater(
        repository.installer(version),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'telechargement_invalide')),
      );
      expect(await repository.estDisponible(version), isFalse);
    });

    test('sans stockage configuré : aucun téléchargement', () async {
      final repository = await bibleDeTest(db);
      await expectLater(
        repository.installer(version),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'telechargement_echoue')),
      );
    });
  });
}
