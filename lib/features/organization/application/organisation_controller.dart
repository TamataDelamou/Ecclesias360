import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/organisation_node_repository.dart';
import '../domain/models/categorie_confessionnelle.dart';
import '../domain/models/historique_rattachement.dart';
import '../domain/models/node_responsable.dart';
import '../domain/models/organisation_node.dart';
import '../domain/models/type_noeud.dart';

/// Contrôleur du Module I, exposé aux écrans (pattern `provider`).
class OrganisationController extends ChangeNotifier {
  OrganisationController(this._repository) {
    _subscription = _repository.watchAll().listen(_onNodesChanged);
  }

  final OrganisationNodeRepository _repository;
  late final StreamSubscription<List<OrganisationNode>> _subscription;

  List<OrganisationNode> _nodes = [];
  bool _enCours = false;
  String? _erreur;

  List<OrganisationNode> get nodes => List.unmodifiable(_nodes);
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  void _onNodesChanged(List<OrganisationNode> nodes) {
    _nodes = nodes;
    notifyListeners();
  }

  OrganisationNode? findById(String id) {
    for (final node in _nodes) {
      if (node.id == id) return node;
    }
    return null;
  }

  List<OrganisationNode> enfantsDe(String? parentId) =>
      _nodes.where((node) => node.noeudParentId == parentId).toList(growable: false);

  List<OrganisationNode> rechercher(String terme) {
    final normalise = terme.trim().toLowerCase();
    if (normalise.isEmpty) return const [];
    return _nodes
        .where(
          (node) =>
              node.nom.toLowerCase().contains(normalise) ||
              node.codeInterne.toLowerCase().contains(normalise),
        )
        .toList(growable: false);
  }

  /// RG-I-09 — annuaire des Églises, filtrable par catégorie confessionnelle.
  List<OrganisationNode> annuaireEglises({CategorieConfessionnelle? filtre}) {
    return _nodes
        .where(
          (node) =>
              node.typeNoeud == TypeNoeud.egliseLocale &&
              (filtre == null || node.categorieConfessionnelle == filtre),
        )
        .toList(growable: false);
  }

  Stream<List<OrganisationNode>> get toutesLesEntrees => _repository.watchAll();

  Stream<List<HistoriqueRattachement>> watchHistorique(String noeudId) =>
      _repository.watchHistorique(noeudId);

  Stream<List<NodeResponsable>> watchResponsables(String noeudId) =>
      _repository.watchResponsables(noeudId);

  Future<bool> affecterResponsable({
    required String noeudId,
    required String fideleId,
    required String fonction,
  }) => _executer(
        () => _repository.affecterResponsable(noeudId: noeudId, fideleId: fideleId, fonction: fonction),
      );

  Future<bool> retirerResponsable(String id) => _executer(() => _repository.retirerResponsable(id));

  Future<bool> creerNoeud({
    required TypeNoeud typeNoeud,
    required String? noeudParentId,
    required String nom,
    required String codeInterne,
    CategorieConfessionnelle? categorieConfessionnelle,
    DateTime? dateFondation,
  }) => _executer(
        () => _repository.creerNoeud(
          typeNoeud: typeNoeud,
          noeudParentId: noeudParentId,
          nom: nom,
          codeInterne: codeInterne,
          categorieConfessionnelle: categorieConfessionnelle,
          dateFondation: dateFondation,
        ),
      );

  Future<bool> modifierInfosNoeud({
    required String id,
    String? nom,
    String? codeInterne,
    DateTime? dateFondation,
  }) => _executer(
        () => _repository.modifierInfosNoeud(
          id: id,
          nom: nom,
          codeInterne: codeInterne,
          dateFondation: dateFondation,
        ),
      );

  Future<bool> validerNoeud(String id) => _executer(() => _repository.validerNoeud(id));

  Future<bool> archiverNoeud(String id) => _executer(() => _repository.archiverNoeud(id));

  Future<bool> supprimerNoeud(String id) => _executer(() => _repository.supprimerNoeud(id));

  Future<bool> changerRattachement({
    required String noeudId,
    required String nouveauParentId,
    String? motif,
  }) => _executer(
        () => _repository.changerRattachement(
          noeudId: noeudId,
          nouveauParentId: nouveauParentId,
          motif: motif,
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
      _erreur = error.message?.toString() ?? "Requête invalide.";
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
