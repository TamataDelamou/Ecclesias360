/// Statut d'une mutation (Module IX — Déplacements, RG-IX-01).
enum StatutMutation {
  enAttente('en_attente'),
  validee('validee'),
  refusee('refusee');

  const StatutMutation(this.code);

  final String code;

  static StatutMutation fromCode(String code) => StatutMutation.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de mutation inconnu : $code'),
      );
}
