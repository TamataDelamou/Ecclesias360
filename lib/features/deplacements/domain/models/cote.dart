/// Côté d'une mutation dont la validation pastorale est requise (RG-IX-01) :
/// le nœud d'origine (que le fidèle quitte) ou le nœud de destination (qu'il
/// rejoint).
enum Cote {
  origine('origine'),
  destination('destination');

  const Cote(this.code);

  final String code;

  static Cote fromCode(String code) => Cote.values.firstWhere(
        (c) => c.code == code,
        orElse: () => throw ArgumentError('Côté de mutation inconnu : $code'),
      );
}
