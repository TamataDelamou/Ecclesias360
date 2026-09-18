/// RG-IV-01 — échelle de maturité fermée d'un don spirituel.
enum NiveauMaturite {
  emergent('emergent'),
  enDeveloppement('en_developpement'),
  confirme('confirme'),
  mature('mature');

  const NiveauMaturite(this.code);

  final String code;

  static NiveauMaturite fromCode(String code) => values.firstWhere(
        (n) => n.code == code,
        orElse: () => throw ArgumentError('Niveau de maturité inconnu : $code'),
      );
}
