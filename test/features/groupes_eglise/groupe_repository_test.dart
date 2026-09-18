import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/groupes_eglise/data/groupe_repository.dart';
import 'package:ecclesias_360/features/groupes_eglise/domain/models/origine_appartenance.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late GroupeRepository repository;
  late String noeudId;
  late String celibatairesId;
  late String femmesId;
  late String pasteursId;

  Future<String> creerFidele({
    required String id,
    Sexe sexe = Sexe.masculin,
    StatutCivil statutCivil = StatutCivil.celibataire,
    DateTime? dateNaissance,
  }) async {
    await db.into(db.fideles).insert(
          FidelesCompanion.insert(
            id: id,
            noeudId: noeudId,
            nom: 'Doe',
            prenoms: 'Jean',
            dateNaissance: dateNaissance ?? DateTime(1990, 1, 1),
            sexe: sexe.code,
            statutCivil: statutCivil.code,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
    return id;
  }

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = GroupeRepository(db);

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

    final celibatairesRow =
        await (db.select(db.groupesEglise)..where((t) => t.code.equals('celibataires'))).getSingle();
    celibatairesId = celibatairesRow.id;
    final femmesRow = await (db.select(db.groupesEglise)..where((t) => t.code.equals('femmes'))).getSingle();
    femmesId = femmesRow.id;
    final pasteursRow =
        await (db.select(db.groupesEglise)..where((t) => t.code.equals('pasteurs'))).getSingle();
    pasteursId = pasteursRow.id;
  });

  tearDown(() => db.close());

  test('la base seed bien les 11 groupes de départ (RG-VI-01)', () async {
    final groupes = await db.select(db.groupesEglise).get();
    expect(groupes, hasLength(11));
    expect(groupes.where((g) => g.typeRegle == 'auto').length, 7);
    expect(groupes.where((g) => g.typeRegle == 'manuel').length, 4);
  });

  group('recalculerAppartenancesAuto (RG-VI-01)', () {
    test('ajoute les fidèles correspondant aux critères', () async {
      await creerFidele(id: 'f1', statutCivil: StatutCivil.celibataire);
      await creerFidele(id: 'f2', statutCivil: StatutCivil.marie);

      await repository.recalculerAppartenancesAuto(celibatairesId);

      final membres = await repository.watchMembres(celibatairesId).first;
      expect(membres, hasLength(1));
      expect(membres.single.fideleId, 'f1');
      expect(membres.single.origine, OrigineAppartenance.auto);
    });

    test('retire une ligne auto dont le fidèle ne correspond plus, garde les lignes manuelles', () async {
      await creerFidele(id: 'f1', statutCivil: StatutCivil.celibataire);
      await repository.recalculerAppartenancesAuto(celibatairesId);
      expect(await repository.watchMembres(celibatairesId).first, hasLength(1));

      // Le fidèle se marie : il ne correspond plus au critère "célibataire".
      await (db.update(db.fideles)..where((t) => t.id.equals('f1'))).write(
        const FidelesCompanion(statutCivil: Value('marie')),
      );
      await repository.recalculerAppartenancesAuto(celibatairesId);

      expect(await repository.watchMembres(celibatairesId).first, isEmpty);
    });

    test('ne touche jamais une ligne manuelle même si elle contredit les critères', () async {
      await creerFidele(id: 'f1', sexe: Sexe.masculin);
      // Dérogation tracée : affecte manuellement un homme au groupe "Femmes".
      await repository.affecterManuellement(fideleId: 'f1', groupeId: femmesId, motifDerogation: 'Cas particulier');

      await repository.recalculerAppartenancesAuto(femmesId);

      final membres = await repository.watchMembres(femmesId).first;
      expect(membres, hasLength(1));
      expect(membres.single.origine, OrigineAppartenance.manuel);
    });
  });

  group('affecterManuellement (RG-VI-01)', () {
    test('autorisé sans motif sur un groupe purement manuel', () async {
      await creerFidele(id: 'f1');
      final appartenance = await repository.affecterManuellement(fideleId: 'f1', groupeId: pasteursId);
      expect(appartenance.origine, OrigineAppartenance.manuel);
    });

    test('refuse sans motif si le fidèle ne correspond pas aux critères d\'un groupe auto', () async {
      await creerFidele(id: 'f1', sexe: Sexe.masculin);
      expect(
        () => repository.affecterManuellement(fideleId: 'f1', groupeId: femmesId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'derogation_requise_pour_affectation_manuelle')),
      );
    });

    test('autorisé avec motif de dérogation même si non conforme aux critères', () async {
      await creerFidele(id: 'f1', sexe: Sexe.masculin);
      final appartenance = await repository.affecterManuellement(
        fideleId: 'f1',
        groupeId: femmesId,
        motifDerogation: 'Décision pastorale tracée',
      );
      expect(appartenance.motifDerogation, 'Décision pastorale tracée');
    });

    test('RG-VI-02 — un fidèle peut appartenir à plusieurs groupes non exclusifs', () async {
      await creerFidele(id: 'f1', statutCivil: StatutCivil.celibataire);
      await repository.affecterManuellement(fideleId: 'f1', groupeId: celibatairesId);
      await repository.affecterManuellement(fideleId: 'f1', groupeId: pasteursId);

      final appartenances = await repository.watchAppartenances('f1').first;
      expect(appartenances, hasLength(2));
    });
  });

  group('retirerAppartenance', () {
    test('supprime la ligne', () async {
      await creerFidele(id: 'f1');
      final appartenance = await repository.affecterManuellement(fideleId: 'f1', groupeId: pasteursId);
      await repository.retirerAppartenance(appartenance.id);
      expect(await repository.watchAppartenances('f1').first, isEmpty);
    });
  });
}
