import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../../parametres/application/capacites_controller.dart';
import '../data/organisation_node_repository.dart';
import '../domain/models/categorie_confessionnelle.dart';
import '../domain/models/historique_rattachement.dart';
import '../domain/models/node_responsable.dart';
import '../domain/models/organisation_node.dart';
import '../domain/models/type_noeud.dart';
import '../domain/rules/organisation_acces_rules.dart';

/// Contrôleur du Module I, exposé aux écrans (pattern `provider`).
class OrganisationController extends ChangeNotifier {
  /// [_capacites] : capacités de `roles.json` (RG-I-03), refusées par défaut.
  OrganisationController(this._repository, this._capacites) {
    _subscription = _repository.watchAll().listen(_onNodesChanged);
  }

  final OrganisationNodeRepository _repository;
  final CapacitesController _capacites;
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

  // --- Écritures : habilitation vérifiée ici, avant tout appel au dépôt ------
  //
  // RG-SEC-04 — l'acteur est toujours la session (`SessionController.acteur`) ;
  // la règle est celle des écrans (`OrganisationAccesRules`), si bien qu'un
  // appel qui contourne l'écran (route directe, autre appelant) est refusé de
  // la même façon.

  /// RG-I-05 — désigner un responsable : rang pasteur.
  Future<bool> affecterResponsable({
    required String noeudId,
    required String fideleId,
    required String fonction,
    required Acteur acteur,
  }) => _executerEnTantQue(
        OrganisationAccesRules.raisonBlocageDesignation(role: acteur.role),
        () => _repository.affecterResponsable(noeudId: noeudId, fideleId: fideleId, fonction: fonction),
      );

  Future<bool> retirerResponsable(String id, {required Acteur acteur}) => _executerEnTantQue(
        OrganisationAccesRules.raisonBlocageDesignation(role: acteur.role),
        () => _repository.retirerResponsable(id),
      );

  /// RG-I-03 — l'église locale au rang de gestion, tout niveau supérieur
  /// (racine comprise) avec la capacité `creer_noeud_niveau_superieur`.
  Future<bool> creerNoeud({
    required TypeNoeud typeNoeud,
    required String? noeudParentId,
    required String nom,
    required String codeInterne,
    required Acteur acteur,
    CategorieConfessionnelle? categorieConfessionnelle,
    DateTime? dateFondation,
  }) => _executerEnTantQue(
        _raisonBlocageCreationOuValidation(typeNoeud, acteur),
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
    required Acteur acteur,
    String? nom,
    String? codeInterne,
    DateTime? dateFondation,
  }) => _executerEnTantQue(
        OrganisationAccesRules.raisonBlocageGestion(role: acteur.role),
        () => _repository.modifierInfosNoeud(
          id: id,
          nom: nom,
          codeInterne: codeInterne,
          dateFondation: dateFondation,
        ),
      );

  /// RG-I-03 — la validation suit le même seuil que la création du type ;
  /// le type est relu dans le dépôt, jamais pris de l'écran.
  Future<bool> validerNoeud(String id, {required Acteur acteur}) => _executer(() async {
        final noeud = await _repository.findById(id);
        if (noeud == null) throw ArgumentError('Nœud introuvable : $id');
        final refus = _raisonBlocageCreationOuValidation(noeud.typeNoeud, acteur);
        if (refus != null) throw refus;
        await _repository.validerNoeud(id);
      });

  Future<bool> archiverNoeud(String id, {required Acteur acteur}) => _executerEnTantQue(
        OrganisationAccesRules.raisonBlocageGestion(role: acteur.role),
        () => _repository.archiverNoeud(id),
      );

  Future<bool> supprimerNoeud(String id, {required Acteur acteur}) => _executerEnTantQue(
        OrganisationAccesRules.raisonBlocageSuppression(role: acteur.role),
        () => _repository.supprimerNoeud(id),
      );

  Future<bool> changerRattachement({
    required String noeudId,
    required String nouveauParentId,
    required Acteur acteur,
    String? motif,
  }) => _executerEnTantQue(
        OrganisationAccesRules.raisonBlocageGestion(role: acteur.role),
        () => _repository.changerRattachement(
          noeudId: noeudId,
          nouveauParentId: nouveauParentId,
          motif: motif,
        ),
      );

  AppError? _raisonBlocageCreationOuValidation(TypeNoeud type, Acteur acteur) =>
      OrganisationAccesRules.raisonBlocageCreationOuValidation(
        type: type,
        role: acteur.role,
        capaciteNiveauSuperieur: _capacites.accorde(
          capacite: Capacites.creerNoeudNiveauSuperieur,
          role: acteur.role,
        ),
      );

  Future<bool> _executerEnTantQue(AppError? refus, Future<void> Function() action) => _executer(() async {
        if (refus != null) throw refus;
        await action();
      });

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
