import 'package:drift/drift.dart';

import '../../features/organization/data/local/app_database.dart';

/// Traite une entrée de la file de synchronisation. Toute exception est
/// interprétée comme un échec temporaire : l'entrée reste en file.
typedef OutboxHandler = Future<void> Function(SyncOutboxRow entry);

/// Coordonne la file de synchronisation hors ligne (RG-OFF-02) : chaque
/// dépôt enregistre un handler par entité, rejoué dans l'ordre
/// chronologique dès qu'une connexion redevient disponible. Un échec
/// n'annule jamais l'écriture locale déjà effectuée (RG-OFF-01) — l'entrée
/// reste en file pour une prochaine tentative, jamais purgée avant
/// confirmation serveur (chapitre 7.2 du Cahier).
class SyncCoordinator {
  SyncCoordinator(this._db);

  final AppDatabase _db;
  final Map<String, OutboxHandler> _handlers = {};

  void registerHandler(String entite, OutboxHandler handler) {
    _handlers[entite] = handler;
  }

  Future<void> enqueue({
    required String id,
    required String entite,
    required String entiteId,
    required String operation,
  }) {
    return _db.into(_db.syncOutbox).insert(
          SyncOutboxCompanion.insert(
            id: id,
            entite: entite,
            entiteId: entiteId,
            operation: operation,
            creeLe: DateTime.now(),
          ),
        );
  }

  /// Rejoue la file dans l'ordre chronologique. Jamais bloquant pour
  /// l'utilisateur (RG-OFF-01) — à invoquer en arrière-plan (retour de
  /// connectivité, minuteur périodique), jamais depuis le chemin d'écriture.
  Future<void> flush() async {
    final pending = await (_db.select(_db.syncOutbox)
          ..orderBy([(t) => OrderingTerm.asc(t.creeLe)]))
        .get();

    for (final entry in pending) {
      final handler = _handlers[entry.entite];
      if (handler == null) continue;
      try {
        await handler(entry);
        await (_db.delete(_db.syncOutbox)..where((t) => t.id.equals(entry.id))).go();
      } catch (error) {
        await (_db.update(_db.syncOutbox)..where((t) => t.id.equals(entry.id))).write(
          SyncOutboxCompanion(
            tentatives: Value(entry.tentatives + 1),
            derniereTentativeLe: Value(DateTime.now()),
            derniereErreur: Value(error.toString()),
          ),
        );
      }
    }
  }
}
