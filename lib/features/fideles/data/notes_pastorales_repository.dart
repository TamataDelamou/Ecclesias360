import 'package:drift/drift.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/role.dart';
import '../domain/models/note_pastorale.dart';
import '../domain/rules/note_pastorale_rules.dart';

/// Dépôt des notes pastorales privées (Module II, écran 13, RG-II-11).
///
/// Chaque méthode reçoit l'`Acteur` de la session et vérifie son
/// habilitation **ici**, pas seulement à l'écran : un accès direct par la
/// route ne contourne rien. La liste n'expose jamais le contenu ; seule
/// [consulter] le renvoie, et journalise chaque ouverture (RG-SEC-06, par
/// analogie avec les dossiers disciplinaires). Aucune méthode de
/// suppression (absence d'API délibérée) ; le journal est en ajout seul.
class NotesPastoralesRepository {
  NotesPastoralesRepository(this._db);

  final AppDatabase _db;

  /// Notes d'un fidèle, sans leur contenu (auteur et dates seulement).
  /// Émet `AppError.notePastoraleAccesRefuse` si [acteur] ne peut pas
  /// ouvrir les notes de ce fidèle.
  Stream<List<NotePastoraleResume>> watchNotesDuFidele({required Acteur acteur, required String fideleId}) {
    if (!NotePastoraleRules.peutOuvrirNotesDuFidele(
      role: acteur.role,
      acteurFideleId: acteur.fideleId,
      fideleConcerneId: fideleId,
    )) {
      return Stream.error(AppError.notePastoraleAccesRefuse());
    }
    final query = _db.select(_db.notesPastorales)
      ..where((t) => t.fideleId.equals(fideleId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch().map(
          (rows) => rows
              .where((row) => _peutConsulter(acteur, row))
              .map(
                (row) => NotePastoraleResume(
                  id: row.id,
                  fideleId: row.fideleId,
                  auteurFideleId: row.auteurFideleId,
                  createdAt: row.createdAt,
                  updatedAt: row.updatedAt,
                ),
              )
              .toList(growable: false),
        );
  }

  /// Ouverture d'une note : vérifie l'habilitation puis journalise, dans
  /// cet ordre — une ouverture refusée n'est ni servie ni tracée comme une
  /// lecture. `null` si la note n'existe pas.
  Future<NotePastorale?> consulter({required Acteur acteur, required String noteId}) async {
    final row = await _findRow(noteId);
    if (row == null) return null;
    if (!_peutConsulter(acteur, row)) throw AppError.notePastoraleAccesRefuse();
    await _db.into(_db.consultationsNotesPastorales).insert(
          ConsultationsNotesPastoralesCompanion.insert(
            id: IdGenerator.newId(),
            noteId: noteId,
            authUserId: acteur.authUserId,
            fideleId: Value(acteur.fideleId),
            role: acteur.role.code,
            consulteLe: DateTime.now(),
          ),
        );
    return _toDomain(row);
  }

  /// Rédaction : l'auteur est la fiche de la session ; le nœud est celui du
  /// fidèle au moment de la rédaction, figé ensuite.
  Future<NotePastorale> rediger({required Acteur acteur, required String fideleId, required String contenu}) async {
    final erreur = NotePastoraleRules.raisonBlocageRedaction(
      role: acteur.role,
      acteurFideleId: acteur.fideleId,
      fideleConcerneId: fideleId,
      contenu: contenu,
    );
    if (erreur != null) throw erreur;
    final fidele = await (_db.select(_db.fideles)..where((t) => t.id.equals(fideleId))).getSingleOrNull();
    if (fidele == null) throw ArgumentError('Fidèle introuvable : $fideleId');

    final id = IdGenerator.newId();
    final maintenant = DateTime.now();
    await _db.into(_db.notesPastorales).insert(
          NotesPastoralesCompanion.insert(
            id: id,
            fideleId: fideleId,
            auteurFideleId: acteur.fideleId!,
            noeudId: fidele.noeudId,
            contenu: contenu.trim(),
            createdAt: maintenant,
            updatedAt: maintenant,
          ),
        );
    return _toDomain((await _findRow(id))!);
  }

  /// Modification du contenu, par l'auteur seul, sans historique.
  Future<NotePastorale> modifier({required Acteur acteur, required String noteId, required String contenu}) async {
    final row = await _findRow(noteId);
    if (row == null) throw ArgumentError('Note pastorale introuvable : $noteId');
    final erreur = NotePastoraleRules.raisonBlocageModification(
      acteurFideleId: acteur.fideleId,
      auteurFideleId: row.auteurFideleId,
      fideleConcerneId: row.fideleId,
      contenu: contenu,
    );
    if (erreur != null) throw erreur;
    await (_db.update(_db.notesPastorales)..where((t) => t.id.equals(noteId))).write(
      NotesPastoralesCompanion(contenu: Value(contenu.trim()), updatedAt: Value(DateTime.now())),
    );
    return _toDomain((await _findRow(noteId))!);
  }

  /// Journal des consultations d'une note : lisible de qui peut lire la
  /// note (son auteur, les pasteurs), jamais du fidèle concerné.
  Stream<List<ConsultationNotePastorale>> watchConsultations({required Acteur acteur, required String noteId}) {
    return Stream.fromFuture(_findRow(noteId)).asyncExpand((row) {
      if (row == null || !_peutConsulter(acteur, row)) {
        return Stream<List<ConsultationNotePastorale>>.error(AppError.notePastoraleAccesRefuse());
      }
      final query = _db.select(_db.consultationsNotesPastorales)
        ..where((t) => t.noteId.equals(noteId))
        ..orderBy([(t) => OrderingTerm.desc(t.consulteLe), (t) => OrderingTerm.desc(t.rowId)]);
      return query.watch().map(
            (rows) => rows
                .map(
                  (r) => ConsultationNotePastorale(
                    id: r.id,
                    noteId: r.noteId,
                    authUserId: r.authUserId,
                    fideleId: r.fideleId,
                    role: Role.fromCode(r.role),
                    consulteLe: r.consulteLe,
                  ),
                )
                .toList(growable: false),
          );
    });
  }

  bool _peutConsulter(Acteur acteur, NotePastoraleRow row) => NotePastoraleRules.peutConsulter(
        role: acteur.role,
        acteurFideleId: acteur.fideleId,
        auteurFideleId: row.auteurFideleId,
        fideleConcerneId: row.fideleId,
      );

  Future<NotePastoraleRow?> _findRow(String id) =>
      (_db.select(_db.notesPastorales)..where((t) => t.id.equals(id))).getSingleOrNull();

  NotePastorale _toDomain(NotePastoraleRow row) => NotePastorale(
        id: row.id,
        fideleId: row.fideleId,
        auteurFideleId: row.auteurFideleId,
        noeudId: row.noeudId,
        contenu: row.contenu,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
