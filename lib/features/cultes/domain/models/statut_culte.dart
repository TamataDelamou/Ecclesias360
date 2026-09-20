enum StatutCulte {
  planifie('planifie'),
  enCours('en_cours'),
  termine('termine'),
  annule('annule');

  const StatutCulte(this.code);

  final String code;

  static StatutCulte fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de culte inconnu : $code'),
      );
}
