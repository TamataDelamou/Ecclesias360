import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../data/journal_parametres_repository.dart';
import '../data/zone_geographique_repository.dart';
import '../domain/models/entree_journal_parametres.dart';
import '../domain/models/zone_geographique.dart';

/// Contrôleur du référentiel ZoneGeographique (Module XXIII).
class ZoneGeographiqueController extends ChangeNotifier {
  ZoneGeographiqueController(this._repository, this._journal) {
    _subscription = _repository.watchAll().listen(_onZonesChanged);
  }

  final ZoneGeographiqueRepository _repository;
  final JournalParametresRepository _journal;
  late final StreamSubscription<List<ZoneGeographique>> _subscription;

  List<ZoneGeographique> _zones = [];
  bool _enCours = false;
  String? _erreur;

  List<ZoneGeographique> get zones => List.unmodifiable(_zones);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  ZoneGeographique? findById(String id) {
    for (final zone in _zones) {
      if (zone.id == id) return zone;
    }
    return null;
  }

  void _onZonesChanged(List<ZoneGeographique> zones) {
    _zones = zones;
    notifyListeners();
  }

  Future<bool> creer({required String libelle, String? parentId, required Acteur acteur}) =>
      _executer(() => _repository.creer(libelle: libelle, parentId: parentId, acteur: acteur));

  Future<bool> desactiver(String id, {required Acteur acteur}) =>
      _executer(() => _repository.desactiver(id, acteur: acteur));

  Future<bool> supprimer(String id, {required Acteur acteur}) =>
      _executer(() => _repository.supprimer(id, acteur: acteur));

  /// RG-XXIII-06 — journal des modifications (lecture seule).
  Stream<List<EntreeJournalParametres>> watchJournal() => _journal.watchJournal();

  Future<bool> _executer(Future<void> Function() action) async {
    _enCours = true;
    _erreur = null;
    notifyListeners();
    try {
      await action();
      _enCours = false;
      notifyListeners();
      return true;
    } on AppError catch (error) {
      _enCours = false;
      _erreur = error.message;
      notifyListeners();
      return false;
    } on ArgumentError catch (error) {
      _enCours = false;
      _erreur = error.message?.toString() ?? 'Requête invalide.';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
