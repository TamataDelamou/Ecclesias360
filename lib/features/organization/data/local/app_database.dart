import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/utils/id_generator.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// RG-III-04 — les vingt-quatre types de ministères standards, seedés à la
/// création/mise à niveau de la base locale et dans la migration Supabase
/// correspondante (mêmes codes des deux côtés).
const List<(String code, String libelle)> typesMinisteresStandards = [
  ('chorale', 'Chorale'),
  ('louange', 'Louange'),
  ('intercession', 'Intercession et prière'),
  ('jeunesse', 'Jeunesse'),
  ('diaconat', 'Diaconat'),
  ('media', 'Média'),
  ('sonorisation', 'Sonorisation et son'),
  ('action_sociale', 'Action sociale'),
  ('evangelisation', 'Évangélisation'),
  ('enfants', 'Enfants et école du dimanche'),
  ('hospitalite', 'Hospitalité et accueil'),
  ('protocole', 'Protocole'),
  ('securite', 'Sécurité'),
  ('finances_offrandes', 'Finances et offrandes'),
  ('visitation_pastorale', 'Visitation pastorale'),
  ('enseignement_biblique', 'Enseignement biblique'),
  ('communication', 'Communication'),
  ('technique_informatique', 'Technique et informatique'),
  ('missions', 'Missions'),
  ('patrimoine', 'Construction et patrimoine'),
  ('sport', 'Sport'),
  ('arts_culture', 'Arts et culture'),
  ('femmes', 'Ministère des femmes'),
  ('hommes', 'Ministère des hommes'),
];

/// Base Drift/SQLite unique, offline-first (RG-OFF-01), partagée par tous
/// les modules (voir AGENTS.md §4).
@DriftDatabase(tables: [
  OrganisationNodes,
  HistoriqueRattachements,
  NodeResponsables,
  Fideles,
  LiensFamiliaux,
  HistoriqueFideles,
  Tuteurs,
  ZonesGeographiques,
  TypesMinisteres,
  Ministeres,
  AffectationsMinisteres,
  MandatsResponsables,
  ActivitesMinisteres,
  SyncOutbox,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 5;

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
          // v3 -> v4 : ajout de ResponsableNoeud (Module I, RG-I-05).
          if (from < 4) {
            await m.createTable(nodeResponsables);
          }
          // v4 -> v5 : ajout du Module III (Ministères et départements).
          if (from < 5) {
            await m.createTable(typesMinisteres);
            await m.createTable(ministeres);
            await m.createTable(affectationsMinisteres);
            await m.createTable(mandatsResponsables);
            await m.createTable(activitesMinisteres);
            await _seedTypesMinisteresStandards();
          }
        },
        beforeOpen: (details) async {
          // SQLite n'applique pas les contraintes de clé étrangère par
          // défaut : sans ceci, les `references()` déclarées dans
          // tables.dart ne sont que déclaratives.
          await customStatement('PRAGMA foreign_keys = ON');
          if (details.wasCreated) {
            await _seedTypesMinisteresStandards();
          }
        },
      );

  Future<void> _seedTypesMinisteresStandards() async {
    await batch((b) {
      b.insertAll(
        typesMinisteres,
        [
          for (final (code, libelle) in typesMinisteresStandards)
            TypesMinisteresCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              standard: const Value(true),
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(path.join(directory.path, 'ecclesias_360.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
