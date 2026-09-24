import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
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

  /// RG-XIII-03 — le seuil compte des **signaleurs distincts** (un fidèle ne
  /// signale qu'une fois), et seulement depuis la dernière décision de
  /// modération : un commentaire approuvé n'est pas remasqué par les
  /// signalements qu'un modérateur a déjà examinés.
  static bool doitMasquerAutomatiquement({required int signaleursDistincts, required int seuil}) {
    return signaleursDistincts >= seuil;
  }

  /// RG-XIII-03 — signaler exige une fiche (utilisateur simple : lecture
  /// seule, RG-SEC-06bis), jamais sur son propre commentaire, une seule fois.
  static AppError? raisonBlocageSignalement({
    required String? fideleId,
    required String auteurCommentaireId,
    required bool dejaSignale,
  }) {
    if (fideleId == null) return AppError.signalementSansFiche();
    if (fideleId == auteurCommentaireId) return AppError.signalementPropreCommentaire();
    if (dejaSignale) return AppError.commentaireDejaSignale();
    return null;
  }

  /// RG-XIII-03 — modérer : rang pasteur (approximation locale de
  /// `moderateur_du_contenu`, 0019, qui ouvre aussi le périmètre du nœud
  /// éditeur — dette RG-SEC-05), avec une fiche liée pour que la décision
  /// trace une personne du registre.
  static bool peutModerer(Role role) => CapacityRules.possede(role: role, roleMinimalRequis: Role.pasteur);

  static AppError? raisonBlocageModeration({required Role role, required String? fideleId}) {
    if (!peutModerer(role)) return AppError.moderationReservee();
    if (fideleId == null) return AppError.moderationSansFiche();
    return null;
  }
}
