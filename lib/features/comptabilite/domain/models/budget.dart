/// Budget prévisionnel par nœud, période et compte (Module XXI, RG-XXI-04).
/// `seuilAlertePourcentage` est un champ ajouté au-delà du tableau minimal
/// du Cahier (le seuil d'alerte de dépassement est « paramétrable » sans que
/// le Cahier ne nomme son support) — même précédent que
/// `Bien.seuilAlerteStock` du Module XX ; `null` retombe sur
/// `AppDefaults.comptabiliteSeuilAlerteDepassementPourcentageParDefaut`.
class Budget {
  const Budget({
    required this.id,
    required this.noeudId,
    required this.periodeId,
    required this.compteId,
    required this.montantPrevu,
    this.seuilAlertePourcentage,
  });

  final String id;
  final String noeudId;
  final String periodeId;
  final String compteId;
  final int montantPrevu;
  final int? seuilAlertePourcentage;
}
