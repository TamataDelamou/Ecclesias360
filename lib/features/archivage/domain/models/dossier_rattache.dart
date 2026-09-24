/// RG-VIII-03 / RG-X-05 — dossier disciplinaire auquel un document archivé
/// est rattaché, soit comme origine (`moduleOrigine == 'discipline'`), soit
/// comme pièce (`pieces_dossier.document_archive_id`). Porte seulement ce
/// qu'exige la règle d'accès du dossier (`DisciplineRules.peutConsulterDossier`) :
/// la commission assignée. `trouve` est faux pour une origine qui ne
/// correspond à aucun dossier connu — le document reste alors inaccessible.
class DossierRattache {
  const DossierRattache({required this.dossierId, required this.commissionId, required this.trouve});

  final String dossierId;
  final String? commissionId;
  final bool trouve;
}
