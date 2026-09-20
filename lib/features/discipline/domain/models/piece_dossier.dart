import 'nature_piece_dossier.dart';

/// RG-X-02/06 — pièce (témoignage ou preuve) versée à un dossier
/// disciplinaire. [documentArchiveId] reste `null` tant qu'aucun dépôt
/// d'archivage (module VIII) n'est injecté dans `DisciplineRepository` —
/// même précédent que `ProcesVerbal.documentArchiveId` (module VII).
class PieceDossier {
  const PieceDossier({
    required this.id,
    required this.dossierId,
    required this.nature,
    required this.ajouteLe,
    this.documentArchiveId,
  });

  final String id;
  final String dossierId;
  final NaturePieceDossier nature;
  final DateTime ajouteLe;
  final String? documentArchiveId;
}
