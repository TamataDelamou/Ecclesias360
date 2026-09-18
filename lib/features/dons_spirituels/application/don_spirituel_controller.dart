import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/don_spirituel_repository.dart';
import '../domain/models/don_fidele.dart';
import '../domain/models/don_ministere_compatible.dart';
import '../domain/models/don_spirituel.dart';
import '../domain/models/niveau_maturite.dart';

/// Contrôleur du Module IV, exposé aux écrans (pattern `provider`).
class DonSpirituelController extends ChangeNotifier {
  DonSpirituelController(this._repository) {
    _subscription = _repository.watchDons().listen(_onDonsChanged);
  }

  final DonSpirituelRepository _repository;
  late final StreamSubscription<List<DonSpirituel>> _subscription;

  List<DonSpirituel> _dons = [];
  bool _enCours = false;
  String? _erreur;

  List<DonSpirituel> get dons => List.unmodifiable(_dons);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  void _onDonsChanged(List<DonSpirituel> dons) {
    _dons = dons;
    notifyListeners();
  }

  DonSpirituel? findById(String id) {
    for (final don in _dons) {
      if (don.id == id) return don;
    }
    return null;
  }

  Stream<List<DonFidele>> watchEvaluations(String fideleId) => _repository.watchEvaluations(fideleId);

  /// RG-IV-... statistiques de répartition (écran 6) — l'appelant filtre
  /// par nœud via les fidèles concernés.
  Stream<List<DonFidele>> watchToutesEvaluations() => _repository.watchToutesEvaluations();

  Stream<List<DonMinistereCompatible>> watchCorrespondances(String donId) =>
      _repository.watchCorrespondances(donId);

  Future<bool> evaluer({
    required String fideleId,
    required String donId,
    required NiveauMaturite niveauMaturite,
    required String responsableSuiviId,
    String? observations,
  }) => _executer(
        () => _repository.evaluer(
          fideleId: fideleId,
          donId: donId,
          niveauMaturite: niveauMaturite,
          responsableSuiviId: responsableSuiviId,
          observations: observations,
        ),
      );

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
