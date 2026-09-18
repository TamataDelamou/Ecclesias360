/// RG-VI-01 — un groupe est soit à appartenance calculée automatiquement à
/// partir de la fiche fidèle, soit purement manuel (aucun critère
/// calculable, ex. fonctions comme « pasteurs », « diacres »).
enum TypeRegleGroupe {
  auto('auto'),
  manuel('manuel');

  const TypeRegleGroupe(this.code);

  final String code;

  static TypeRegleGroupe fromCode(String code) => values.firstWhere(
        (t) => t.code == code,
        orElse: () => throw ArgumentError('Type de règle de groupe inconnu : $code'),
      );
}
