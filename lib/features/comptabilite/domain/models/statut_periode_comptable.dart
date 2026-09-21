/// Statut d'une période comptable (Module XXI, RG-XXI-03).
enum StatutPeriodeComptable {
  ouverte('ouverte'),
  cloturee('cloturee');

  const StatutPeriodeComptable(this.code);

  final String code;

  static StatutPeriodeComptable fromCode(String code) => StatutPeriodeComptable.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de période comptable inconnu : $code'),
      );
}
