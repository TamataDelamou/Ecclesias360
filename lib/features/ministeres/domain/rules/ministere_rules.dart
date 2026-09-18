import '../../../../core/error/app_error.dart';
import '../models/mandat_responsable.dart';

/// Règles métier pures du Module III (RG-III-*).
abstract final class MinistereRules {
  /// RG-III-01 — au plus un rôle `responsable` actif par ministère.
  static AppError? raisonBlocageResponsableSupplementaire({
    required bool existeDejaResponsableActif,
  }) {
    return existeDejaResponsableActif ? AppError.responsableMinistereDejaActif() : null;
  }

  /// RG-III-04 — les types standards ne sont jamais désactivables depuis
  /// cette UI (droits d'administration globale non distingués tant que
  /// RG-SEC-01 n'est pas construit).
  static AppError? raisonBlocageDesactivationType({required bool standard}) {
    return standard ? AppError.typeMinistereStandardProtege() : null;
  }

  /// RG-III-02 — mandats non clos dont l'échéance prévue tombe dans les
  /// [horizon] prochains jours (ou est déjà dépassée).
  static List<MandatResponsable> mandatsArrivantAEcheance(
    List<MandatResponsable> mandats, {
    required DateTime maintenant,
    Duration horizon = const Duration(days: 30),
  }) {
    return mandats.where((m) {
      if (!m.estActif) return false;
      final echeance = m.dateFinPrevue;
      if (echeance == null) return false;
      return echeance.isBefore(maintenant.add(horizon));
    }).toList(growable: false);
  }
}
