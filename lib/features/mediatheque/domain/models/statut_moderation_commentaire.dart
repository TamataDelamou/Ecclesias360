/// Statut de modération d'un commentaire de la médiathèque (Module XIII,
/// RG-XIII-03).
enum StatutModerationCommentaire {
  enAttente('en_attente'),
  publie('publie'),
  masque('masque');

  const StatutModerationCommentaire(this.code);

  final String code;

  static StatutModerationCommentaire fromCode(String code) => StatutModerationCommentaire.values
      .firstWhere((s) => s.code == code, orElse: () => throw ArgumentError('Statut de modération inconnu : $code'));
}
