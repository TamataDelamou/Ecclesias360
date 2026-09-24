import '../models/statut_moderation_commentaire.dart';

/// Règles de gestion pures du Module XIII — Médiathèque chrétienne.
abstract final class MediathequeRules {
  /// RG-XIII-03 : un commentaire déposé sur un contenu soumis à modération
  /// a priori reste en attente jusqu'à validation ; sinon il est publié
  /// immédiatement (modération a posteriori, retirable sur signalement).
  static StatutModerationCommentaire statutInitialCommentaire({required bool moderationAPriori}) {
    return moderationAPriori ? StatutModerationCommentaire.enAttente : StatutModerationCommentaire.publie;
  }

  /// RG-XIII-03 : au-delà du seuil de signalements, un commentaire publié
  /// est masqué automatiquement en attendant une décision de modération.
  /// RG-XIII-03 — visibilité d'un commentaire à l'écran : publié, pour tous ;
  /// en attente de modération, pour son auteur et les modérateurs seulement ;
  /// masqué, pour personne (filtré de l'affichage). Miroir local de la
  /// policy `commentaires_lecture` (migration 0019).
  static bool commentaireVisible({
    required StatutModerationCommentaire statut,
    required bool estAuteur,
    required bool estModerateur,
  }) {
    return switch (statut) {
      StatutModerationCommentaire.publie => true,
      StatutModerationCommentaire.enAttente => estAuteur || estModerateur,
      StatutModerationCommentaire.masque => false,
    };
  }

  static bool doitMasquerAutomatiquement({required int nombreSignalements, required int seuil}) {
    return nombreSignalements >= seuil;
  }
}
