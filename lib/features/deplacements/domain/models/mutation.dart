import 'statut_mutation.dart';

/// Mutation d'un fidèle entre deux nœuds organisationnels (Module IX,
/// RG-IX-01 à 04). `valideeParOrigine`/`valideeParDestination` vont au-delà
/// du modèle minimal du Cahier (qui ne porte qu'un `statut` global) : ils
/// sont nécessaires pour représenter la double validation pastorale exigée
/// par RG-IX-01, potentiellement réductible à un seul côté selon la
/// politique paramétrée (voir `DeplacementRules.estValidee`).
class Mutation {
  const Mutation({
    required this.id,
    required this.fideleId,
    required this.noeudOrigineId,
    required this.noeudDestinationId,
    required this.motif,
    required this.statut,
    required this.dateDemande,
    required this.valideeParOrigine,
    required this.valideeParDestination,
    this.dateValidation,
    this.motifRefus,
  });

  final String id;
  final String fideleId;
  final String noeudOrigineId;
  final String noeudDestinationId;
  final String motif;
  final StatutMutation statut;
  final DateTime dateDemande;
  final bool valideeParOrigine;
  final bool valideeParDestination;
  final DateTime? dateValidation;
  final String? motifRefus;
}
