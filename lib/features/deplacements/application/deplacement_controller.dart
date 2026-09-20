import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/deplacement_repository.dart';
import '../domain/models/cote.dart';
import '../domain/models/lettre_recommandation.dart';
import '../domain/models/mutation.dart';
import '../domain/models/statut_mutation.dart';

/// Contrôleur du Module IX, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/fidèle — même précédent que `ArchivageController`/
/// `CulteController`.
class DeplacementController extends ChangeNotifier {
  DeplacementController(this._repository);

  final DeplacementRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  Stream<List<Mutation>> watchMutations({String? noeudId, String? fideleId, StatutMutation? statut}) =>
      _repository.watchMutations(noeudId: noeudId, fideleId: fideleId, statut: statut);

  Future<Mutation?> findById(String id) => _repository.findById(id);

  Future<LettreRecommandation?> lettreDe(String mutationId) => _repository.lettreDe(mutationId);

  Future<bool> demanderMutation({
    required String fideleId,
    required String noeudOrigineId,
    required String noeudDestinationId,
    required String motif,
  }) =>
      _executer(() => _repository.demanderMutation(
            fideleId: fideleId,
            noeudOrigineId: noeudOrigineId,
            noeudDestinationId: noeudDestinationId,
            motif: motif,
          ));

  Future<bool> validerCote({required String mutationId, required Cote cote}) =>
      _executer(() => _repository.validerCote(mutationId: mutationId, cote: cote));

  Future<bool> refuserMutation({required String mutationId, String? motifRefus}) =>
      _executer(() => _repository.refuserMutation(mutationId: mutationId, motifRefus: motifRefus));

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
