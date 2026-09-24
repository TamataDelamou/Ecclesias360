import 'package:drift/drift.dart';

import '../../organization/data/local/app_database.dart';
import '../domain/models/entree_journal_parametres.dart';

/// RG-XXIII-06 — lecture du journal des modifications des paramètres
/// (écrit par les dépôts de chaque référentiel, jamais ici : aucune API
/// d'écriture, de modification ni de suppression n'est exposée).
class JournalParametresRepository {
  JournalParametresRepository(this._db);

  final AppDatabase _db;

  Stream<List<EntreeJournalParametres>> watchJournal() {
    // Départage par ordre d'insertion : Drift stocke les dates à la seconde.
    final query = _db.select(_db.journalParametres)
      ..orderBy([(t) => OrderingTerm.desc(t.date), (t) => OrderingTerm.desc(t.rowId)]);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => EntreeJournalParametres(
              id: row.id,
              referentiel: row.referentiel,
              objetId: row.objetId,
              action: ActionJournalParametres.fromCode(row.action),
              ancienneValeur: row.ancienneValeur,
              nouvelleValeur: row.nouvelleValeur,
              auteurAuthUserId: row.auteurAuthUserId,
              auteurFideleId: row.auteurFideleId,
              date: row.date,
            ),
          )
          .toList(growable: false),
    );
  }
}
