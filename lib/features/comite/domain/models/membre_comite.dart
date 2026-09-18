/// RG-VII-01 — un membre du comité est nécessairement un fidèle existant
/// (Module II) auquel est attribuée une fonction datée. Sous-ensemble
/// qualifié des fidèles, jamais une entité indépendante.
class MembreComite {
  const MembreComite({
    required this.id,
    required this.fideleId,
    required this.noeudId,
    required this.fonction,
    required this.dateDebut,
    this.dateFin,
  });

  final String id;
  final String fideleId;
  final String noeudId;
  final String fonction;
  final DateTime dateDebut;
  final DateTime? dateFin;

  bool get mandatActif => dateFin == null || dateFin!.isAfter(DateTime.now());
}
