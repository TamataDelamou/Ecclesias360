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

  test('un fichier créé en schéma v4 reçoit les tables du Module III et le seed RG-III-04 à l\'ouverture', () async {
    final fichier = File(
      path.join(Directory.systemTemp.path, 'ecclesias_migration_test_v4_${DateTime.now().microsecondsSinceEpoch}.sqlite'),
    );
    addTearDown(() {
      if (fichier.existsSync()) fichier.deleteSync();
    });

    // Recrée le schéma v4 (Modules I, II, XXIII, responsables de nœud),
    // tel qu'il existait avant l'ajout du Module III, avec une donnée réelle.
    final ancienneConnexion = sqlite3.sqlite3.open(fichier.path);
    ancienneConnexion.execute('''
      CREATE TABLE organisation_nodes (
        id TEXT NOT NULL, type_noeud TEXT NOT NULL, noeud_parent_id TEXT NULL, nom TEXT NOT NULL,
        code_interne TEXT NOT NULL, statut TEXT NOT NULL DEFAULT 'provisoire', logo_url TEXT NULL,
        cachet_url TEXT NULL, date_fondation INTEGER NULL, categorie_confessionnelle TEXT NULL,
        zone_geo_id TEXT NULL, path TEXT NOT NULL, depth INTEGER NOT NULL,
        created_at INTEGER NOT NULL, updated_at INTEGER NOT NULL,
        PRIMARY KEY (id), UNIQUE (code_interne)
      );
      CREATE TABLE historique_rattachements (
        id TEXT NOT NULL, noeud_id TEXT NOT NULL, ancien_parent_id TEXT NULL,
        nouveau_parent_id TEXT NOT NULL, date_effet INTEGER NOT NULL, motif TEXT NULL,
        PRIMARY KEY (id)
      );
      CREATE TABLE node_responsables (
        id TEXT NOT NULL, noeud_id TEXT NOT NULL, fidele_id TEXT NOT NULL, fonction TEXT NOT NULL,
        date_debut INTEGER NOT NULL, date_fin INTEGER NULL, PRIMARY KEY (id)
      );
      CREATE TABLE fideles (
        id TEXT NOT NULL, noeud_id TEXT NOT NULL, nom TEXT NOT NULL, prenoms TEXT NOT NULL,
        date_naissance INTEGER NOT NULL, sexe TEXT NOT NULL, statut_civil TEXT NOT NULL,
        statut_spirituel TEXT NOT NULL DEFAULT 'visiteur', statut TEXT NOT NULL DEFAULT 'actif',
        date_conversion INTEGER NULL, date_bapteme INTEGER NULL, eglise_provenance TEXT NULL,
        photo_url TEXT NULL, telephone TEXT NULL, email TEXT NULL, adresse TEXT NULL,
        created_at INTEGER NOT NULL, updated_at INTEGER NOT NULL, PRIMARY KEY (id)
      );
      CREATE TABLE liens_familiaux (
        id TEXT NOT NULL, fidele_id1 TEXT NOT NULL, fidele_id2 TEXT NOT NULL, type_lien TEXT NOT NULL,
        PRIMARY KEY (id)
      );
      CREATE TABLE historique_fideles (
        id TEXT NOT NULL, fidele_id TEXT NOT NULL, champ_modifie TEXT NOT NULL,
        ancienne_valeur TEXT NULL, nouvelle_valeur TEXT NULL, auteur_fidele_id TEXT NULL,
        date INTEGER NOT NULL, PRIMARY KEY (id)
      );
      CREATE TABLE tuteurs (
        id TEXT NOT NULL, mineur_id TEXT NOT NULL, lien TEXT NOT NULL, tuteur_fidele_id TEXT NULL,
        tuteur_tiers_nom TEXT NULL, tuteur_tiers_telephone TEXT NULL, PRIMARY KEY (id)
      );
      CREATE TABLE zones_geographiques (
        id TEXT NOT NULL, libelle TEXT NOT NULL, niveau INTEGER NOT NULL, parent_id TEXT NULL,
        statut TEXT NOT NULL DEFAULT 'actif', PRIMARY KEY (id)
      );
      CREATE TABLE sync_outbox (
        id TEXT NOT NULL, entite TEXT NOT NULL, entite_id TEXT NOT NULL, operation TEXT NOT NULL,
        cree_le INTEGER NOT NULL, tentatives INTEGER NOT NULL DEFAULT 0,
        derniere_tentative_le INTEGER NULL, derniere_erreur TEXT NULL, PRIMARY KEY (id)
      );
      PRAGMA user_version = 4;
    ''');
    ancienneConnexion.execute(
      "INSERT INTO fideles (id, noeud_id, nom, prenoms, date_naissance, sexe, statut_civil, created_at, updated_at) "
      "VALUES ('fidele-1', 'siege-1', 'Doe', 'Jean', 0, 'masculin', 'celibataire', 0, 0)",
    );
    ancienneConnexion.close();

    final db = AppDatabase(NativeDatabase(fichier));

    final fideles = await db.select(db.fideles).get();
    expect(fideles, hasLength(1));
    expect(fideles.single.nom, 'Doe');

    // Ne doit plus lever "no such table: ministeres".
    final ministeres = await db.select(db.ministeres).get();
    expect(ministeres, isEmpty);

    final typesStandards = await db.select(db.typesMinisteres).get();
    expect(typesStandards.where((t) => t.standard).length, 24);

    await db.close();
  });

  test('un fichier créé en schéma v5 reçoit les tables du Module IV et le seed RG-IV-04 à l\'ouverture', () async {
    final fichier = File(
      path.join(Directory.systemTemp.path, 'ecclesias_migration_test_v5_${DateTime.now().microsecondsSinceEpoch}.sqlite'),
    );
    addTearDown(() {
      if (fichier.existsSync()) fichier.deleteSync();
    });

    // Construit un vrai fichier v6 (via l'implémentation réelle, garantie
    // fidèle au schéma courant), puis le ramène à v5 en retirant
    // uniquement les tables propres au Module IV — plus fiable qu'une
    // retranscription manuelle du DDL v5 complet.
    final dbInitiale = AppDatabase(NativeDatabase(fichier));
    await dbInitiale.into(dbInitiale.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: 'siege-1',
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG-SIEGE',
            path: '/siege-1/',
            depth: 0,
            createdAt: DateTime(2026, 1, 1),
            updatedAt: DateTime(2026, 1, 1),
          ),
        );
    await dbInitiale.close();

    final connexionBrute = sqlite3.sqlite3.open(fichier.path);
    connexionBrute.execute('''
      DROP TABLE dons_ministeres_compatibles;
      DROP TABLE dons_fideles;
      DROP TABLE dons_spirituels;
      PRAGMA user_version = 5;
    ''');
    connexionBrute.close();

    final db = AppDatabase(NativeDatabase(fichier));

    final noeuds = await db.select(db.organisationNodes).get();
    expect(noeuds, hasLength(1));
    expect(noeuds.single.nom, 'GSG');

    // Ne doit plus lever "no such table: dons_spirituels".
    final dons = await db.select(db.donsSpirituels).get();
    expect(dons, hasLength(9));

    final evaluations = await db.select(db.donsFideles).get();
    expect(evaluations, isEmpty);

    await db.close();
  });

  test('un fichier créé en schéma v6 reçoit les tables du Module V et le seed RG-V-02 à l\'ouverture', () async {
    final fichier = File(
      path.join(Directory.systemTemp.path, 'ecclesias_migration_test_v6_${DateTime.now().microsecondsSinceEpoch}.sqlite'),
    );
    addTearDown(() {
      if (fichier.existsSync()) fichier.deleteSync();
    });

    // Construit un vrai fichier v7 (via l'implémentation réelle), puis le
    // ramène à v6 en retirant uniquement les tables propres au Module V —
    // plus fiable qu'une retranscription manuelle du DDL v6 complet.
    final dbInitiale = AppDatabase(NativeDatabase(fichier));
    await dbInitiale.into(dbInitiale.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: 'siege-1',
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG-SIEGE',
            path: '/siege-1/',
            depth: 0,
            createdAt: DateTime(2026, 1, 1),
            updatedAt: DateTime(2026, 1, 1),
          ),
        );
    await dbInitiale.close();

    final connexionBrute = sqlite3.sqlite3.open(fichier.path);
    connexionBrute.execute('''
      DROP TABLE sollicitations;
      DROP TABLE professions_fideles;
      DROP TABLE professions;
      PRAGMA user_version = 6;
    ''');
    connexionBrute.close();

    final db = AppDatabase(NativeDatabase(fichier));

    final noeuds = await db.select(db.organisationNodes).get();
    expect(noeuds, hasLength(1));
    expect(noeuds.single.nom, 'GSG');

    // Ne doit plus lever "no such table: professions".
    final professions = await db.select(db.professions).get();
    expect(professions, hasLength(12));

    final declarations = await db.select(db.professionsFideles).get();
    expect(declarations, isEmpty);

    await db.close();
  });

  test('un fichier créé en schéma v7 reçoit les tables du Module VI et le seed RG-VI-01 à l\'ouverture', () async {
    final fichier = File(
      path.join(Directory.systemTemp.path, 'ecclesias_migration_test_v7_${DateTime.now().microsecondsSinceEpoch}.sqlite'),
    );
    addTearDown(() {
      if (fichier.existsSync()) fichier.deleteSync();
    });

    // Construit un vrai fichier v8 (via l'implémentation réelle), puis le
    // ramène à v7 en retirant uniquement les tables propres au Module VI —
    // plus fiable qu'une retranscription manuelle du DDL v7 complet.
    final dbInitiale = AppDatabase(NativeDatabase(fichier));
    await dbInitiale.into(dbInitiale.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: 'siege-1',
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG-SIEGE',
            path: '/siege-1/',
            depth: 0,
            createdAt: DateTime(2026, 1, 1),
            updatedAt: DateTime(2026, 1, 1),
          ),
        );
    await dbInitiale.close();

    final connexionBrute = sqlite3.sqlite3.open(fichier.path);
    connexionBrute.execute('''
      DROP TABLE appartenances_groupe;
      DROP TABLE groupes_eglise;
      PRAGMA user_version = 7;
    ''');
    connexionBrute.close();

    final db = AppDatabase(NativeDatabase(fichier));

    final noeuds = await db.select(db.organisationNodes).get();
    expect(noeuds, hasLength(1));
    expect(noeuds.single.nom, 'GSG');

    // Ne doit plus lever "no such table: groupes_eglise".
    final groupes = await db.select(db.groupesEglise).get();
    expect(groupes, hasLength(11));

    final appartenances = await db.select(db.appartenancesGroupe).get();
    expect(appartenances, isEmpty);

    await db.close();
  });
}
