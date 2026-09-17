/// Type de lien familial (RG-II-04). Décrit la relation de `fideleId1` vers
/// `fideleId2` — `conjoint` est symétrique, `enfant`/`parent` sont
/// l'inverse l'un de l'autre (si A est `enfant` de B, alors B est `parent`
/// de A).
enum TypeLien {
  conjoint('conjoint'),
  enfant('enfant'),
  parent('parent');

  const TypeLien(this.code);

  final String code;

  static TypeLien fromCode(String code) => values.firstWhere(
        (t) => t.code == code,
        orElse: () => throw ArgumentError('Type de lien inconnu : $code'),
      );
}
