import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Base Drift/SQLite unique, offline-first (RG-OFF-01), partagée par tous
/// les modules (voir AGENTS.md §4).
@DriftDatabase(tables: [OrganisationNodes, HistoriqueRattachements, SyncOutbox])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(path.join(directory.path, 'ecclesias_360.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
