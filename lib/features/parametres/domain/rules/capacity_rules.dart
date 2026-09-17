import '../models/role.dart';

/// Règles pures RG-XXIII-02 : croisement rôle × capacité, hiérarchie
/// additive (un rôle supérieur hérite des capacités des rôles inférieurs).
abstract final class CapacityRules {
  static bool possede({required Role role, required Role roleMinimalRequis}) {
    return role.rang >= roleMinimalRequis.rang;
  }
}
