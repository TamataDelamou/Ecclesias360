/// Statut d'une contribution (Module XI, RG-XI-02) — la saisie est distincte
/// de la validation comptable.
enum StatutContribution {
  enAttente('en_attente'),
  validee('validee'),
  rejetee('rejetee');

  const StatutContribution(this.code);

  final String code;

  static StatutContribution fromCode(String code) => StatutContribution.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de contribution inconnu : $code'),
      );
}
