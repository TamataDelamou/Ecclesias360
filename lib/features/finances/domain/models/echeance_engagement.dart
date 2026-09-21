import 'statut_echeance.dart';

/// Échéance générée pour un engagement récurrent (Module XI, RG-XI-04).
/// `contributionId` est renseigné quand l'échéance est rapprochée
/// manuellement d'une contribution effectivement saisie (aucune détection
/// automatique de correspondance dans cette itération).
class EcheanceEngagement {
  const EcheanceEngagement({
    required this.id,
    required this.engagementId,
    required this.dateEcheance,
    required this.statut,
    this.contributionId,
  });

  final String id;
  final String engagementId;
  final DateTime dateEcheance;
  final StatutEcheance statut;
  final String? contributionId;
}
