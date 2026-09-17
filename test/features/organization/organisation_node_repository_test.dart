import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/categorie_confessionnelle.dart';
import 'package:ecclesias_360/features/organization/domain/models/statut_noeud.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late OrganisationNodeRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = OrganisationNodeRepository(db, SyncCoordinator(db));
  });

  tearDown(() => db.close());

  Future<String> creerSiege() async {
    final siege = await repository.creerNoeud(
      typeNoeud: TypeNoeud.siege,
      noeudParentId: null,
      nom: 'Global Service Groupe',
      codeInterne: 'GSG-SIEGE',
    );
    return siege.id;
  }

  group('creerNoeud', () {
    test('crée la racine (siège) sans parent, statut provisoire, profondeur 0', () async {
      final siegeId = await creerSiege();
      final siege = await repository.findById(siegeId);

      expect(siege, isNotNull);
      expect(siege!.noeudParentId, isNull);
      expect(siege.statut, StatutNoeud.provisoire);
      expect(siege.depth, 0);
      expect(siege.path, '/$siegeId/');
    });

    test('refuse un second siège (racine unique, RG-I-01)', () async {
      await creerSiege();

      expect(
        () => repository.creerNoeud(
          typeNoeud: TypeNoeud.siege,
          noeudParentId: null,
          nom: 'Autre siège',
          codeInterne: 'AUTRE-SIEGE',
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'root_already_exists')),
      );
    });

    test('crée un enfant rattaché au siège, chemin et profondeur corrects', () async {
      final siegeId = await creerSiege();
      final union = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union Afrique de l\'Ouest',
        codeInterne: 'UNION-AO',
      );

      expect(union.path, '/$siegeId/${union.id}/');
      expect(union.depth, 1);
    });

    test('refuse un code interne déjà utilisé', () async {
      final siegeId = await creerSiege();
      await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union A',
        codeInterne: 'DOUBLON',
      );

      expect(
        () => repository.creerNoeud(
          typeNoeud: TypeNoeud.union,
          noeudParentId: siegeId,
          nom: 'Union B',
          codeInterne: 'DOUBLON',
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'code_interne_already_used')),
      );
    });

    test('refuse un parent inexistant', () async {
      expect(
        () => repository.creerNoeud(
          typeNoeud: TypeNoeud.union,
          noeudParentId: 'id-inexistant',
          nom: 'Union orpheline',
          codeInterne: 'ORPHELINE',
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'parent_not_found')),
      );
    });

    test('église locale exige une catégorie confessionnelle (RG-I-09)', () async {
      final siegeId = await creerSiege();

      expect(
        () => repository.creerNoeud(
          typeNoeud: TypeNoeud.egliseLocale,
          noeudParentId: siegeId,
          nom: 'Église sans catégorie',
          codeInterne: 'EGL-SANS-CAT',
        ),
        throwsArgumentError,
      );

      final eglise = await repository.creerNoeud(
        typeNoeud: TypeNoeud.egliseLocale,
        noeudParentId: siegeId,
        nom: 'Église locale test',
        codeInterne: 'EGL-TEST',
        categorieConfessionnelle: CategorieConfessionnelle.autres,
      );
      expect(eglise.categorieConfessionnelle, CategorieConfessionnelle.autres);
    });

    test('écrit une entrée outbox à chaque création (RG-OFF-02)', () async {
      await creerSiege();
      final enAttente = await db.select(db.syncOutbox).get();
      expect(enAttente, hasLength(1));
      expect(enAttente.single.entite, 'organisation_nodes');
      expect(enAttente.single.operation, 'upsert');
    });
  });

  group('validerNoeud', () {
    test('fait passer un nœud de provisoire à actif (RG-I-08)', () async {
      final siegeId = await creerSiege();
      await repository.validerNoeud(siegeId);

      final siege = await repository.findById(siegeId);
      expect(siege!.statut, StatutNoeud.actif);
    });
  });

  group('changerRattachement', () {
    test('recompute le chemin et la profondeur du nœud déplacé et de ses descendants (RG-I-06)', () async {
      final siegeId = await creerSiege();
      final unionA = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union A',
        codeInterne: 'UNION-A',
      );
      final unionB = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union B',
        codeInterne: 'UNION-B',
      );
      final district = await repository.creerNoeud(
        typeNoeud: TypeNoeud.district,
        noeudParentId: unionA.id,
        nom: 'District 1',
        codeInterne: 'DISTRICT-1',
      );

      await repository.changerRattachement(
        noeudId: unionA.id,
        nouveauParentId: unionB.id,
        motif: 'Réorganisation test',
      );

      final unionARechargee = await repository.findById(unionA.id);
      final districtRecharge = await repository.findById(district.id);

      expect(unionARechargee!.noeudParentId, unionB.id);
      expect(unionARechargee.path, '${unionB.path}${unionA.id}/');
      expect(unionARechargee.depth, 2);
      expect(districtRecharge!.path, '${unionARechargee.path}${district.id}/');
      expect(districtRecharge.depth, 3);
    });

    test('refuse un rattachement circulaire (RG-I-06)', () async {
      final siegeId = await creerSiege();
      final union = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union',
        codeInterne: 'UNION-C',
      );
      final district = await repository.creerNoeud(
        typeNoeud: TypeNoeud.district,
        noeudParentId: union.id,
        nom: 'District',
        codeInterne: 'DISTRICT-C',
      );

      expect(
        () => repository.changerRattachement(noeudId: union.id, nouveauParentId: district.id),
        throwsArgumentError,
      );
    });

    test('trace l\'historique de rattachement', () async {
      final siegeId = await creerSiege();
      final unionA = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union A',
        codeInterne: 'UNION-HIST-A',
      );
      final unionB = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union B',
        codeInterne: 'UNION-HIST-B',
      );

      await repository.changerRattachement(
        noeudId: unionA.id,
        nouveauParentId: unionB.id,
        motif: 'Test historique',
      );

      final historique = await db.select(db.historiqueRattachements).get();
      expect(historique, hasLength(1));
      expect(historique.single.noeudId, unionA.id);
      expect(historique.single.ancienParentId, siegeId);
      expect(historique.single.nouveauParentId, unionB.id);
      expect(historique.single.motif, 'Test historique');
    });
  });

  group('supprimerNoeud', () {
    test('refuse la suppression d\'un nœud ayant des enfants (RG-I-02)', () async {
      final siegeId = await creerSiege();
      await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union',
        codeInterne: 'UNION-SUPPR',
      );

      expect(
        () => repository.supprimerNoeud(siegeId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'node_has_blocking_references')),
      );
    });

    test('autorise la suppression d\'un nœud sans rattachement', () async {
      final siegeId = await creerSiege();
      final union = await repository.creerNoeud(
        typeNoeud: TypeNoeud.union,
        noeudParentId: siegeId,
        nom: 'Union isolée',
        codeInterne: 'UNION-ISOLEE',
      );

      await repository.supprimerNoeud(union.id);

      expect(await repository.findById(union.id), isNull);
    });
  });

  group('archiverNoeud', () {
    test('fait passer un nœud au statut archivé sans le supprimer', () async {
      final siegeId = await creerSiege();
      await repository.archiverNoeud(siegeId);

      final siege = await repository.findById(siegeId);
      expect(siege!.statut, StatutNoeud.archive);
    });
  });
}
