/// RG-III-02/05 — mandat du responsable d'un ministère. `dateFinPrevue`
/// alimente le suivi des échéances (écran 9) ; une fois [dateFinReelle]
/// renseignée, la ligne devient un élément de l'historique des responsables
/// successifs (écran 6) — pas de table séparée pour cet historique.
class MandatResponsable {
  const MandatResponsable({
    required this.id,
    required this.ministereId,
    required this.fideleId,
    required this.dateDebut,
    this.dateFinPrevue,
    this.dateFinReelle,
  });

  final String id;
  final String ministereId;
  final String fideleId;
  final DateTime dateDebut;
  final DateTime? dateFinPrevue;
  final DateTime? dateFinReelle;

  bool get estActif => dateFinReelle == null;
}
