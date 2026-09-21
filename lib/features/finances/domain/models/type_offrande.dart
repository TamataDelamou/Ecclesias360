/// RG-XI-01 — référentiel des types d'offrande (fermé et extensible). Le
/// Cahier le rattache conceptuellement au Module XXIII, mais suit le même
/// précédent que TypeMinistere/DonSpirituel/Profession : porté en propre
/// par son module producteur (voir AGENTS.md §7, entrée Module XI).
class TypeOffrande {
  const TypeOffrande({
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
