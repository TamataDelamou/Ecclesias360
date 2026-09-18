import 'niveau_maturite.dart';

/// RG-IV-01/02 — une évaluation du don [donId] pour le fidèle [fideleId].
/// Chaque évaluation est une ligne nouvelle (jamais de mise à jour) :
/// l'historique complet est la liste de ces lignes, la plus récente étant
/// l'évaluation courante.
class DonFidele {
  const DonFidele({
    required this.id,
    required this.fideleId,
    required this.donId,
    required this.niveauMaturite,
    required this.responsableSuiviId,
    required this.dateEvaluation,
    this.observations,
  });

  final String id;
  final String fideleId;
  final String donId;
  final NiveauMaturite niveauMaturite;
  final String responsableSuiviId;
  final DateTime dateEvaluation;
  final String? observations;
}
