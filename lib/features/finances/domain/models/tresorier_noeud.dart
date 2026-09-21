/// Désignation d'un fidèle comme trésorier d'un nœud (Module XI, RG-XI-02).
/// L'énum `Role` (Module XXIII) est fermée et ne porte pas de valeur
/// « trésorier » : cette table latérale l'habilite pour la validation
/// comptable, même motif que `MembreCommission`/`MembresComite`
/// (Modules VII/X) pour une capacité qui n'est pas un rang hiérarchique.
class TresorierNoeud {
  const TresorierNoeud({
    required this.id,
    required this.fideleId,
    required this.noeudId,
    required this.dateDebut,
    this.dateFin,
  });

  final String id;
  final String fideleId;
  final String noeudId;
  final DateTime dateDebut;
  final DateTime? dateFin;
}
