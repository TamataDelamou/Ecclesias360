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

/// RG-IV-04 — les neuf dons spirituels (1 Corinthiens 12:8-10), référentiel
/// fixe seedé des deux côtés (local et Supabase, mêmes codes).
const List<(String code, String libelle, String descriptionBiblique)> donsSpirituelsStandards = [
  ('parole_de_sagesse', 'Parole de sagesse', '1 Corinthiens 12:8'),
  ('parole_de_connaissance', 'Parole de connaissance', '1 Corinthiens 12:8'),
  ('foi', 'Foi', '1 Corinthiens 12:9'),
  ('dons_de_guerisons', 'Dons de guérisons', '1 Corinthiens 12:9'),
  ('operations_de_miracles', 'Opérations de miracles', '1 Corinthiens 12:10'),
  ('prophetie', 'Prophétie', '1 Corinthiens 12:10'),
  ('discernement_des_esprits', 'Discernement des esprits', '1 Corinthiens 12:10'),
  ('diverses_langues', 'Diverses langues', '1 Corinthiens 12:10'),
  ('interpretation_des_langues', 'Interprétation des langues', '1 Corinthiens 12:10'),
];

/// RG-V-02 — quelques métiers de départ pour amorcer le référentiel
/// hiérarchisé (catégorie / métier), entièrement paramétrable ensuite
/// (contrairement aux référentiels fixes des Modules III/IV, aucune
/// protection « standard » ici).
const List<(String code, String categorie, String libelle)> professionsDeDepart = [
  ('medecin', 'Santé', 'Médecin'),
  ('infirmier', 'Santé', 'Infirmier'),
  ('enseignant', 'Éducation', 'Enseignant'),
  ('developpeur_informatique', 'Informatique', 'Développeur informatique'),
  ('ingenieur', 'Ingénierie et BTP', 'Ingénieur'),
  ('architecte', 'Ingénierie et BTP', 'Architecte'),
  ('artisan_macon', 'Ingénierie et BTP', 'Artisan / Maçon'),
  ('avocat', 'Droit et affaires', 'Avocat'),
  ('comptable', 'Droit et affaires', 'Comptable'),
  ('entrepreneur', 'Droit et affaires', 'Entrepreneur'),
  ('chauffeur', 'Transport et services', 'Chauffeur'),
  ('commercant', 'Commerce', 'Commerçant'),
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
  DonsSpirituels,
  DonsFideles,
  DonsMinisteresCompatibles,
  Professions,
  ProfessionsFideles,
  Sollicitations,
  SyncOutbox,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 7;

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
          // v5 -> v6 : ajout du Module IV (Dons spirituels).
          if (from < 6) {
            await m.createTable(donsSpirituels);
            await m.createTable(donsFideles);
            await m.createTable(donsMinisteresCompatibles);
            await _seedDonsSpirituelsStandards();
          }
          // v6 -> v7 : ajout du Module V (Groupes professionnels).
          if (from < 7) {
            await m.createTable(professions);
            await m.createTable(professionsFideles);
            await m.createTable(sollicitations);
            await _seedProfessionsDeDepart();
          }
        },
        beforeOpen: (details) async {
          // SQLite n'applique pas les contraintes de clé étrangère par
          // défaut : sans ceci, les `references()` déclarées dans
          // tables.dart ne sont que déclaratives.
          await customStatement('PRAGMA foreign_keys = ON');
          if (details.wasCreated) {
            await _seedTypesMinisteresStandards();
            await _seedDonsSpirituelsStandards();
            await _seedProfessionsDeDepart();
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

  Future<void> _seedDonsSpirituelsStandards() async {
    await batch((b) {
      b.insertAll(
        donsSpirituels,
        [
          for (final (code, libelle, descriptionBiblique) in donsSpirituelsStandards)
            DonsSpirituelsCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              descriptionBiblique: descriptionBiblique,
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedProfessionsDeDepart() async {
    await batch((b) {
      b.insertAll(
        professions,
        [
          for (final (code, categorie, libelle) in professionsDeDepart)
            ProfessionsCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              categorie: categorie,
              libelle: libelle,
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
