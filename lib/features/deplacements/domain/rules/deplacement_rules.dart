/// Règles de gestion pures du Module IX — Déplacements.
abstract final class DeplacementRules {
  /// RG-IX-01 — une mutation ne modifie le rattachement effectif du fidèle
  /// qu'après validation pastorale des deux nœuds concernés, sauf si la
  /// politique du réseau autorise une validation unilatérale (paramétrable,
  /// voir `AppDefaults.deplacementValidationUnilateraleAutorisee`).
  static bool estValidee({
    required bool valideeParOrigine,
    required bool valideeParDestination,
    required bool validationUnilateraleAutorisee,
  }) {
    if (validationUnilateraleAutorisee) {
      return valideeParOrigine || valideeParDestination;
    }
    return valideeParOrigine && valideeParDestination;
  }
}
