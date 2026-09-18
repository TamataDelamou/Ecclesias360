import '../../../../core/error/app_error.dart';
import '../models/statut_verification.dart';

/// Règles métier pures du Module V (RG-V-*).
abstract final class ProfessionRules {
  /// RG-V-01 — une déclaration ne peut être vérifiée qu'une fois, jamais
  /// re-déclarée après vérification.
  static bool peutVerifier(StatutVerification actuel) => actuel == StatutVerification.declare;

  /// RG-V-02 — une profession référencée par des déclarations existantes ne
  /// peut être supprimée, seulement désactivée (même convention que
  /// RG-XXIII-03).
  static AppError? raisonBlocageSuppression({required bool estUtilisee}) {
    return estUtilisee ? AppError.referentielEnUsage() : null;
  }
}
