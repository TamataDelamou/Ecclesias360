import 'package:drift/native.dart';
import 'package:ecclesias_360/features/dons_spirituels/data/don_spirituel_repository.dart';
import 'package:ecclesias_360/features/dons_spirituels/domain/models/niveau_maturite.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DonSpirituelRepository repository;
  late String noeudId;
  late String fideleId;
  late String pasteurId;
  late String prophetieId;
  late String typeChoraleId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DonSpirituelRepository(db);

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
    pasteurId = 'fidele-2';
    for (final id in [fideleId, pasteurId]) {
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

    final prophetieRow =
        await (db.select(db.donsSpirituels)..where((t) => t.code.equals('prophetie'))).getSingle();
    prophetieId = prophetieRow.id;

    final typeChoraleRow =
        await (db.select(db.typesMinisteres)..where((t) => t.code.equals('chorale'))).getSingle();
    typeChoraleId = typeChoraleRow.id;
  });

  tearDown(() => db.close());

  test('la base seed bien les 9 dons spirituels standards (RG-IV-04)', () async {
    final dons = await db.select(db.donsSpirituels).get();
    expect(dons, hasLength(9));
  });

  group('evaluer (RG-IV-01/02)', () {
    test('crée une évaluation liée au fidèle, au don et au responsable de suivi', () async {
      final evaluation = await repository.evaluer(
        fideleId: fideleId,
        donId: prophetieId,
        niveauMaturite: NiveauMaturite.emergent,
        responsableSuiviId: pasteurId,
        observations: 'Première observation',
      );
      expect(evaluation.fideleId, fideleId);
      expect(evaluation.donId, prophetieId);
      expect(evaluation.niveauMaturite, NiveauMaturite.emergent);
      expect(evaluation.responsableSuiviId, pasteurId);
    });

    test('une nouvelle évaluation ne remplace jamais la précédente (append-only)', () async {
      await repository.evaluer(
        fideleId: fideleId,
        donId: prophetieId,
        niveauMaturite: NiveauMaturite.emergent,
        responsableSuiviId: pasteurId,
      );
      await repository.evaluer(
        fideleId: fideleId,
        donId: prophetieId,
        niveauMaturite: NiveauMaturite.confirme,
        responsableSuiviId: pasteurId,
      );

      final evaluations = await repository.watchEvaluations(fideleId).first;
      expect(evaluations, hasLength(2));
    });
  });

  group('watchCorrespondances / ajouterCorrespondance (RG-IV-03)', () {
    test('aucune correspondance par défaut', () async {
      final correspondances = await repository.watchCorrespondances(prophetieId).first;
      expect(correspondances, isEmpty);
    });

    test('ajoute une correspondance don <-> type de ministère', () async {
      await repository.ajouterCorrespondance(donId: prophetieId, typeMinistereId: typeChoraleId);
      final correspondances = await repository.watchCorrespondances(prophetieId).first;
      expect(correspondances, hasLength(1));
      expect(correspondances.single.typeMinistereId, typeChoraleId);
    });
  });
}
