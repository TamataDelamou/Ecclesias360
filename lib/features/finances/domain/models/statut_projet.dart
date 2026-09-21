/// Statut d'un projet financier (Module XI, RG-XI-03).
enum StatutProjet {
  enCours('en_cours'),
  suspendu('suspendu'),
  clos('clos');

  const StatutProjet(this.code);

  final String code;

  static StatutProjet fromCode(String code) => StatutProjet.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de projet inconnu : $code'),
      );
}
