/// Origine de saisie d'une contribution (Module XI, RG-XI-06).
enum OrigineContribution {
  mobile('mobile'),
  desktop('desktop'),
  horsLigne('hors_ligne');

  const OrigineContribution(this.code);

  final String code;

  static OrigineContribution fromCode(String code) => OrigineContribution.values.firstWhere(
        (o) => o.code == code,
        orElse: () => throw ArgumentError('Origine de contribution inconnue : $code'),
      );
}
