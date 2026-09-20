/// RG-X-02 — référentiel des natures de faute (fermé et extensible, décision
/// pastorale hors périmètre technique — voir seed dans `AppDatabase`).
class NatureFaute {
  const NatureFaute({
    required this.id,
    required this.code,
    required this.libelle,
    required this.standard,
    required this.statut,
  });

  final String id;
  final String code;
  final String libelle;
  final bool standard;
  final String statut;
}
