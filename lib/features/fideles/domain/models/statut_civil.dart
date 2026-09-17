/// Statut civil du fidèle. Le Cahier ne fixe pas de valeurs closes
/// explicites pour ce champ (Module II, entité Fidèle) — ensemble de
/// travail minimal usuel en contexte ecclésiastique.
enum StatutCivil {
  celibataire('celibataire'),
  marie('marie'),
  divorce('divorce'),
  veuf('veuf');

  const StatutCivil(this.code);

  final String code;

  static StatutCivil fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut civil inconnu : $code'),
      );
}
