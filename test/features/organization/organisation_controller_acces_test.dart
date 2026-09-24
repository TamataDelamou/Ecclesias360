import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/audit/acteur.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/organization/application/organisation_controller.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/categorie_confessionnelle.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:ecclesias_360/features/parametres/application/capacites_controller.dart';
import 'package:ecclesias_360/features/parametres/data/referential/roles_referential.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

/// Module I — l'habilitation est vérifiée par `OrganisationController`
/// avant tout appel au dépôt : un appel qui contourne l'écran est refusé de
/// la même façon (même principe que le Module II).
void main() {
  late AppDatabase db;
  late OrganisationController controller;
  const siegeId = 'siege-1';

  Acteur acteur(Role role) => Acteur(authUserId: 'compte-${role.code}', fideleId: null, role: role);

  Future<int> nombreDeNoeuds() async => (await db.select(db.organisationNodes).get()).length;

  OrganisationController controleur({RolesReferential? capacites}) => OrganisationController(
    OrganisationNodeRepository(db, SyncCoordinator(db)),
    CapacitesController(
      referentiel: capacites ?? const RolesReferential({Capacites.creerNoeudNiveauSuperieur: Role.administrateur}),
    ),
  );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await db.into(db.organisationNodes).insert(
      OrganisationNodesCompanion.insert(
        id: siegeId,
        typeNoeud: 'siege',
        nom: 'GSG',
        codeInterne: 'GSG',
        path: '/$siegeId/',
        depth: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    controller = controleur();
  });

  tearDown(() async {
    controller.dispose();
    await db.close();
  });

  test('un membre ne crée, ne modifie ni n\'archive un nœud : rien n\'est écrit', () async {
    final avant = await nombreDeNoeuds();

    expect(
      await controller.creerNoeud(
        typeNoeud: TypeNoeud.egliseLocale,
        noeudParentId: siegeId,
        nom: 'Église A',
        codeInterne: 'EA',
        categorieConfessionnelle: CategorieConfessionnelle.autres,
        acteur: acteur(Role.membre),
      ),
      isFalse,
    );
    expect(await controller.modifierInfosNoeud(id: siegeId, nom: 'Autre', acteur: acteur(Role.membre)), isFalse);
    expect(await controller.archiverNoeud(siegeId, acteur: acteur(Role.membre)), isFalse);

    expect(await nombreDeNoeuds(), avant);
    final siege = await (db.select(db.organisationNodes)..where((t) => t.id.equals(siegeId))).getSingle();
    expect(siege.nom, 'GSG');
    expect(siege.statut, isNot('archive'));
  });

  test('RG-I-03 : un responsable crée une église locale, jamais un niveau supérieur', () async {
    expect(
      await controller.creerNoeud(
        typeNoeud: TypeNoeud.district,
        noeudParentId: siegeId,
        nom: 'District',
        codeInterne: 'D1',
        acteur: acteur(Role.responsable),
      ),
      isFalse,
    );
    expect(controller.erreur, contains('RG-I-03'));

    expect(
      await controller.creerNoeud(
        typeNoeud: TypeNoeud.egliseLocale,
        noeudParentId: siegeId,
        nom: 'Église A',
        codeInterne: 'EA',
        categorieConfessionnelle: CategorieConfessionnelle.autres,
        acteur: acteur(Role.responsable),
      ),
      isTrue,
    );
  });

  test('RG-I-03 : la validation relit le type dans le dépôt et suit le même seuil', () async {
    await db.into(db.organisationNodes).insert(
      OrganisationNodesCompanion.insert(
        id: 'district-1',
        typeNoeud: 'district',
        nom: 'District',
        codeInterne: 'D1',
        noeudParentId: const Value(siegeId),
        path: '/$siegeId/district-1/',
        depth: 1,
        statut: const Value('provisoire'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    expect(await controller.validerNoeud('district-1', acteur: acteur(Role.pasteur)), isFalse);
    expect(await controller.validerNoeud('district-1', acteur: acteur(Role.administrateur)), isTrue);
  });

  test('capacité refusée tant que roles.json ne la déclare pas : même un administrateur ne crée pas la racine', () async {
    await db.delete(db.organisationNodes).go();
    final sansCapacite = controleur(capacites: const RolesReferential({}));
    addTearDown(sansCapacite.dispose);

    expect(
      await sansCapacite.creerNoeud(
        typeNoeud: TypeNoeud.siege,
        noeudParentId: null,
        nom: 'GSG',
        codeInterne: 'GSG',
        acteur: acteur(Role.administrateur),
      ),
      isFalse,
    );
    expect(await nombreDeNoeuds(), 0);
  });

  test('désignation des responsables au rang pasteur, suppression à l\'administrateur', () async {
    expect(
      await controller.affecterResponsable(
        noeudId: siegeId,
        fideleId: 'f1',
        fonction: 'secrétaire',
        acteur: acteur(Role.responsable),
      ),
      isFalse,
    );
    expect(await db.select(db.nodeResponsables).get(), isEmpty);
    expect(await controller.supprimerNoeud(siegeId, acteur: acteur(Role.pasteur)), isFalse);
    expect(await nombreDeNoeuds(), 1);
  });
}
