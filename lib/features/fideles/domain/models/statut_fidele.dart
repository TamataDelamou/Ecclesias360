/// Statut administratif (RG-II-08) — distinct du cheminement spirituel
/// (RG-II-02). Seul l'archivage logique (`inactif`) est permis ; la
/// suppression physique est interdite tant que des rattachements existent.
enum StatutFidele {
  actif('actif'),
  inactif('inactif'),
  decede('decede');

  const StatutFidele(this.code);

  final String code;

  static StatutFidele fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut fidèle inconnu : $code'),
      );
}
