import 'dart:io';

import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/app_config.dart';
import '../../../core/error/app_error.dart';
import '../../../core/telechargement/telechargement_service.dart';
import '../../../core/theme/app_defaults.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/livre_biblique.dart';
import '../domain/models/version_biblique.dart';
import 'catalogue_versions_initial.dart';
import 'local/bible_corpus_database.dart';

/// Dépôt du Module XXIV (RG-XXIV-01) : catalogue des versions (référentiel
/// `versions_bibliques` de la base principale), corpus par version
/// (`BibleCorpusDatabase`, fichier `<code>.db` dans [dossier]), installation
/// et préférence de version.
///
/// - Version **embarquée** (LSG 1910) : décompressée depuis l'asset au premier
///   usage, et de nouveau si le marqueur `bible_corpus_version` (format du
///   corpus) ou la taille de l'asset change — mécanisme voulu pour absorber
///   une nouvelle livraison du corpus.
/// - Version **à la demande** (Darby, Crampon) : téléchargée depuis le bucket
///   public `corpus-bibliques` ([baseStockage]), acceptée seulement à la
///   taille et à l'empreinte du catalogue, puis lisible hors connexion.
///
/// Aucune donnée personnelle ici : la lecture ne demande pas de compte
/// (RG-SEC-06bis amendé).
class BibleRepository {
  BibleRepository({
    required AppDatabase database,
    required this._dossier,
    required this._chargerAsset,
    required this._telechargement,
    required this._baseStockage,
    Future<SharedPreferences> Function()? preferences,
  })  : _db = database,
        _preferences = preferences ?? SharedPreferences.getInstance;

  /// Dépôt de l'application réelle : corpus dans le dossier de support de
  /// l'application, asset lu dans le bundle, bucket public du projet
  /// Supabase configuré (aucun téléchargement possible sans configuration).
  factory BibleRepository.pourApplication(AppDatabase database) {
    String? base;
    try {
      base = AppConfig.instance.supabaseUrl;
    } on StateError {
      base = null;
    }
    return BibleRepository(
      database: database,
      dossier: () async => Directory('${(await getApplicationSupportDirectory()).path}/bible'),
      chargerAsset: (asset) async => (await rootBundle.load(asset)).buffer.asUint8List(),
      telechargement: TelechargementService(http.Client()),
      baseStockage: base,
    );
  }

  static const cleVersionPreferee = 'bible_translation';
  static const cleFormatCorpus = 'bible_corpus_version';
  static const cleTailleCorpusEmbarque = 'bible_corpus_taille';
  static String cleVersionInstallee(String code) => 'bible_version_installee_$code';

  final AppDatabase _db;
  final Future<Directory> Function() _dossier;
  final Future<List<int>> Function(String asset) _chargerAsset;
  final TelechargementService _telechargement;
  final String? _baseStockage;
  final Future<SharedPreferences> Function() _preferences;
  final Map<String, Future<BibleCorpusDatabase>> _ouvertes = {};

  Future<List<VersionBiblique>> versions() async {
    final lignes = await (_db.select(_db.versionsBibliques)..orderBy([(t) => OrderingTerm.asc(t.nom)])).get();
    return [
      for (final l in lignes)
        VersionBiblique(
          code: l.code,
          nom: l.nom,
          langue: l.langue,
          edition: l.edition,
          licence: l.licence,
          source: l.source,
          embarquee: l.embarquee,
          fichier: l.fichier,
          taille: l.taille,
          sha256: l.sha256,
          nbLivres: l.nbLivres,
          nbVersets: l.nbVersets,
        ),
    ];
  }

  Future<File> _fichier(VersionBiblique version) async => File('${(await _dossier()).path}/${version.code}.db');

  /// Une version embarquée est toujours disponible ; une version à la
  /// demande l'est si son fichier est présent **et** correspond à
  /// l'empreinte actuelle du catalogue.
  Future<bool> estDisponible(VersionBiblique version) async {
    if (version.embarquee) return true;
    final prefs = await _preferences();
    return prefs.getString(cleVersionInstallee(version.code)) == version.sha256 && (await _fichier(version)).existsSync();
  }

  Future<BibleCorpusDatabase> ouvrir(VersionBiblique version) =>
      _ouvertes.putIfAbsent(version.code, () => _ouvrir(version)).catchError((Object e) {
        _ouvertes.remove(version.code);
        throw e;
      });

  Future<BibleCorpusDatabase> _ouvrir(VersionBiblique version) async {
    final fichier = await _fichier(version);
    if (version.embarquee) {
      await _decompresserSiNecessaire(version, fichier);
    } else if (!await estDisponible(version)) {
      throw AppError.versionBibliqueIndisponible();
    }
    return BibleCorpusDatabase(fichier);
  }

  Future<void> _decompresserSiNecessaire(VersionBiblique version, File fichier) async {
    final prefs = await _preferences();
    final aJour = prefs.getInt(cleFormatCorpus) == formatCorpusBiblique &&
        prefs.getInt(cleTailleCorpusEmbarque) == version.taille &&
        fichier.existsSync();
    if (aJour) return;
    final compresse = await _chargerAsset('assets/bible/${version.fichier}');
    await fichier.parent.create(recursive: true);
    final temporaire = File('${fichier.path}.partiel');
    await temporaire.writeAsBytes(gzip.decode(compresse), flush: true);
    await temporaire.rename(fichier.path);
    await prefs.setInt(cleFormatCorpus, formatCorpusBiblique);
    await prefs.setInt(cleTailleCorpusEmbarque, compresse.length);
  }

  /// Télécharge et installe une version à la demande (écran 11 du Cahier).
  Future<void> installer(VersionBiblique version, {void Function(double progression)? onProgression}) async {
    if (version.embarquee) return;
    final base = _baseStockage;
    if (base == null || base.isEmpty) throw AppError.telechargementEchoue();
    final fichier = await _fichier(version);
    final compresse = File('${fichier.path}.gz');
    await _telechargement.telecharger(
      url: Uri.parse('$base/storage/v1/object/public/corpus-bibliques/${version.fichier}'),
      cible: compresse,
      tailleAttendue: version.taille,
      sha256Attendu: version.sha256,
      onProgression: onProgression,
    );
    await (await _ouvertes.remove(version.code))?.close();
    final temporaire = File('${fichier.path}.partiel');
    await temporaire.writeAsBytes(gzip.decode(await compresse.readAsBytes()), flush: true);
    await temporaire.rename(fichier.path);
    await compresse.delete();
    await (await _preferences()).setString(cleVersionInstallee(version.code), version.sha256);
  }

  Future<String> versionPreferee() async =>
      (await _preferences()).getString(cleVersionPreferee) ?? AppDefaults.bibleVersionParDefaut;

  Future<void> definirVersionPreferee(String code) async =>
      (await _preferences()).setString(cleVersionPreferee, code);

  /// Rotation du verset du jour (`AppDefaults`), en références stables.
  List<ReferenceBiblique> get rotationVersetsDuJour => [
        for (final (livre, chapitre, verset) in AppDefaults.bibleRotationVersetsDuJour)
          ReferenceBiblique(bookId: livre, chapitre: chapitre, verset: verset),
      ];

  Future<void> fermer() async {
    for (final ouverture in _ouvertes.values) {
      await (await ouverture).close();
    }
    _ouvertes.clear();
  }
}
