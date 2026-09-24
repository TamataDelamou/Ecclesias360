import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/bible_repository.dart';
import '../data/local/bible_corpus_database.dart';
import '../domain/models/livre_biblique.dart';
import '../domain/models/version_biblique.dart';
import '../domain/rules/bible_reference_rules.dart';
import '../domain/rules/verset_du_jour_rules.dart';

/// Contrôleur du Module XXIV, instancié à la racine de l'application : la
/// lecture est accessible sans compte (RG-SEC-06bis amendé), il ne dépend
/// donc jamais de la session.
class BibleController extends ChangeNotifier {
  BibleController(this._repository);

  final BibleRepository _repository;

  List<VersionBiblique> _versions = const [];
  final Set<String> _disponibles = {};
  VersionBiblique? _version;
  BibleCorpusDatabase? _corpus;
  List<LivreBiblique> _livres = const [];
  ReferenceBiblique? _reference;
  List<VersetBiblique> _versets = const [];
  final Map<String, double> _progressions = {};
  bool _pret = false;
  Future<void>? _initialisation;
  String? _erreur;

  bool get pret => _pret;
  String? get erreur => _erreur;
  List<VersionBiblique> get versions => _versions;
  VersionBiblique? get version => _version;
  List<LivreBiblique> get livres => _livres;
  ReferenceBiblique? get reference => _reference;
  List<VersetBiblique> get versets => _versets;

  bool estDisponible(VersionBiblique version) => _disponibles.contains(version.code);

  /// Progression 0..1 d'un téléchargement en cours, `null` sinon.
  double? progression(String code) => _progressions[code];

  LivreBiblique? get livreCourant {
    final reference = _reference;
    if (reference == null) return null;
    for (final livre in _livres) {
      if (livre.bookId == reference.bookId) return livre;
    }
    return null;
  }

  /// Première ouverture (une seule fois) : version préférée si elle est
  /// disponible, sinon la version par défaut embarquée ; première page du
  /// premier livre, ou [reference] si elle est donnée.
  Future<void> initialiser({ReferenceBiblique? reference}) {
    return _initialisation ??= _initialiser().then((_) async {
      if (reference != null) await allerA(reference);
    });
  }

  Future<void> _initialiser() async {
    try {
      _versions = await _repository.versions();
      for (final v in _versions) {
        if (await _repository.estDisponible(v)) _disponibles.add(v.code);
      }
      final preferee = await _repository.versionPreferee();
      final version = _versions.firstWhere(
        (v) => v.code == preferee && _disponibles.contains(v.code),
        orElse: () => _versions.firstWhere((v) => v.embarquee),
      );
      await _ouvrirVersion(version, null);
      _pret = true;
    } on Object catch (e) {
      _erreur = e is AppError ? e.message : e.toString();
    }
    notifyListeners();
  }

  Future<void> _ouvrirVersion(VersionBiblique version, ReferenceBiblique? reference) async {
    final corpus = await _repository.ouvrir(version);
    final livres = await corpus.lireLivres();
    _version = version;
    _corpus = corpus;
    _livres = livres;
    final cible = reference == null
        ? ReferenceBiblique(bookId: livres.first.bookId, chapitre: 1)
        : BibleReferenceRules.adapterAVersion(reference, livres);
    await _charger(cible);
  }

  Future<void> _charger(ReferenceBiblique reference) async {
    _versets = await _corpus!.chapitre(reference.bookId, reference.chapitre);
    _reference = reference;
  }

  Future<void> allerA(ReferenceBiblique reference) async {
    if (_corpus == null) return;
    await _charger(BibleReferenceRules.adapterAVersion(reference, _livres));
    notifyListeners();
  }

  Future<void> chapitreSuivant() async {
    final suivant = _reference == null ? null : BibleReferenceRules.chapitreSuivant(_reference!, _livres);
    if (suivant != null) await allerA(suivant);
  }

  Future<void> chapitrePrecedent() async {
    final precedent = _reference == null ? null : BibleReferenceRules.chapitrePrecedent(_reference!, _livres);
    if (precedent != null) await allerA(precedent);
  }

  /// Change de version en gardant le passage (s'il existe dans la version
  /// cible). La version doit être disponible (voir [installer]).
  Future<void> changerVersion(VersionBiblique version) async {
    if (!estDisponible(version)) return;
    await _ouvrirVersion(version, _reference);
    await _repository.definirVersionPreferee(version.code);
    notifyListeners();
  }

  /// Écran 11 du Cahier : télécharge une version à la demande. `false` et
  /// [erreur] renseignée en cas d'échec (fichier invalide, réseau).
  Future<bool> installer(VersionBiblique version) async {
    _erreur = null;
    _progressions[version.code] = 0;
    notifyListeners();
    try {
      await _repository.installer(version, onProgression: (p) {
        _progressions[version.code] = p;
        notifyListeners();
      });
      _disponibles.add(version.code);
      return true;
    } on AppError catch (e) {
      _erreur = e.message;
      return false;
    } finally {
      _progressions.remove(version.code);
      notifyListeners();
    }
  }

  /// RG-XXIV-05 — recherche locale dans la version courante.
  Future<List<VersetBiblique>> rechercher(String saisie) async => _corpus?.rechercher(saisie) ?? const [];

  /// Verset du jour, lu dans la version courante (rotation seule pour
  /// l'instant, voir `VersetDuJourRules`).
  Future<VersetBiblique?> versetDuJour(DateTime date) async {
    final corpus = _corpus;
    if (corpus == null) return null;
    final (reference, _) = VersetDuJourRules.choisir(date: date, rotation: _repository.rotationVersetsDuJour);
    return corpus.verset(reference);
  }

  String nomDuLivre(int bookId) {
    for (final livre in _livres) {
      if (livre.bookId == bookId) return livre.nom;
    }
    return '$bookId';
  }
}
