import 'statut_ministere.dart';

/// RG-III-01/04/05 — ministère rattaché à un nœud organisationnel (I).
class Ministere {
  const Ministere({
    required this.id,
    required this.noeudId,
    required this.typeMinistereId,
    required this.nom,
    required this.dateCreation,
    required this.statut,
  });

  final String id;
  final String noeudId;
  final String typeMinistereId;
  final String nom;
  final DateTime dateCreation;
  final StatutMinistere statut;
}
