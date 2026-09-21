import 'etat_bien.dart';

/// Pointage terrain d'un bien lors d'une campagne d'inventaire (Module XX,
/// RG-XX-04) : compare l'état (et, pour un bien à gestion de stock, la
/// quantité) déclaré au système avec le constat terrain. `ecartDetecte` est
/// calculé et figé au moment du pointage (`PatrimoineRules.detecterEcart`)
/// — c'est l'enregistrement d'un événement d'audit, pas un solde courant,
/// donc à la différence du solde de projet ou de la quantité de stock, il
/// est légitimement stocké tel quel.
class PointageInventaire {
  const PointageInventaire({
    required this.id,
    required this.campagneId,
    required this.bienId,
    required this.etatConstate,
    this.quantiteConstatee,
    required this.ecartDetecte,
    this.commentaire,
    required this.dateDuPointage,
  });

  final String id;
  final String campagneId;
  final String bienId;
  final EtatBien etatConstate;
  final int? quantiteConstatee;
  final bool ecartDetecte;
  final String? commentaire;
  final DateTime dateDuPointage;
}
