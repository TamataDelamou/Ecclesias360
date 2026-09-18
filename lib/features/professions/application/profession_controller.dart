import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/profession_repository.dart';
import '../domain/models/profession.dart';
import '../domain/models/profession_fidele.dart';
import '../domain/models/sollicitation.dart';

/// Contrôleur du Module V, exposé aux écrans (pattern `provider`).
class ProfessionController extends ChangeNotifier {
  ProfessionController(this._repository) {
    _subscription = _repository.watchProfessions().listen(_onProfessionsChanged);
  }

  final ProfessionRepository _repository;
  late final StreamSubscription<List<Profession>> _subscription;

  List<Profession> _professions = [];
  bool _enCours = false;
  String? _erreur;

  List<Profession> get professions => List.unmodifiable(_professions);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  void _onProfessionsChanged(List<Profession> professions) {
    _professions = professions;
    notifyListeners();
  }

  Profession? findById(String id) {
    for (final profession in _professions) {
      if (profession.id == id) return profession;
    }
    return null;
  }

  Stream<List<ProfessionFidele>> watchDeclarations(String fideleId) =>
      _repository.watchDeclarations(fideleId);

  Stream<List<ProfessionFidele>> watchDeclarationsParProfession(String professionId) =>
      _repository.watchDeclarationsParProfession(professionId);

  Stream<List<Sollicitation>> watchSollicitations(String fideleId) =>
      _repository.watchSollicitations(fideleId);

  Future<bool> creerProfession({
    required String code,
    required String categorie,
    required String libelle,
  }) => _executer(
        () => _repository.creerProfession(code: code, categorie: categorie, libelle: libelle),
      );

  Future<bool> declarerProfession({
    required String fideleId,
    required String professionId,
    int? anneesExperience,
  }) => _executer(
        () => _repository.declarerProfession(
          fideleId: fideleId,
          professionId: professionId,
          anneesExperience: anneesExperience,
        ),
      );

  Future<bool> verifierDeclaration(String id) => _executer(() => _repository.verifierDeclaration(id));

  Future<bool> solliciterGroupe({required String professionId, required String objet}) =>
      _executer(() => _repository.solliciterGroupe(professionId: professionId, objet: objet));

  Future<bool> repondreSollicitation(String id, String reponse) =>
      _executer(() => _repository.repondreSollicitation(id, reponse));

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
