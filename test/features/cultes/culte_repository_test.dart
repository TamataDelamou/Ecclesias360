import 'package:drift/native.dart';
import 'package:ecclesias_360/features/cultes/data/culte_repository.dart';
import 'package:ecclesias_360/features/cultes/domain/models/mode_presence.dart';
import 'package:ecclesias_360/features/cultes/domain/models/statut_culte.dart';
import 'package:ecclesias_360/features/cultes/domain/models/statut_proposition.dart';
import 'package:ecclesias_360/features/cultes/domain/models/valeur_vote.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CulteRepository repository;
  late String noeudId;
  late String fideleId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = CulteRepository(db);

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
    await db.into(db.fideles).insert(
          FidelesCompanion.insert(
            id: fideleId,
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
  });

  tearDown(() => db.close());

  group('creerCulte (RG-XII-01)', () {
    test('crée un culte planifié en mode nominal par défaut', () async {
      final culte = await repository.creerCulte(
        noeudId: noeudId,
        dateHeure: DateTime(2026, 6, 7, 10),
        typeCulte: 'Culte dominical',
      );
      expect(culte.statut, StatutCulte.planifie);
      expect(culte.modePresence, ModePresence.nominal);
      expect(culte.serieRecurrenteId, isNull);
    });
  });

  group('creerSerieRecurrente (RG-XII-05)', () {
    test('crée une occurrence par date générée, regroupées sous un même identifiant de série', () async {
      final cultes = await repository.creerSerieRecurrente(
        noeudId: noeudId,
        premiereDateHeure: DateTime(2026, 1, 4, 10),
        typeCulte: 'Culte dominical',
        nombreOccurrences: 4,
      );
      expect(cultes, hasLength(4));
      final serieId = cultes.first.serieRecurrenteId;
      expect(serieId, isNotNull);
      expect(cultes.every((c) => c.serieRecurrenteId == serieId), isTrue);
    });
  });

  group('présences (RG-XII-02) — modes mutuellement exclusifs', () {
    test('ajoute une présence nominale sur un culte en mode nominal', () async {
      final culte = await repository.creerCulte(
        noeudId: noeudId,
        dateHeure: DateTime(2026, 6, 7, 10),
        typeCulte: 'Culte dominical',
        modePresence: ModePresence.nominal,
      );
      await repository.ajouterPresenceNominale(culteId: culte.id, fideleId: fideleId);
      final presences = await repository.watchPresences(culte.id).first;
      expect(presences, hasLength(1));
    });

    test('refuse une présence nominale sur un culte en mode global', () async {
      final culte = await repository.creerCulte(
        noeudId: noeudId,
        dateHeure: DateTime(2026, 6, 7, 10),
        typeCulte: 'Culte dominical',
        modePresence: ModePresence.global,
      );
      await expectLater(
        repository.ajouterPresenceNominale(culteId: culte.id, fideleId: fideleId),
        throwsA(isA<Exception>()),
      );
    });

    test('refuse un compte global sur un culte en mode nominal', () async {
      final culte = await repository.creerCulte(
        noeudId: noeudId,
        dateHeure: DateTime(2026, 6, 7, 10),
        typeCulte: 'Culte dominical',
        modePresence: ModePresence.nominal,
      );
      await expectLater(
        repository.definirCompteGlobalPresence(culteId: culte.id, compte: 50),
        throwsA(isA<Exception>()),
      );
    });

    test('définit un compte global sur un culte en mode global', () async {
      final culte = await repository.creerCulte(
        noeudId: noeudId,
        dateHeure: DateTime(2026, 6, 7, 10),
        typeCulte: 'Culte dominical',
        modePresence: ModePresence.global,
      );
      await repository.definirCompteGlobalPresence(culteId: culte.id, compte: 50);
      final rechargee = await repository.findCulteById(culte.id);
      expect(rechargee?.compteGlobalPresence, 50);
    });
  });

  group('propositions de thème et votes (RG-XII-06)', () {
    test('le décompte des votes reflète toujours les votes réels en base', () async {
      await repository.soumettreProposition(fideleId: fideleId, titre: 'La foi qui agit');
      final proposition = (await repository.watchPropositions().first).single;
      expect(proposition.nbLikes, 0);
      expect(proposition.nbDislikes, 0);

      await repository.voter(propositionId: proposition.id, fideleId: fideleId, valeur: ValeurVote.jaime);
      final apresVote = (await repository.watchPropositions().first).single;
      expect(apresVote.nbLikes, 1);
      expect(apresVote.nbDislikes, 0);
    });

    test('voter à nouveau change le sens du vote au lieu d\'en compter un second', () async {
      await repository.soumettreProposition(fideleId: fideleId, titre: 'La foi qui agit');
      final proposition = (await repository.watchPropositions().first).single;

      await repository.voter(propositionId: proposition.id, fideleId: fideleId, valeur: ValeurVote.jaime);
      await repository.voter(propositionId: proposition.id, fideleId: fideleId, valeur: ValeurVote.jenaimepas);

      final votes = await repository.watchVotes(proposition.id).first;
      expect(votes, hasLength(1));
      expect(votes.single.valeur, ValeurVote.jenaimepas);

      final decompte = await repository.watchPropositions().first;
      expect(decompte.single.nbLikes, 0);
      expect(decompte.single.nbDislikes, 1);
    });

    test('changerStatutProposition met à jour le statut', () async {
      await repository.soumettreProposition(fideleId: fideleId, titre: 'La foi qui agit');
      final proposition = (await repository.watchPropositions().first).single;

      await repository.changerStatutProposition(id: proposition.id, statut: StatutProposition.validee);
      final rechargee = (await repository.watchPropositions().first).single;
      expect(rechargee.statut, StatutProposition.validee);
    });
  });
}
