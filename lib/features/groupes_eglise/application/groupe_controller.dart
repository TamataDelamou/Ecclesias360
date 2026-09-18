import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/groupe_repository.dart';
import '../domain/models/appartenance_groupe.dart';
import '../domain/models/groupe_eglise.dart';

/// Contrôleur du Module VI, exposé aux écrans (pattern `provider`).
class GroupeController extends ChangeNotifier {
  GroupeController(this._repository) {
    _subscription = _repository.watchGroupes().listen(_onGroupesChanged);
  }

  final GroupeRepository _repository;
  late final StreamSubscription<List<GroupeEglise>> _subscription;

  List<GroupeEglise> _groupes = [];
  bool _enCours = false;
  String? _erreur;

  List<GroupeEglise> get groupes => List.unmodifiable(_groupes);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  void _onGroupesChanged(List<GroupeEglise> groupes) {
    _groupes = groupes;
    notifyListeners();
  }

  GroupeEglise? findById(String id) {
    for (final groupe in _groupes) {
      if (groupe.id == id) return groupe;
    }
    return null;
  }

  Stream<List<AppartenanceGroupe>> watchAppartenances(String fideleId) =>
      _repository.watchAppartenances(fideleId);

  Stream<List<AppartenanceGroupe>> watchMembres(String groupeId) => _repository.watchMembres(groupeId);

  Future<bool> recalculerAppartenancesAuto(String groupeId) =>
      _executer(() => _repository.recalculerAppartenancesAuto(groupeId));

  Future<bool> affecterManuellement({
    required String fideleId,
    required String groupeId,
    String? motifDerogation,
  }) => _executer(
        () => _repository.affecterManuellement(
          fideleId: fideleId,
          groupeId: groupeId,
          motifDerogation: motifDerogation,
        ),
      );

  Future<bool> retirerAppartenance(String id) => _executer(() => _repository.retirerAppartenance(id));

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
