import 'package:drift/native.dart';
import 'package:ecclesias_360/core/audit/acteur.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/data/notes_pastorales_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

/// RG-II-11 — les notes pastorales sont vérifiées et journalisées dans le
/// dépôt, avec l'acteur de la session : un écran contourné (route directe)
/// ne contourne rien.
void main() {
  late AppDatabase db;
  late FideleRepository fideles;
  late NotesPastoralesRepository repository;
  late String pasteurId;
  late String autrePasteurId;
  late String fideleId;
  late String responsableId;

  Acteur acteur(String fiche, Role role) => Acteur(authUserId: 'compte-$fiche', fideleId: fiche, role: role);
  Matcher refus(String code) => throwsA(isA<AppError>().having((e) => e.code, 'code', code));

  Future<void> noeud(String id) => db.into(db.organisationNodes).insert(
        OrganisationNodesCompanion.insert(
          id: id,
          typeNoeud: 'eglise_locale',
          nom: id,
          codeInterne: id,
          path: '/$id/',
          depth: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    fideles = FideleRepository(db, SyncCoordinator(db));
    repository = NotesPastoralesRepository(db);
    await noeud('e1');
    await noeud('e2');
    Future<String> fiche(String prenoms) async => (await fideles.creerFidele(
          noeudId: 'e1',
          nom: 'Doe',
          prenoms: prenoms,
          dateNaissance: DateTime(1980, 1, 1),
          sexe: Sexe.masculin,
          statutCivil: StatutCivil.marie,
        ))
            .id;
    pasteurId = await fiche('Pasteur');
    autrePasteurId = await fiche('Autre');
    fideleId = await fiche('Fidele');
    responsableId = await fiche('Responsable');
  });

  tearDown(() => db.close());

  test('rédaction : l\'auteur est la session, le nœud est figé à celui du fidèle', () async {
    final note = await repository.rediger(
      acteur: acteur(pasteurId, Role.pasteur),
      fideleId: fideleId,
      contenu: '  Visite à domicile  ',
    );
    expect(note.auteurFideleId, pasteurId);
    expect(note.noeudId, 'e1');
    expect(note.contenu, 'Visite à domicile');

    // Mutation ultérieure du fidèle : la note reste au nœud de rédaction.
    await fideles.changerNoeud(fideleId: fideleId, nouveauNoeudId: 'e2');
    final relue = await repository.consulter(acteur: acteur(pasteurId, Role.pasteur), noteId: note.id);
    expect(relue!.noeudId, 'e1');
  });

  test('rédaction refusée : responsable, compte sans fiche, sur sa propre fiche', () async {
    await expectLater(
      repository.rediger(acteur: acteur(responsableId, Role.responsable), fideleId: fideleId, contenu: 'x'),
      refus('note_pastorale_redaction_reservee'),
    );
    await expectLater(
      repository.rediger(
        acteur: const Acteur(authUserId: 'admin', fideleId: null, role: Role.administrateur),
        fideleId: fideleId,
        contenu: 'x',
      ),
      refus('note_pastorale_redaction_reservee'),
    );
    await expectLater(
      repository.rediger(acteur: acteur(pasteurId, Role.pasteur), fideleId: pasteurId, contenu: 'x'),
      refus('note_pastorale_redaction_reservee'),
    );
    expect(await db.select(db.notesPastorales).get(), isEmpty);
  });

  group('lecture', () {
    late String noteId;

    setUp(() async {
      noteId = (await repository.rediger(acteur: acteur(pasteurId, Role.pasteur), fideleId: fideleId, contenu: 'Secret'))
          .id;
    });

    test('la liste n\'expose que l\'auteur et les dates, et n\'est pas journalisée', () async {
      final notes = await repository.watchNotesDuFidele(acteur: acteur(autrePasteurId, Role.pasteur), fideleId: fideleId).first;
      expect(notes.single.auteurFideleId, pasteurId);
      expect(await db.select(db.consultationsNotesPastorales).get(), isEmpty);
    });

    test('chaque ouverture est journalisée avec le compte, la fiche et le rôle', () async {
      final lecteur = acteur(autrePasteurId, Role.pasteur);
      expect((await repository.consulter(acteur: lecteur, noteId: noteId))!.contenu, 'Secret');
      await repository.consulter(acteur: lecteur, noteId: noteId);

      final journal = await repository.watchConsultations(acteur: acteur(pasteurId, Role.pasteur), noteId: noteId).first;
      expect(journal, hasLength(2));
      expect(journal.first.authUserId, 'compte-$autrePasteurId');
      expect(journal.first.fideleId, autrePasteurId);
      expect(journal.first.role, Role.pasteur);
    });

    test('le fidèle concerné, même pasteur, n\'ouvre ni la note, ni la liste, ni le journal — rien n\'est journalisé',
        () async {
      final concerne = acteur(fideleId, Role.pasteur);
      await expectLater(repository.consulter(acteur: concerne, noteId: noteId), refus('note_pastorale_acces_refuse'));
      await expectLater(
        repository.watchNotesDuFidele(acteur: concerne, fideleId: fideleId).first,
        refus('note_pastorale_acces_refuse'),
      );
      await expectLater(
        repository.watchConsultations(acteur: concerne, noteId: noteId).first,
        refus('note_pastorale_acces_refuse'),
      );
      expect(await db.select(db.consultationsNotesPastorales).get(), isEmpty);
    });

    test('un responsable n\'ouvre rien', () async {
      final responsable = acteur(responsableId, Role.responsable);
      await expectLater(repository.consulter(acteur: responsable, noteId: noteId), refus('note_pastorale_acces_refuse'));
      await expectLater(
        repository.watchNotesDuFidele(acteur: responsable, fideleId: fideleId).first,
        refus('note_pastorale_acces_refuse'),
      );
    });

    test('l\'administrateur lit par son rang, même sans fiche', () async {
      const admin = Acteur(authUserId: 'admin', fideleId: null, role: Role.administrateur);
      expect((await repository.consulter(acteur: admin, noteId: noteId))!.contenu, 'Secret');
      expect((await db.select(db.consultationsNotesPastorales).getSingle()).fideleId, isNull);
    });

    test('modification par l\'auteur seul', () async {
      final modifiee =
          await repository.modifier(acteur: acteur(pasteurId, Role.pasteur), noteId: noteId, contenu: 'Complétée');
      expect(modifiee.contenu, 'Complétée');
      await expectLater(
        repository.modifier(acteur: acteur(autrePasteurId, Role.pasteur), noteId: noteId, contenu: 'Réécrite'),
        refus('note_pastorale_modification_reservee'),
      );
      await expectLater(
        repository.modifier(
          acteur: const Acteur(authUserId: 'admin', fideleId: null, role: Role.administrateur),
          noteId: noteId,
          contenu: 'Réécrite',
        ),
        refus('note_pastorale_modification_reservee'),
      );
    });
  });
}
