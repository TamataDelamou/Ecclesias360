/// Statut d'un engagement récurrent (Module XI, RG-XI-04).
enum StatutEngagement {
  actif('actif'),
  suspendu('suspendu'),
  clos('clos');

  const StatutEngagement(this.code);

  final String code;

  static StatutEngagement fromCode(String code) => StatutEngagement.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError("Statut d'engagement inconnu : $code"),
      );
}
