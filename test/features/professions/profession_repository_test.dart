import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/professions/data/profession_repository.dart';
import 'package:ecclesias_360/features/professions/domain/models/statut_verification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProfessionRepository repository;
  late String noeudId;
  late String fideleId;
  late String fidele2Id;
  late String ingenieurId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = ProfessionRepository(db);

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

    final ingenieurRow =
        await (db.select(db.professions)..where((t) => t.code.equals('ingenieur'))).getSingle();
    ingenieurId = ingenieurRow.id;
  });

  tearDown(() => db.close());

  test('la base seed bien les professions de départ (RG-V-02)', () async {
    final professions = await db.select(db.professions).get();
    expect(professions, hasLength(12));
  });

  group('declarerProfession / verifierDeclaration (RG-V-01)', () {
    test('une déclaration commence au statut declare', () async {
      final declaration = await repository.declarerProfession(
        fideleId: fideleId,
        professionId: ingenieurId,
        anneesExperience: 5,
      );
      expect(declaration.statutVerification, StatutVerification.declare);
      expect(declaration.anneesExperience, 5);
    });

    test('la vérification passe le statut à verifie', () async {
      final declaration = await repository.declarerProfession(fideleId: fideleId, professionId: ingenieurId);
      await repository.verifierDeclaration(declaration.id);

      final declarations = await repository.watchDeclarations(fideleId).first;
      expect(declarations.single.statutVerification, StatutVerification.verifie);
    });
  });

  group('supprimerProfession (RG-V-02)', () {
    test('refuse la suppression si des déclarations existent', () async {
      await repository.declarerProfession(fideleId: fideleId, professionId: ingenieurId);
      expect(
        () => repository.supprimerProfession(ingenieurId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'referentiel_en_usage')),
      );
    });

    test('autorise la suppression sans déclaration', () async {
      await repository.supprimerProfession(ingenieurId);
      expect(await repository.findProfessionById(ingenieurId), isNull);
    });
  });

  group('solliciterGroupe (RG-V-03)', () {
    test('ne sollicite que les déclarations vérifiées', () async {
      final d1 = await repository.declarerProfession(fideleId: fideleId, professionId: ingenieurId);
      await repository.declarerProfession(fideleId: fidele2Id, professionId: ingenieurId);
      await repository.verifierDeclaration(d1.id);

      final nombreSollicites = await repository.solliciterGroupe(
        professionId: ingenieurId,
        objet: 'Projet de construction du temple',
      );
      expect(nombreSollicites, 1);

      final sollicitations1 = await repository.watchSollicitations(fideleId).first;
      expect(sollicitations1, hasLength(1));
      final sollicitations2 = await repository.watchSollicitations(fidele2Id).first;
      expect(sollicitations2, isEmpty);
    });

    test('repondreSollicitation trace la réponse', () async {
      final declaration = await repository.declarerProfession(fideleId: fideleId, professionId: ingenieurId);
      await repository.verifierDeclaration(declaration.id);
      await repository.solliciterGroupe(professionId: ingenieurId, objet: 'Action sociale');

      final sollicitation = (await repository.watchSollicitations(fideleId).first).single;
      await repository.repondreSollicitation(sollicitation.id, 'Disponible');

      final relue = (await repository.watchSollicitations(fideleId).first).single;
      expect(relue.reponse, 'Disponible');
    });
  });
}
