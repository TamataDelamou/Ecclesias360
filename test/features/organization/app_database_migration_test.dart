import 'dart:io';

import 'package:drift/native.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart' as sqlite3;

void main() {
  test('un fichier créé en schéma v1 reçoit les tables du Module II à l\'ouverture (onUpgrade)', () async {
    final fichier = File(
      path.join(Directory.systemTemp.path, 'ecclesias_migration_test_${DateTime.now().microsecondsSinceEpoch}.sqlite'),
    );
    addTearDown(() {
      if (fichier.existsSync()) fichier.deleteSync();
    });

    // Recrée exactement le schéma v1 (Module I seul), tel qu'il existait
    // avant l'ajout du Module II, avec une ligne de donnée réelle.
    final ancienneConnexion = sqlite3.sqlite3.open(fichier.path);
    ancienneConnexion.execute('''
      CREATE TABLE organisation_nodes (
        id TEXT NOT NULL,
        type_noeud TEXT NOT NULL,
        noeud_parent_id TEXT NULL,
        nom TEXT NOT NULL,
        code_interne TEXT NOT NULL,
        statut TEXT NOT NULL DEFAULT 'provisoire',
        logo_url TEXT NULL,
        cachet_url TEXT NULL,
        date_fondation INTEGER NULL,
        categorie_confessionnelle TEXT NULL,
        zone_geo_id TEXT NULL,
        path TEXT NOT NULL,
        depth INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (code_interne)
      );
      CREATE TABLE historique_rattachements (
        id TEXT NOT NULL, noeud_id TEXT NOT NULL, ancien_parent_id TEXT NULL,
        nouveau_parent_id TEXT NOT NULL, date_effet INTEGER NOT NULL, motif TEXT NULL,
        PRIMARY KEY (id)
      );
      CREATE TABLE sync_outbox (
        id TEXT NOT NULL, entite TEXT NOT NULL, entite_id TEXT NOT NULL, operation TEXT NOT NULL,
        cree_le INTEGER NOT NULL, tentatives INTEGER NOT NULL DEFAULT 0,
        derniere_tentative_le INTEGER NULL, derniere_erreur TEXT NULL, PRIMARY KEY (id)
      );
      PRAGMA user_version = 1;
    ''');
    ancienneConnexion.execute(
      "INSERT INTO organisation_nodes (id, type_noeud, nom, code_interne, path, depth, created_at, updated_at) "
      "VALUES ('siege-1', 'siege', 'GSG', 'GSG-SIEGE', '/siege-1/', 0, 0, 0)",
    );
    ancienneConnexion.close();

    // Ouvre ce même fichier avec la base réelle (v2) : onUpgrade doit
    // ajouter les tables du Module II sans perdre la donnée existante.
    final db = AppDatabase(NativeDatabase(fichier));

    final noeuds = await db.select(db.organisationNodes).get();
    expect(noeuds, hasLength(1));
    expect(noeuds.single.nom, 'GSG');

    // Ne doit plus lever "no such table: fideles".
    final fideles = await db.select(db.fideles).get();
    expect(fideles, isEmpty);

    await db.close();
  });
}
