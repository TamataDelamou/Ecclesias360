/// RG-XII-06 — une proposition de thème soumise par un fidèle, votée par
/// l'assemblée, puis validée ou rejetée par le pasteur (édition Windows,
/// écran 7). La reformulation et le classement automatiques par
/// l'assistant IA (Module XVI) restent différés, non construits.
enum StatutProposition {
  soumise('soumise'),
  validee('validee'),
  rejetee('rejetee');

  const StatutProposition(this.code);

  final String code;

  static StatutProposition fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de proposition inconnu : $code'),
      );
}
