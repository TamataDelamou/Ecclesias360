import '../../../../core/error/app_error.dart';
import '../models/role.dart';
import 'capacity_rules.dart';

/// Règles pures d'accès au Module XXIII.
abstract final class ParametresRules {
  /// RG-XXIII-06 — l'administration des paramètres (référentiels, journal
  /// des modifications) est réservée au rôle d'administration le plus élevé.
  /// Miroir des policies des référentiels de 0019 (écriture : administrateur).
  /// La consultation des rôles (écran mobile 4) reste ouverte en lecture.
  static bool peutAdministrer(Role role) => CapacityRules.possede(role: role, roleMinimalRequis: Role.administrateur);

  static AppError? raisonBlocageAdministration({required Role roleActeur}) =>
      peutAdministrer(roleActeur) ? null : AppError.administrationParametresReservee();
}
