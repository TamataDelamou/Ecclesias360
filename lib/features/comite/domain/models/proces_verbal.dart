import 'statut_proces_verbal.dart';

/// RG-VII-02/03 — [documentArchiveId] reste `null` tant que le Module VIII
/// (archivage documentaire, nomenclature RG-VIII-01) n'est pas construit ;
/// la validation du PV n'attend pas cette intégration.
class ProcesVerbal {
  const ProcesVerbal({
    required this.id,
    required this.seanceId,
    required this.contenu,
    required this.statut,
    this.documentArchiveId,
  });

  final String id;
  final String seanceId;
  final String contenu;
  final StatutProcesVerbal statut;
  final String? documentArchiveId;
}
