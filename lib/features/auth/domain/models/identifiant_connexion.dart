/// RG-SEC-01 — identifiant choisi par l'utilisateur, déjà normalisé
/// (téléphone au format E.164, e-mail en minuscules). Ne se construit que
/// via `IdentifiantRules`, jamais à partir d'une saisie brute.
sealed class IdentifiantConnexion {
  const IdentifiantConnexion(this.valeur);

  final String valeur;

  bool get estTelephone => this is IdentifiantTelephone;

  @override
  bool operator ==(Object other) =>
      other is IdentifiantConnexion && other.runtimeType == runtimeType && other.valeur == valeur;

  @override
  int get hashCode => Object.hash(runtimeType, valeur);

  @override
  String toString() => valeur;
}

/// Numéro au format E.164 (`+` suivi de 8 à 15 chiffres, KER-ID-06).
final class IdentifiantTelephone extends IdentifiantConnexion {
  const IdentifiantTelephone(super.valeur);
}

final class IdentifiantEmail extends IdentifiantConnexion {
  const IdentifiantEmail(super.valeur);
}
