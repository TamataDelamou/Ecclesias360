import 'etat_bien.dart';
import 'type_sortie_bien.dart';

/// Bien du patrimoine (Module XX, RG-XX-01). `idInventaire` est
/// l'identifiant d'inventaire unique exigé par le Cahier, distinct de
/// l'identifiant technique `id` (même distinction que le numéro d'archive
/// du Module VIII). Les champs `typeSortie`/`dateSortie`/
/// `valideParFideleIdSortie`/`motifSortie` tracent la sortie définitive du
/// patrimoine (RG-XX-02) ; `seuilAlerteStock` ne s'applique qu'aux biens à
/// gestion de stock (catégorie « stocks », RG-XX-05).
class Bien {
  const Bien({
    required this.id,
    required this.idInventaire,
    required this.categorieId,
    required this.noeudId,
    required this.designation,
    required this.etat,
    required this.valeurAcquisition,
    required this.valeurVenale,
    required this.devise,
    required this.dateAcquisition,
    this.seuilAlerteStock,
    this.typeSortie,
    this.dateSortie,
    this.valideParFideleIdSortie,
    this.motifSortie,
  });

  final String id;
  final String idInventaire;
  final String categorieId;
  final String noeudId;
  final String designation;
  final EtatBien etat;
  final int valeurAcquisition;
  final int valeurVenale;
  final String devise;
  final DateTime dateAcquisition;
  final int? seuilAlerteStock;
  final TypeSortieBien? typeSortie;
  final DateTime? dateSortie;
  final String? valideParFideleIdSortie;
  final String? motifSortie;
}
