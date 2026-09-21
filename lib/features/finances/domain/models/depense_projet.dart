/// Dépense affectée à un projet (Module XI, RG-XI-03). `derogationTracee`
/// et `motifDerogation` couvrent l'engagement d'une dépense au-delà du
/// solde disponible, exceptionnellement autorisé par un rôle habilité.
class DepenseProjet {
  const DepenseProjet({
    required this.id,
    required this.projetId,
    required this.montant,
    required this.libelle,
    required this.date,
    required this.valideParFideleId,
    required this.derogationTracee,
    this.motifDerogation,
  });

  final String id;
  final String projetId;
  final int montant;
  final String libelle;
  final DateTime date;
  final String valideParFideleId;
  final bool derogationTracee;
  final String? motifDerogation;
}
