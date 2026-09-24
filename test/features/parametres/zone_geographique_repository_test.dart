import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/audit/acteur.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/data/zone_geographique_repository.dart';
import 'package:ecclesias_360/features/parametres/data/journal_parametres_repository.dart';
import 'package:ecclesias_360/features/parametres/domain/models/entree_journal_parametres.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/features/parametres/domain/models/statut_referentiel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ZoneGeographiqueRepository repository;
  const admin = Acteur(authUserId: 'compte-admin', fideleId: 'fiche-admin', role: Role.administrateur);
  const pasteur = Acteur(authUserId: 'compte-pasteur', fideleId: 'fiche-pasteur', role: Role.pasteur);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = ZoneGeographiqueRepository(db);
  });

  tearDown(() => db.close());

  group('creer', () {
    test('une zone racine est de niveau 0', () async {
      final zone = await repository.creer(libelle: 'Togo', acteur: admin);
      expect(zone.niveau, 0);
      expect(zone.parentId, isNull);
      expect(zone.statut, StatutReferentiel.actif);
    });

    test('une sous-zone hérite du niveau parent + 1', () async {
      final pays = await repository.creer(libelle: 'Togo', acteur: admin);
      final region = await repository.creer(libelle: 'Maritime', parentId: pays.id, acteur: admin);
      expect(region.niveau, 1);
    });

    test('refuse un parent inexistant', () async {
      expect(() => repository.creer(libelle: 'X', parentId: 'inexistant', acteur: admin), throwsArgumentError);
    });
  });

  group('desactiver (RG-XXIII-03)', () {
    test('passe le statut à désactivé sans supprimer la ligne', () async {
      final zone = await repository.creer(libelle: 'Togo', acteur: admin);
      await repository.desactiver(zone.id, acteur: admin);
      final relue = await repository.findById(zone.id);
      expect(relue!.statut, StatutReferentiel.desactive);
    });
  });

  group('supprimer (RG-XXIII-03)', () {
    test('refuse la suppression si une sous-zone existe', () async {
      final pays = await repository.creer(libelle: 'Togo', acteur: admin);
      await repository.creer(libelle: 'Maritime', parentId: pays.id, acteur: admin);

      expect(
        () => repository.supprimer(pays.id, acteur: admin),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'referentiel_en_usage')),
      );
    });

    test('refuse la suppression si un nœud organisationnel l\'utilise', () async {
      final zone = await repository.creer(libelle: 'Togo', acteur: admin);
      await db
          .into(db.organisationNodes)
          .insert(
            OrganisationNodesCompanion.insert(
              id: 'noeud-1',
              typeNoeud: 'siege',
              nom: 'GSG',
              codeInterne: 'GSG',
              path: '/noeud-1/',
              depth: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              zoneGeoId: Value(zone.id),
            ),
          );

      expect(
        () => repository.supprimer(zone.id, acteur: admin),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'referentiel_en_usage')),
      );
    });

    test('autorise la suppression sans usage', () async {
      final zone = await repository.creer(libelle: 'Togo', acteur: admin);
      await repository.supprimer(zone.id, acteur: admin);
      expect(await repository.findById(zone.id), isNull);
    });
  });

  group('RG-XXIII-06 — réservé à l\'administrateur, historisé', () {
    test('un pasteur ne crée, ne désactive ni ne supprime une zone, et rien n\'est journalisé', () async {
      final zone = await repository.creer(libelle: 'Togo', acteur: admin);
      final avant = (await db.select(db.journalParametres).get()).length;

      for (final action in [
        () => repository.creer(libelle: 'Bénin', acteur: pasteur),
        () => repository.desactiver(zone.id, acteur: pasteur),
        () => repository.supprimer(zone.id, acteur: pasteur),
      ]) {
        await expectLater(
          action(),
          throwsA(isA<AppError>().having((e) => e.code, 'code', 'administration_parametres_reservee')),
        );
      }
      expect((await repository.findById(zone.id))!.statut, StatutReferentiel.actif);
      expect((await db.select(db.journalParametres).get()).length, avant);
    });

    test('création, désactivation et suppression tracent auteur, date et valeur précédente', () async {
      final zone = await repository.creer(libelle: 'Togo', acteur: admin);
      await repository.desactiver(zone.id, acteur: admin);
      await repository.supprimer(zone.id, acteur: admin);

      final journal = (await JournalParametresRepository(db).watchJournal().first).reversed.toList();
      expect(journal.map((e) => e.action), [
        ActionJournalParametres.creation,
        ActionJournalParametres.modification,
        ActionJournalParametres.suppression,
      ]);
      expect(journal.every((e) => e.auteurAuthUserId == 'compte-admin' && e.auteurFideleId == 'fiche-admin'), isTrue);
      expect(journal[0].ancienneValeur, isNull);
      expect(journal[0].nouvelleValeur, contains('"statut":"actif"'));
      expect(journal[1].ancienneValeur, contains('"statut":"actif"'));
      expect(journal[1].nouvelleValeur, contains('"statut":"desactive"'));
      expect(journal[2].ancienneValeur, contains('"libelle":"Togo"'));
      expect(journal[2].nouvelleValeur, isNull);
    });
  });
}
