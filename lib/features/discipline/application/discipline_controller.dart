import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../../parametres/domain/models/role.dart';
import '../data/discipline_repository.dart';
import '../domain/models/commission_disciplinaire.dart';
import '../domain/models/dossier_disciplinaire.dart';
import '../domain/models/membre_commission.dart';
import '../domain/models/nature_faute.dart';
import '../domain/models/nature_piece_dossier.dart';
import '../domain/models/piece_dossier.dart';

/// Contrôleur du Module X, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/fidèle — même précédent que `DeplacementController`/
/// `CulteController`.
class DisciplineController extends ChangeNotifier {
  DisciplineController(this._repository);

  final DisciplineRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  Stream<List<NatureFaute>> watchNaturesFaute() => _repository.watchNaturesFaute();

  Stream<List<DossierDisciplinaire>> watchDossiers(String noeudId) => _repository.watchDossiers(noeudId);

  Stream<List<DossierDisciplinaire>> watchDossiersDuFidele(String fideleId) =>
      _repository.watchDossiersDuFidele(fideleId);

  Future<DossierDisciplinaire?> findDossierById(String id) => _repository.findDossierById(id);

  Stream<List<CommissionDisciplinaire>> watchCommissions(String noeudId) => _repository.watchCommissions(noeudId);

  Stream<List<CommissionDisciplinaire>> watchCommissionsDuFidele(String fideleId) =>
      _repository.watchCommissionsDuFidele(fideleId);

  Stream<List<MembreCommission>> watchMembresCommission(String commissionId) =>
      _repository.watchMembresCommission(commissionId);

  Stream<List<PieceDossier>> watchPieces(String dossierId) => _repository.watchPieces(dossierId);

  Future<DossierDisciplinaire?> ouvrirDossier({
    required String fideleId,
    required String noeudId,
    required String natureFauteId,
    required Role roleActeur,
    String? ouvertParFideleId,
  }) async {
    DossierDisciplinaire? resultat;
    final ok = await _executer(() async {
      resultat = await _repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: roleActeur,
        ouvertParFideleId: ouvertParFideleId,
      );
    });
    return ok ? resultat : null;
  }

  Future<CommissionDisciplinaire?> creerCommission({required String noeudId, required String nom}) async {
    CommissionDisciplinaire? resultat;
    final ok = await _executer(() async {
      resultat = await _repository.creerCommission(noeudId: noeudId, nom: nom);
    });
    return ok ? resultat : null;
  }

  Future<bool> assignerCommission({required String dossierId, required String commissionId}) =>
      _executer(() => _repository.assignerCommission(dossierId: dossierId, commissionId: commissionId));

  Future<bool> ajouterMembreCommission({required String commissionId, required String fideleId}) =>
      _executer(() => _repository.ajouterMembreCommission(commissionId: commissionId, fideleId: fideleId));

  Future<bool> retirerMembreCommission(String id) => _executer(() => _repository.retirerMembreCommission(id));

  Future<bool> ajouterPiece({
    required String dossierId,
    required NaturePieceDossier nature,
    required String contenu,
    required String noeudId,
  }) =>
      _executer(
        () => _repository.ajouterPiece(dossierId: dossierId, nature: nature, contenu: contenu, noeudId: noeudId),
      );

  Future<bool> prononcerDecision({
    required String dossierId,
    required String decision,
    int? dureeSanctionJours,
    bool suspendreMinisteres = false,
  }) =>
      _executer(
        () => _repository.prononcerDecision(
          dossierId: dossierId,
          decision: decision,
          dureeSanctionJours: dureeSanctionJours,
          suspendreMinisteres: suspendreMinisteres,
        ),
      );

  Future<bool> cloturer(String dossierId) => _executer(() => _repository.cloturer(dossierId));

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
    }
  }
}
