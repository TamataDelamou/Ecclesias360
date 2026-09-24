import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';

/// Règles pures des notes pastorales privées (RG-II-11, RG-SEC-06), miroir
/// local des policies `notes_pastorales_*` (migration 0026).
///
/// Le fidèle concerné est exclu **avant tout le reste** : même pasteur de
/// son propre nœud, son rang ne lui rouvre pas les notes écrites sur lui.
/// Le périmètre du pasteur est approché par le rang (dette RG-SEC-05) ; le
/// serveur borne au nœud de la note (`dans_perimetre(noeud_id)`).
/// L'administrateur lit par son rang, comme pour les dossiers
/// disciplinaires (Module X).
abstract final class NotePastoraleRules {
  static bool _estPasteur(Role role) => CapacityRules.possede(role: role, roleMinimalRequis: Role.pasteur);

  static bool _estLeFideleConcerne(String? acteurFideleId, String fideleConcerneId) =>
      acteurFideleId != null && acteurFideleId == fideleConcerneId;

  /// Lecture d'une note (et de son journal de consultations) : son auteur,
  /// ou un pasteur (ou plus) — jamais le fidèle concerné.
  static bool peutConsulter({
    required Role role,
    required String? acteurFideleId,
    required String auteurFideleId,
    required String fideleConcerneId,
  }) {
    if (_estLeFideleConcerne(acteurFideleId, fideleConcerneId)) return false;
    return acteurFideleId == auteurFideleId || _estPasteur(role);
  }

  /// Ouverture de l'écran des notes d'un fidèle (liste) : pasteur (ou plus),
  /// jamais sur sa propre fiche.
  static bool peutOuvrirNotesDuFidele({
    required Role role,
    required String? acteurFideleId,
    required String fideleConcerneId,
  }) =>
      !_estLeFideleConcerne(acteurFideleId, fideleConcerneId) && _estPasteur(role);

  /// Rédaction : pasteur (ou plus) lié à sa fiche (l'auteur est une personne
  /// du registre), jamais sur sa propre fiche, jamais un contenu vide.
  static AppError? raisonBlocageRedaction({
    required Role role,
    required String? acteurFideleId,
    required String fideleConcerneId,
    required String contenu,
  }) {
    if (acteurFideleId == null ||
        _estLeFideleConcerne(acteurFideleId, fideleConcerneId) ||
        !_estPasteur(role)) {
      return AppError.notePastoraleRedactionReservee();
    }
    if (contenu.trim().isEmpty) return AppError.notePastoraleContenuVide();
    return null;
  }

  /// Modification du contenu : par l'auteur seul, sans historique (RG-II-11).
  static AppError? raisonBlocageModification({
    required String? acteurFideleId,
    required String auteurFideleId,
    required String fideleConcerneId,
    required String contenu,
  }) {
    if (acteurFideleId == null ||
        acteurFideleId != auteurFideleId ||
        _estLeFideleConcerne(acteurFideleId, fideleConcerneId)) {
      return AppError.notePastoraleModificationReservee();
    }
    if (contenu.trim().isEmpty) return AppError.notePastoraleContenuVide();
    return null;
  }
}
