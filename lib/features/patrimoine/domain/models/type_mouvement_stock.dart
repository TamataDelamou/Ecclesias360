/// Sens d'un mouvement de stock (Module XX, RG-XX-05).
enum TypeMouvementStock {
  entree('entree'),
  sortie('sortie');

  const TypeMouvementStock(this.code);

  final String code;

  static TypeMouvementStock fromCode(String code) => TypeMouvementStock.values
      .firstWhere((t) => t.code == code, orElse: () => throw ArgumentError('Type de mouvement de stock inconnu : $code'));
}
