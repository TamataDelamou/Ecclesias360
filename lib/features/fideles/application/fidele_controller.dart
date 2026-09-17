import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/fidele_repository.dart';
import '../domain/models/fidele.dart';
import '../domain/models/historique_fidele.dart';
import '../domain/models/lien_familial.dart';
import '../domain/models/sexe.dart';
import '../domain/models/statut_civil.dart';
import '../domain/models/statut_spirituel.dart';
import '../domain/models/tuteur.dart';
import '../domain/models/type_lien.dart';

/// Contrôleur du Module II, exposé aux écrans (pattern `provider`).
class FideleController extends ChangeNotifier {
  FideleController(this._repository) {
    _subscription = _repository.watchAll().listen(_onFidelesChanged);
  }

  final FideleRepository _repository;
  late final StreamSubscription<List<Fidele>> _subscription;

  List<Fidele> _fideles = [];
  bool _enCours = false;
  String? _erreur;

  List<Fidele> get fideles => List.unmodifiable(_fideles);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  void _onFidelesChanged(List<Fidele> fideles) {
    _fideles = fideles;
    notifyListeners();
  }

  Fidele? findById(String id) {
    for (final fidele in _fideles) {
      if (fidele.id == id) return fidele;
    }
    return null;
  }

  List<Fidele> rechercher(String terme) {
    final normalise = terme.trim().toLowerCase();
    if (normalise.isEmpty) return List.unmodifiable(_fideles);
    return _fideles
        .where(
          (f) =>
              f.nom.toLowerCase().contains(normalise) || f.prenoms.toLowerCase().contains(normalise),
        )
        .toList(growable: false);
  }

  Stream<List<Tuteur>> watchTuteurs(String mineurId) => _repository.watchTuteurs(mineurId);

  Stream<List<LienFamilial>> watchLiensFamiliaux(String fideleId) =>
      _repository.watchLiensFamiliaux(fideleId);

  Stream<List<HistoriqueFidele>> watchHistorique(String fideleId) =>
      _repository.watchHistorique(fideleId);

  Future<bool> creerFidele({
    required String noeudId,
    required String nom,
    required String prenoms,
    required DateTime dateNaissance,
    required Sexe sexe,
    required StatutCivil statutCivil,
    String? egliseProvenance,
    String? telephone,
    String? email,
    String? adresse,
  }) => _executer(
        () => _repository.creerFidele(
          noeudId: noeudId,
          nom: nom,
          prenoms: prenoms,
          dateNaissance: dateNaissance,
          sexe: sexe,
          statutCivil: statutCivil,
          egliseProvenance: egliseProvenance,
          telephone: telephone,
          email: email,
          adresse: adresse,
        ),
      );

  Future<bool> modifierStatutSpirituel({required String fideleId, required StatutSpirituel cible}) =>
      _executer(() => _repository.modifierStatutSpirituel(fideleId: fideleId, cible: cible));

  Future<bool> modifierCoordonnees({
    required String fideleId,
    String? telephone,
    String? email,
    String? adresse,
  }) => _executer(
        () => _repository.modifierCoordonnees(
          fideleId: fideleId,
          telephone: telephone,
          email: email,
          adresse: adresse,
        ),
      );

  Future<bool> ajouterTuteur({
    required String mineurId,
    required String lien,
    String? tuteurFideleId,
    String? tuteurTiersNom,
    String? tuteurTiersTelephone,
  }) => _executer(
        () => _repository.ajouterTuteur(
          mineurId: mineurId,
          lien: lien,
          tuteurFideleId: tuteurFideleId,
          tuteurTiersNom: tuteurTiersNom,
          tuteurTiersTelephone: tuteurTiersTelephone,
        ),
      );

  Future<bool> ajouterLienFamilial({
    required String fideleId1,
    required String fideleId2,
    required TypeLien typeLien,
  }) => _executer(
        () => _repository.ajouterLienFamilial(
          fideleId1: fideleId1,
          fideleId2: fideleId2,
          typeLien: typeLien,
        ),
      );

  Future<bool> retirerLienFamilial(String id) => _executer(() => _repository.retirerLienFamilial(id));

  Future<bool> archiverFidele(String id) => _executer(() => _repository.archiverFidele(id));

  Future<bool> supprimerFidele(String id) => _executer(() => _repository.supprimerFidele(id));

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
