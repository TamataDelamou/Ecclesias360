/// RG-VII-03 — statut d'une tâche de suivi issue d'une décision.
enum StatutTache {
  aFaire('a_faire'),
  fait('fait');

  const StatutTache(this.code);

  final String code;

  static StatutTache fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de tâche inconnu : $code'),
      );
}
