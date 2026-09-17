/// Entité pure HistoriqueRattachement (RG-I-06).
class HistoriqueRattachement {
  const HistoriqueRattachement({
    required this.id,
    required this.noeudId,
    required this.ancienParentId,
    required this.nouveauParentId,
    required this.dateEffet,
    this.motif,
  });

  final String id;
  final String noeudId;
  final String? ancienParentId;
  final String nouveauParentId;
  final DateTime dateEffet;
  final String? motif;
}
