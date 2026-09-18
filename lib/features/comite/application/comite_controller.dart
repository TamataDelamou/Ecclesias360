import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/comite_repository.dart';
import '../domain/models/decision.dart';
import '../domain/models/erratum_pv.dart';
import '../domain/models/membre_comite.dart';
import '../domain/models/proces_verbal.dart';
import '../domain/models/seance_comite.dart';
import '../domain/models/statut_decision.dart';
import '../domain/models/tache_suivi.dart';

/// Contrôleur du Module VII, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/séance/décision (pas de liste globale unique à mettre
/// en cache, contrairement aux référentiels des autres modules).
class ComiteController extends ChangeNotifier {
  ComiteController(this._repository);

  final ComiteRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  Future<int?> quorumMinimumDuNoeud(String noeudId) => _repository.quorumMinimumDuNoeud(noeudId);

  Future<bool> definirQuorum({required String noeudId, required int quorumMinimum}) =>
      _executer(() => _repository.definirQuorum(noeudId: noeudId, quorumMinimum: quorumMinimum));

  Stream<List<MembreComite>> watchMembres(String noeudId) => _repository.watchMembres(noeudId);

  Future<bool> nommerMembre({required String fideleId, required String noeudId, required String fonction}) =>
      _executer(() => _repository.nommerMembre(fideleId: fideleId, noeudId: noeudId, fonction: fonction));

  Future<bool> clorerMandat(String id) => _executer(() => _repository.clorerMandat(id));

  Stream<List<SeanceComite>> watchSeances(String noeudId) => _repository.watchSeances(noeudId);

  Future<SeanceComite?> findSeanceById(String id) => _repository.findSeanceById(id);

  Stream<List<String>> watchPresents(String seanceId) => _repository.watchPresents(seanceId);

  Future<bool> creerSeance({
    required String noeudId,
    required DateTime date,
    required String ordreDuJour,
    required List<String> presentsFideleIds,
  }) => _executer(
        () => _repository.creerSeance(
          noeudId: noeudId,
          date: date,
          ordreDuJour: ordreDuJour,
          presentsFideleIds: presentsFideleIds,
        ),
      );

  Stream<List<Decision>> watchDecisions(String seanceId) => _repository.watchDecisions(seanceId);

  Future<bool> ajouterDecision({
    required String seanceId,
    required String libelle,
    String? resultatVote,
    bool porteeDisciplinaire = false,
  }) => _executer(
        () => _repository.ajouterDecision(
          seanceId: seanceId,
          libelle: libelle,
          resultatVote: resultatVote,
          porteeDisciplinaire: porteeDisciplinaire,
        ),
      );

  Future<bool> changerStatutDecision({required String id, required StatutDecision statut}) =>
      _executer(() => _repository.changerStatutDecision(id: id, statut: statut));

  Stream<ProcesVerbal?> watchProcesVerbal(String seanceId) => _repository.watchProcesVerbal(seanceId);

  Future<bool> enregistrerBrouillon({required String seanceId, required String contenu}) =>
      _executer(() => _repository.enregistrerBrouillon(seanceId: seanceId, contenu: contenu));

  Future<bool> validerProcesVerbal(String id) => _executer(() => _repository.validerProcesVerbal(id));

  Stream<List<ErratumPv>> watchErratums(String procesVerbalId) => _repository.watchErratums(procesVerbalId);

  Future<bool> ajouterErratum({required String procesVerbalId, required String texte, String? auteurFideleId}) =>
      _executer(
        () => _repository.ajouterErratum(
          procesVerbalId: procesVerbalId,
          texte: texte,
          auteurFideleId: auteurFideleId,
        ),
      );

  Stream<List<TacheSuivi>> watchTaches(String decisionId) => _repository.watchTaches(decisionId);

  Future<bool> creerTache({required String decisionId, required String description, required String assigneFideleId}) =>
      _executer(
        () => _repository.creerTache(
          decisionId: decisionId,
          description: description,
          assigneFideleId: assigneFideleId,
        ),
      );

  Future<bool> marquerTacheFaite(String id) => _executer(() => _repository.marquerTacheFaite(id));

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
}
