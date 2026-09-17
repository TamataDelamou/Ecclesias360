import 'package:drift/drift.dart';

/// Table Drift NœudOrganisationnel (Module I, RG-I-*).
@DataClassName('OrganisationNodeRow')
class OrganisationNodes extends Table {
  TextColumn get id => text()();
  TextColumn get typeNoeud => text()();
  TextColumn get noeudParentId => text().nullable()();
  TextColumn get nom => text()();
  TextColumn get codeInterne => text()();
  TextColumn get statut => text().withDefault(const Constant('provisoire'))();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get cachetUrl => text().nullable()();
  DateTimeColumn get dateFondation => dateTime().nullable()();
  TextColumn get categorieConfessionnelle => text().nullable()();
  TextColumn get zoneGeoId => text().nullable()();
  TextColumn get path => text()();
  IntColumn get depth => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code_interne)'];
}

/// Table Drift HistoriqueRattachement (RG-I-06) — trace tout changement de
/// rattachement d'un nœud.
@DataClassName('HistoriqueRattachementRow')
class HistoriqueRattachements extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text()();
  TextColumn get ancienParentId => text().nullable()();
  TextColumn get nouveauParentId => text()();
  DateTimeColumn get dateEffet => dateTime()();
  TextColumn get motif => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// File d'attente hors ligne (RG-OFF-02) : chaque écriture locale enregistre
/// ici l'événement à rejouer vers Supabase dès qu'une connexion est
/// disponible, dans l'ordre chronologique, jamais purgée avant confirmation
/// serveur (chapitre 7.2 du Cahier).
@DataClassName('SyncOutboxRow')
class SyncOutbox extends Table {
  TextColumn get id => text()();
  TextColumn get entite => text()();
  TextColumn get entiteId => text()();
  TextColumn get operation => text()();
  DateTimeColumn get creeLe => dateTime()();
  IntColumn get tentatives => integer().withDefault(const Constant(0))();
  DateTimeColumn get derniereTentativeLe => dateTime().nullable()();
  TextColumn get derniereErreur => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
