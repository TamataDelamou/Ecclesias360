/// Écriture comptable en partie double (Module XXI, RG-XXI-01) : chaque
/// opération génère deux lignes équilibrées (une ligne débit, une ligne
/// crédit) partageant le même `pieceJustificativeId`, jamais une seule
/// ligne isolée — voir `ComptabiliteRules.genererLignesDoublePartie` et
/// `ComptabiliteRepository`. `rapproche` est un champ ajouté au-delà du
/// tableau minimal du Cahier (RG-XXI-05, rapprochement bancaire), même
/// précédent que `Bien.seuilAlerteStock` du Module XX.
class EcritureComptable {
  const EcritureComptable({
    required this.id,
    required this.date,
    required this.compteId,
    required this.debit,
    required this.credit,
    required this.noeudId,
    this.pieceJustificativeId,
    required this.periodeId,
    this.libelle,
    required this.rapproche,
  });

  final String id;
  final DateTime date;
  final String compteId;
  final int debit;
  final int credit;
  final String noeudId;
  final String? pieceJustificativeId;
  final String periodeId;
  final String? libelle;
  final bool rapproche;
}
