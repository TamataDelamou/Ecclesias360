import 'statut_campagne_inventaire.dart';

/// Campagne d'inventaire physique périodique d'un nœud (Module XX,
/// RG-XX-04). Entité ajoutée au-delà du tableau minimal du Cahier (même
/// précédent que `ErratumPv` du Module VII ou les champs de double
/// validation du Module IX) : le Cahier décrit la règle sans nommer
/// l'entité porteuse.
class CampagneInventaire {
  const CampagneInventaire({
    required this.id,
    required this.noeudId,
    required this.libelle,
    required this.dateDebut,
    this.dateCloture,
    required this.statut,
  });

  final String id;
  final String noeudId;
  final String libelle;
  final DateTime dateDebut;
  final DateTime? dateCloture;
  final StatutCampagneInventaire statut;
}
