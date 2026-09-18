/// Entité pure ResponsableNoeud (RG-I-05) — un responsable en fonction (ou
/// passé, si `dateFin` est dans le passé) d'un nœud organisationnel.
class NodeResponsable {
  const NodeResponsable({
    required this.id,
    required this.noeudId,
    required this.fideleId,
    required this.fonction,
    required this.dateDebut,
    this.dateFin,
  });

  final String id;
  final String noeudId;
  final String fideleId;
  final String fonction;
  final DateTime dateDebut;
  final DateTime? dateFin;
}
