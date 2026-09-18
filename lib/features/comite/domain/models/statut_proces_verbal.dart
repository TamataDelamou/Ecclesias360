/// RG-VII-02 — un procès-verbal devient immuable après validation : toute
/// correction ultérieure prend la forme d'un erratum tracé (`ErratumPv`),
/// jamais d'une modification silencieuse du contenu original.
enum StatutProcesVerbal {
  brouillon('brouillon'),
  valide('valide');

  const StatutProcesVerbal(this.code);

  final String code;

  static StatutProcesVerbal fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de procès-verbal inconnu : $code'),
      );
}
