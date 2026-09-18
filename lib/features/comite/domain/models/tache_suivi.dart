import 'statut_tache.dart';

/// RG-VII-03 — tâche de suivi générée depuis une décision de comité,
/// assignée à un membre (fidèle).
class TacheSuivi {
  const TacheSuivi({
    required this.id,
    required this.decisionId,
    required this.description,
    required this.assigneFideleId,
    required this.statut,
    required this.dateCreation,
  });

  final String id;
  final String decisionId;
  final String description;
  final String assigneFideleId;
  final StatutTache statut;
  final DateTime dateCreation;
}
