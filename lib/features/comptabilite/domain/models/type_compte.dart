/// Type d'un compte du plan comptable (Module XXI, RG-XXI-01).
enum TypeCompte {
  actif('actif'),
  passif('passif'),
  charge('charge'),
  produit('produit');

  const TypeCompte(this.code);

  final String code;

  static TypeCompte fromCode(String code) =>
      TypeCompte.values.firstWhere((t) => t.code == code, orElse: () => throw ArgumentError('Type de compte inconnu : $code'));
}
