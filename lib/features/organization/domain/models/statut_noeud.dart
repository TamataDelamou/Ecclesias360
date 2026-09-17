/// Statut du cycle de vie d'un nœud (RG-I-02, RG-I-08).
enum StatutNoeud {
  provisoire('provisoire'),
  actif('actif'),
  archive('archive');

  const StatutNoeud(this.code);

  final String code;

  static StatutNoeud fromCode(String code) => values.firstWhere(
        (statut) => statut.code == code,
        orElse: () => throw ArgumentError('Statut de nœud inconnu : $code'),
      );
}
