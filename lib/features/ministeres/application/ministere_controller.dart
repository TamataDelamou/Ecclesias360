import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../../../core/theme/app_defaults.dart';
import '../data/ministere_repository.dart';
import '../domain/models/activite_ministere.dart';
import '../domain/models/affectation_ministere.dart';
import '../domain/models/mandat_responsable.dart';
import '../domain/models/ministere.dart';
import '../domain/models/role_affectation.dart';
import '../domain/models/type_ministere.dart';
import '../domain/rules/ministere_rules.dart';

/// Contrôleur du Module III, exposé aux écrans (pattern `provider`).
class MinistereController extends ChangeNotifier {
  MinistereController(this._repository) {
    _ministeresSubscription = _repository.watchMinisteres().listen(_onMinisteresChanged);
    _typesSubscription = _repository.watchTypes().listen(_onTypesChanged);
  }

  final MinistereRepository _repository;
  late final StreamSubscription<List<Ministere>> _ministeresSubscription;
  late final StreamSubscription<List<TypeMinistere>> _typesSubscription;

  List<Ministere> _ministeres = [];
  List<TypeMinistere> _types = [];
  bool _enCours = false;
  String? _erreur;

  List<Ministere> get ministeres => List.unmodifiable(_ministeres);
  List<TypeMinistere> get types => List.unmodifiable(_types);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  void _onMinisteresChanged(List<Ministere> ministeres) {
    _ministeres = ministeres;
    notifyListeners();
  }

  void _onTypesChanged(List<TypeMinistere> types) {
    _types = types;
    notifyListeners();
  }

  Ministere? findById(String id) {
    for (final ministere in _ministeres) {
      if (ministere.id == id) return ministere;
    }
    return null;
  }

  TypeMinistere? findTypeById(String id) {
    for (final type in _types) {
      if (type.id == id) return type;
    }
    return null;
  }

  List<Ministere> ministeresDuNoeud(String noeudId) =>
      _ministeres.where((m) => m.noeudId == noeudId).toList(growable: false);

  /// RG-III-02 — mandats ouverts arrivant à échéance, tous ministères
  /// confondus (écran 9).
  Future<List<MandatResponsable>> mandatsArrivantAEcheance({
    Duration horizon = const Duration(days: AppDefaults.mandatEcheanceHorizonJours),
  }) async {
    final ouverts = await _repository.mandatsOuverts();
    return MinistereRules.mandatsArrivantAEcheance(ouverts, maintenant: DateTime.now(), horizon: horizon);
  }

  Stream<List<AffectationMinistere>> watchAffectations(String ministereId) =>
      _repository.watchAffectations(ministereId);

  Stream<List<MandatResponsable>> watchMandats(String ministereId) => _repository.watchMandats(ministereId);

  Stream<List<ActiviteMinistere>> watchActivites(String ministereId) => _repository.watchActivites(ministereId);

  Future<bool> creerMinistere({
    required String noeudId,
    required String typeMinistereId,
    required String nom,
  }) => _executer(
        () => _repository.creerMinistere(noeudId: noeudId, typeMinistereId: typeMinistereId, nom: nom),
      );

  Future<bool> archiverMinistere(String id) => _executer(() => _repository.archiverMinistere(id));

  Future<bool> affecter({
    required String ministereId,
    required String fideleId,
    required RoleAffectation role,
    DateTime? dateFinPrevue,
  }) => _executer(
        () => _repository.affecter(
          ministereId: ministereId,
          fideleId: fideleId,
          role: role,
          dateFinPrevue: dateFinPrevue,
        ),
      );

  Future<bool> retirerAffectation(String id) => _executer(() => _repository.retirerAffectation(id));

  Future<bool> ajouterActivite({
    required String ministereId,
    required TypeActiviteMinistere type,
    required String description,
    String? auteurFideleId,
  }) => _executer(
        () => _repository.ajouterActivite(
          ministereId: ministereId,
          type: type,
          description: description,
          auteurFideleId: auteurFideleId,
        ),
      );

  Future<bool> creerTypePersonnalise({required String libelle, required String code}) =>
      _executer(() => _repository.creerTypePersonnalise(libelle: libelle, code: code));

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
    _ministeresSubscription.cancel();
    _typesSubscription.cancel();
    super.dispose();
  }
}
