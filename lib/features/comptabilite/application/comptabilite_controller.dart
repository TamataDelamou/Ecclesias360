import 'package:flutter/foundation.dart';

import '../data/comptabilite_repository.dart';
import '../domain/models/budget.dart';
import '../domain/models/compte_comptable.dart';
import '../domain/models/ecriture_comptable.dart';
import '../domain/models/periode_comptable.dart';

/// Contrôleur du Module XXI, exposé aux écrans (pattern `provider`). Portée
/// mobile intentionnellement réduite à la consultation (RG-XXI-02 : aucune
/// écriture n'est jamais saisie manuellement, toujours générée par les
/// Modules XI/XX) — ce contrôleur n'expose donc que des lectures, sans le
/// motif `_executer`/`enCours`/`erreur` des autres contrôleurs (rien à muter
/// depuis un écran mobile de ce module).
class ComptabiliteController extends ChangeNotifier {
  ComptabiliteController(this._repository);

  final ComptabiliteRepository _repository;

  Stream<List<CompteComptable>> watchPlanComptable() => _repository.watchPlanComptable();

  Stream<List<PeriodeComptable>> watchPeriodes() => _repository.watchPeriodes();

  Future<PeriodeComptable?> periodeCouranteOuverteOuNull() async {
    try {
      return await _repository.periodeCouranteOuverte();
    } on StateError {
      return null;
    }
  }

  Stream<List<EcritureComptable>> watchEcritures(String noeudId) => _repository.watchEcritures(noeudId);

  Future<int> soldeCaisseDuJour(String noeudId) => _repository.soldeCaisseDuJour(noeudId);

  Future<({int recettes, int depenses})> rapportFinancierRapide({required String noeudId, required String periodeId}) =>
      _repository.rapportFinancierRapide(noeudId: noeudId, periodeId: periodeId);

  Stream<List<Budget>> watchBudgets({required String noeudId, required String periodeId}) =>
      _repository.watchBudgets(noeudId: noeudId, periodeId: periodeId);
}
