/// RG-VII-05 — une décision ne peut passer à `adopte` que si le quorum de
/// la séance est atteint (vérifié par le système, jamais laissé à la
/// seule déclaration de l'utilisateur).
enum StatutDecision {
  adopte('adopte'),
  rejete('rejete'),
  ajourne('ajourne');

  const StatutDecision(this.code);

  final String code;

  static StatutDecision fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de décision inconnu : $code'),
      );
}
