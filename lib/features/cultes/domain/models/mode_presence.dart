/// RG-XII-02 — les deux modes sont mutuellement exclusifs pour un même
/// culte : pointage nominal (une ligne par fidèle présent) ou compte
/// global (un seul entier), jamais les deux.
enum ModePresence {
  nominal('nominal'),
  global('global');

  const ModePresence(this.code);

  final String code;

  static ModePresence fromCode(String code) => values.firstWhere(
        (m) => m.code == code,
        orElse: () => throw ArgumentError('Mode de présence inconnu : $code'),
      );
}
