/// Statut d'une échéance d'engagement (Module XI, RG-XI-04).
enum StatutEcheance {
  enAttente('en_attente'),
  honoree('honoree'),
  enRetard('en_retard');

  const StatutEcheance(this.code);

  final String code;

  static StatutEcheance fromCode(String code) => StatutEcheance.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError("Statut d'échéance inconnu : $code"),
      );
}
