import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Base Drift/SQLite unique, offline-first (RG-OFF-01), partagée par tous
/// les modules (voir AGENTS.md §4).
@DriftDatabase(tables: [
  OrganisationNodes,
  HistoriqueRattachements,
  Fideles,
  LiensFamiliaux,
  HistoriqueFideles,
  Tuteurs,
  ZonesGeographiques,
  SyncOutbox,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // v1 -> v2 : ajout du Module II (Fidèles). Un appareil qui avait
          // déjà créé la base en v1 (sans ces tables) doit les recevoir
          // explicitement — schemaVersion seul ne suffit pas, drift ne
          // recrée jamais rétroactivement un schéma déjà considéré à jour.
          if (from < 2) {
            await m.createTable(fideles);
            await m.createTable(liensFamiliaux);
            await m.createTable(historiqueFideles);
            await m.createTable(tuteurs);
          }
          // v2 -> v3 : ajout du référentiel ZoneGeographique (Module XXIII).
          if (from < 3) {
            await m.createTable(zonesGeographiques);
          }
        },
        beforeOpen: (details) async {
          // SQLite n'applique pas les contraintes de clé étrangère par
          // défaut : sans ceci, les `references()` déclarées dans
          // tables.dart ne sont que déclaratives.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(path.join(directory.path, 'ecclesias_360.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
