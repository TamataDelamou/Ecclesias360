import '../../../../core/error/app_error.dart';
import '../models/statut_proces_verbal.dart';

/// Règles métier pures du Module VII (RG-VII-*).
abstract final class ComiteRules {
  /// RG-VII-05 — quorum vérifié par le système : `null` si aucun quorum
  /// n'est configuré pour le nœud (indéterminé, pas « non atteint »).
  static bool? quorumAtteint({required int nombrePresents, required int? quorumMinimum}) {
    if (quorumMinimum == null) return null;
    return nombrePresents >= quorumMinimum;
  }

  /// RG-VII-05 — une décision ne peut être adoptée que si le quorum de sa
  /// séance est explicitement atteint (jamais si indéterminé ou non
  /// atteint).
  static AppError? raisonBlocageAdoption({required bool? quorumAtteint}) {
    return quorumAtteint == true ? null : AppError.quorumNonAtteintPourAdoption();
  }

  /// RG-VII-02 — un procès-verbal validé est immuable : toute autre
  /// modification que son passage initial à `valide` doit passer par un
  /// erratum tracé.
  static AppError? raisonBlocageModificationProcesVerbal({required StatutProcesVerbal statut}) {
    return statut == StatutProcesVerbal.valide ? AppError.procesVerbalValideImmuable() : null;
  }
}
