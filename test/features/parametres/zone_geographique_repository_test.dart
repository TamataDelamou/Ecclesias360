import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/data/zone_geographique_repository.dart';
import 'package:ecclesias_360/features/parametres/domain/models/statut_referentiel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ZoneGeographiqueRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = ZoneGeographiqueRepository(db);
  });

  tearDown(() => db.close());

  group('creer', () {
    test('une zone racine est de niveau 0', () async {
      final zone = await repository.creer(libelle: 'Togo');
      expect(zone.niveau, 0);
      expect(zone.parentId, isNull);
      expect(zone.statut, StatutReferentiel.actif);
    });

    test('une sous-zone hérite du niveau parent + 1', () async {
      final pays = await repository.creer(libelle: 'Togo');
      final region = await repository.creer(libelle: 'Maritime', parentId: pays.id);
      expect(region.niveau, 1);
    });

    test('refuse un parent inexistant', () async {
      expect(() => repository.creer(libelle: 'X', parentId: 'inexistant'), throwsArgumentError);
    });
  });

  group('desactiver (RG-XXIII-03)', () {
    test('passe le statut à désactivé sans supprimer la ligne', () async {
      final zone = await repository.creer(libelle: 'Togo');
      await repository.desactiver(zone.id);
      final relue = await repository.findById(zone.id);
      expect(relue!.statut, StatutReferentiel.desactive);
    });
  });

  group('supprimer (RG-XXIII-03)', () {
    test('refuse la suppression si une sous-zone existe', () async {
      final pays = await repository.creer(libelle: 'Togo');
      await repository.creer(libelle: 'Maritime', parentId: pays.id);

      expect(
        () => repository.supprimer(pays.id),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'referentiel_en_usage')),
      );
    });

    test('refuse la suppression si un nœud organisationnel l\'utilise', () async {
      final zone = await repository.creer(libelle: 'Togo');
      await db.into(db.organisationNodes).insert(
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
        () => repository.supprimer(zone.id),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'referentiel_en_usage')),
      );
    });

    test('autorise la suppression sans usage', () async {
      final zone = await repository.creer(libelle: 'Togo');
      await repository.supprimer(zone.id);
      expect(await repository.findById(zone.id), isNull);
    });
  });
}
