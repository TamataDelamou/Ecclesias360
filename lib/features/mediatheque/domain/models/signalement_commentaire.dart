/// RG-XIII-03 — signalement attribué d'un commentaire : un fidèle ne
/// signale qu'une fois un même commentaire.
class SignalementCommentaire {
  const SignalementCommentaire({
    required this.id,
    required this.commentaireId,
    required this.fideleId,
    required this.createdAt,
    this.motif,
  });

  final String id;
  final String commentaireId;
  final String fideleId;
  final String? motif;
  final DateTime createdAt;
}
