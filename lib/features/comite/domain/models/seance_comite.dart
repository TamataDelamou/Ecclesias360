/// RG-VII-05 — [quorumAtteint] est calculé par le système (nombre de
/// présents comparé au quorum configuré pour le nœud, `null` si aucun
/// quorum n'est configuré) et non laissé à la déclaration libre.
class SeanceComite {
  const SeanceComite({
    required this.id,
    required this.noeudId,
    required this.date,
    required this.ordreDuJour,
    required this.quorumAtteint,
  });

  final String id;
  final String noeudId;
  final DateTime date;
  final String ordreDuJour;
  final bool? quorumAtteint;
}
