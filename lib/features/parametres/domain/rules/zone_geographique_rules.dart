import '../../../../core/error/app_error.dart';

/// Règles métier pures des référentiels du Module XXIII (RG-XXIII-01/03).
abstract final class ZoneGeographiqueRules {
  /// Le niveau d'une zone est celui de son parent + 1 ; 0 pour une racine.
  static int calculerNiveau({required int? niveauParent}) =>
      niveauParent == null ? 0 : niveauParent + 1;

  /// RG-XXIII-03 — une valeur de référentiel utilisée ne peut être
  /// supprimée, seulement désactivée.
  static AppError? raisonBlocageSuppression({required bool estUtilisee}) {
    return estUtilisee ? AppError.referentielEnUsage() : null;
  }
}
