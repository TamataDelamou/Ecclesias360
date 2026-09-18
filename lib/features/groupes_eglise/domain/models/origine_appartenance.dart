/// RG-VI-01 — origine d'une ligne d'appartenance : calculée automatiquement
/// ou affectée manuellement (avec dérogation tracée si elle contredit le
/// calcul automatique).
enum OrigineAppartenance {
  auto('auto'),
  manuel('manuel');

  const OrigineAppartenance(this.code);

  final String code;

  static OrigineAppartenance fromCode(String code) => values.firstWhere(
        (o) => o.code == code,
        orElse: () => throw ArgumentError('Origine d\'appartenance inconnue : $code'),
      );
}
