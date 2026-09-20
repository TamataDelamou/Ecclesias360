import 'statut_dossier_disciplinaire.dart';

/// RG-X-01 à 04 — dossier disciplinaire. Au-delà du tableau minimal du
/// Cahier (fidele_id · noeud_id · nature_faute · date_ouverture ·
/// commission_id · statut · decision · duree_sanction ·
/// date_reintegration_prevue), quatre champs pragmatiques sont ajoutés,
/// même précédent que documenté pour les Modules VII/IX :
/// - [ouvertParFideleId] : auteur de l'ouverture (traçabilité RG-X-05).
/// - [statutSpirituelAnterieur] : capturé à l'ouverture pour restaurer
///   exactement le statut d'avant discipline à la clôture (RG-X-04).
/// - [suspensionMinisteresAppliquee] : mémorise si RG-X-03 a été déclenché,
///   pour savoir s'il faut réintégrer les affectations à la clôture.
/// - [decisionComiteOrigineId] : trace qu'une décision du comité (module
///   VII, `porteeDisciplinaire`) est à l'origine de l'ouverture — résout la
///   propagation RG-VII-04, jusqu'ici un simple drapeau informatif.
class DossierDisciplinaire {
  const DossierDisciplinaire({
    required this.id,
    required this.fideleId,
    required this.noeudId,
    required this.natureFauteId,
    required this.dateOuverture,
    required this.statut,
    this.ouvertParFideleId,
    this.statutSpirituelAnterieur,
    this.commissionId,
    this.decision,
    this.dateDecision,
    this.dureeSanctionJours,
    this.dateReintegrationPrevue,
    this.suspensionMinisteresAppliquee = false,
    this.decisionComiteOrigineId,
  });

  final String id;
  final String fideleId;
  final String noeudId;
  final String natureFauteId;
  final DateTime dateOuverture;
  final StatutDossierDisciplinaire statut;
  final String? ouvertParFideleId;
  final String? statutSpirituelAnterieur;
  final String? commissionId;
  final String? decision;
  final DateTime? dateDecision;
  final int? dureeSanctionJours;
  final DateTime? dateReintegrationPrevue;
  final bool suspensionMinisteresAppliquee;
  final String? decisionComiteOrigineId;
}
