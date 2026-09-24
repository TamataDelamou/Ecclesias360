import 'package:drift/drift.dart';

import '../../features/organization/data/local/app_database.dart';
import '../../features/parametres/domain/models/role.dart';
import '../utils/id_generator.dart';
import 'consultation_disciplinaire.dart';

/// RG-SEC-06 — journal systématique des consultations disciplinaires,
/// partagé par le Module X (ouverture d'un dossier) et le Module VIII
/// (lecture d'une pièce archivée) sans que l'un dépende de l'autre. Ajout
/// seul : aucune méthode de modification ni de suppression n'est exposée
/// (absence d'API délibérée, même convention que `ArchivageRepository`) ;
/// côté serveur, la table n'accorde ni UPDATE ni DELETE (0023). Socle local
/// en attendant l'Audit du GSG Platform Kernel (Cahier §8.5).
class JournalConsultationsRepository {
  JournalConsultationsRepository(this._db);

  final AppDatabase _db;

  Future<void> journaliser({
    required String dossierId,
    required String authUserId,
    required String? fideleId,
    required Role role,
    String? documentArchiveId,
  }) async {
    await _db.into(_db.consultationsDisciplinaires).insert(
          ConsultationsDisciplinairesCompanion.insert(
            id: IdGenerator.newId(),
            dossierId: dossierId,
            documentArchiveId: Value(documentArchiveId),
            authUserId: authUserId,
            fideleId: Value(fideleId),
            role: role.code,
            consulteLe: DateTime.now(),
          ),
        );
  }

  Stream<List<ConsultationDisciplinaire>> watchConsultations(String dossierId) {
    final query = _db.select(_db.consultationsDisciplinaires)
      ..where((t) => t.dossierId.equals(dossierId))
      ..orderBy([(t) => OrderingTerm.desc(t.consulteLe), (t) => OrderingTerm.desc(t.rowId)]);
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ConsultationDisciplinaire(
                  id: row.id,
                  dossierId: row.dossierId,
                  documentArchiveId: row.documentArchiveId,
                  authUserId: row.authUserId,
                  fideleId: row.fideleId,
                  role: Role.fromCode(row.role),
                  consulteLe: row.consulteLe,
                ),
              )
              .toList(growable: false),
        );
  }
}
