/// Sexe du fidèle. Le Cahier ne fixe pas de valeurs closes explicites pour
/// ce champ (Module II, entité Fidèle) — ensemble de travail minimal.
enum Sexe {
  masculin('masculin'),
  feminin('feminin');

  const Sexe(this.code);

  final String code;

  static Sexe fromCode(String code) =>
      values.firstWhere((s) => s.code == code, orElse: () => throw ArgumentError('Sexe inconnu : $code'));
}
