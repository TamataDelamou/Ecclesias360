import '../../features/parametres/domain/models/role.dart';

/// RG-SEC-06 — trace d'une consultation d'un dossier disciplinaire (ou,
/// `documentArchiveId` renseigné, d'une de ses pièces archivées). `fideleId`
/// est `null` pour un compte sans fiche (administrateur d'amorçage).
class ConsultationDisciplinaire {
  const ConsultationDisciplinaire({
    required this.id,
    required this.dossierId,
    required this.authUserId,
    required this.role,
    required this.consulteLe,
    this.documentArchiveId,
    this.fideleId,
  });

  final String id;
  final String dossierId;
  final String? documentArchiveId;
  final String authUserId;
  final String? fideleId;
  final Role role;
  final DateTime consulteLe;
}
