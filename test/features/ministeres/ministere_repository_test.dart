import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/ministeres/data/ministere_repository.dart';
import 'package:ecclesias_360/features/ministeres/domain/models/activite_ministere.dart';
import 'package:ecclesias_360/features/ministeres/domain/models/role_affectation.dart';
import 'package:ecclesias_360/features/ministeres/domain/models/statut_affectation.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late MinistereRepository repository;
  late String noeudId;
  late String typeChoraleId;
  late String fideleId;
  late String fidele2Id;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = MinistereRepository(db, SyncCoordinator(db));

    noeudId = 'noeud-1';
    await db.into(db.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: noeudId,
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG',
            path: '/$noeudId/',
            depth: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

    fideleId = 'fidele-1';
    fidele2Id = 'fidele-2';
    for (final id in [fideleId, fidele2Id]) {
      await db.into(db.fideles).insert(
            FidelesCompanion.insert(
              id: id,
              noeudId: noeudId,
              nom: 'Doe',
              prenoms: 'Jean',
              dateNaissance: DateTime(1980, 1, 1),
              sexe: 'masculin',
              statutCivil: 'celibataire',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
    }

    final typeRow = await (db.select(db.typesMinisteres)..where((t) => t.code.equals('chorale'))).getSingle();
    typeChoraleId = typeRow.id;
  });

  tearDown(() => db.close());

  test('la base seed bien les 24 types de ministères standards (RG-III-04)', () async {
    final types = await db.select(db.typesMinisteres).get();
    expect(types.where((t) => t.standard).length, 24);
  });

  group('creerMinistere', () {
    test('crée un ministère rattaché au nœud et au type donnés', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale principale',
      );
      expect(ministere.noeudId, noeudId);
      expect(ministere.typeMinistereId, typeChoraleId);
      expect(ministere.statut.code, 'actif');
    });
  });

  group('affecter (RG-III-01)', () {
    test('affecte un fidèle comme membre', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      final affectation = await repository.affecter(
        ministereId: ministere.id,
        fideleId: fideleId,
        role: RoleAffectation.membre,
      );
      expect(affectation.role, RoleAffectation.membre);
      expect(affectation.statut, StatutAffectation.active);
    });

    test('affecte un premier responsable et ouvre un mandat', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      await repository.affecter(
        ministereId: ministere.id,
        fideleId: fideleId,
        role: RoleAffectation.responsable,
        dateFinPrevue: DateTime(2030, 1, 1),
      );

      final mandats = await repository.watchMandats(ministere.id).first;
      expect(mandats, hasLength(1));
      expect(mandats.first.estActif, isTrue);
      expect(mandats.first.dateFinPrevue, DateTime(2030, 1, 1));
    });

    test('refuse un second responsable actif simultané', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      await repository.affecter(ministereId: ministere.id, fideleId: fideleId, role: RoleAffectation.responsable);

      expect(
        () => repository.affecter(ministereId: ministere.id, fideleId: fidele2Id, role: RoleAffectation.responsable),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'responsable_ministere_deja_actif')),
      );
    });
  });

  group('retirerAffectation', () {
    test('clôture l\'affectation et le mandat de responsable associé', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      final affectation =
          await repository.affecter(ministereId: ministere.id, fideleId: fideleId, role: RoleAffectation.responsable);

      await repository.retirerAffectation(affectation.id);

      final affectations = await repository.watchAffectations(ministere.id).first;
      expect(affectations.single.statut, StatutAffectation.terminee);

      final mandats = await repository.watchMandats(ministere.id).first;
      expect(mandats.single.estActif, isFalse);
    });

    test('un nouveau responsable peut être affecté après clôture du précédent mandat', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      final premiere =
          await repository.affecter(ministereId: ministere.id, fideleId: fideleId, role: RoleAffectation.responsable);
      await repository.retirerAffectation(premiere.id);

      final seconde = await repository.affecter(
        ministereId: ministere.id,
        fideleId: fidele2Id,
        role: RoleAffectation.responsable,
      );
      expect(seconde.statut, StatutAffectation.active);
    });
  });

  group('suspendreAffectationsActives / reintegrerAffectations (RG-III-03)', () {
    test('suspend puis réintègre les affectations actives d\'un fidèle', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      await repository.affecter(ministereId: ministere.id, fideleId: fideleId, role: RoleAffectation.membre);

      await repository.suspendreAffectationsActives(fideleId);
      var affectations = await repository.watchAffectations(ministere.id).first;
      expect(affectations.single.statut, StatutAffectation.suspendue);

      await repository.reintegrerAffectations(fideleId);
      affectations = await repository.watchAffectations(ministere.id).first;
      expect(affectations.single.statut, StatutAffectation.active);
    });
  });

  group('desactiverType (RG-III-04)', () {
    test('refuse la désactivation d\'un type standard', () async {
      expect(
        () => repository.desactiverType(typeChoraleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'type_ministere_standard_protege')),
      );
    });

    test('autorise la désactivation d\'un type personnalisé', () async {
      final type = await repository.creerTypePersonnalise(libelle: 'Ministère des sourds-muets', code: 'sourds_muets');
      await repository.desactiverType(type.id);
      final types = await repository.watchTypes().first;
      final relu = types.firstWhere((t) => t.id == type.id);
      expect(relu.statut.code, 'desactive');
    });
  });

  group('ajouterActivite (RG-III-05)', () {
    test('journalise une activité de ministère', () async {
      final ministere = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      await repository.ajouterActivite(
        ministereId: ministere.id,
        type: TypeActiviteMinistere.reunion,
        description: 'Répétition hebdomadaire',
        auteurFideleId: fideleId,
      );

      final activites = await repository.watchActivites(ministere.id).first;
      expect(activites.single.description, 'Répétition hebdomadaire');
      expect(activites.single.type, TypeActiviteMinistere.reunion);
    });
  });

  group('mandatsOuverts (RG-III-02)', () {
    test('ne retourne que les mandats non clos, tous ministères confondus', () async {
      final ministere1 = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Chorale',
      );
      final ministere2 = await repository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeChoraleId,
        nom: 'Louange',
      );
      final affectation1 = await repository.affecter(
        ministereId: ministere1.id,
        fideleId: fideleId,
        role: RoleAffectation.responsable,
      );
      await repository.affecter(ministereId: ministere2.id, fideleId: fidele2Id, role: RoleAffectation.responsable);
      await repository.retirerAffectation(affectation1.id);

      final ouverts = await repository.mandatsOuverts();
      expect(ouverts, hasLength(1));
      expect(ouverts.single.ministereId, ministere2.id);
    });
  });
}
