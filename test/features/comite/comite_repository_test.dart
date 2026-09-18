import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/comite/data/comite_repository.dart';
import 'package:ecclesias_360/features/comite/domain/models/statut_decision.dart';
import 'package:ecclesias_360/features/comite/domain/models/statut_proces_verbal.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ComiteRepository repository;
  late String noeudId;
  late String pasteurId;
  late String diacreId;

  Future<String> creerFidele(String id) async {
    await db.into(db.fideles).insert(
          FidelesCompanion.insert(
            id: id,
            noeudId: noeudId,
            nom: 'Doe',
            prenoms: 'Jean',
            dateNaissance: DateTime(1980, 1, 1),
            sexe: 'masculin',
            statutCivil: 'marie',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
    return id;
  }

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = ComiteRepository(db);

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

    pasteurId = await creerFidele('fidele-1');
    diacreId = await creerFidele('fidele-2');
  });

  tearDown(() => db.close());

  group('quorum (RG-VII-05)', () {
    test('aucun quorum configuré par défaut', () async {
      expect(await repository.quorumMinimumDuNoeud(noeudId), isNull);
    });

    test('definirQuorum puis relecture', () async {
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 3);
      expect(await repository.quorumMinimumDuNoeud(noeudId), 3);
    });

    test('definirQuorum met à jour une valeur existante', () async {
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 3);
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 5);
      expect(await repository.quorumMinimumDuNoeud(noeudId), 5);
    });
  });

  group('nommerMembre (RG-VII-01)', () {
    test('crée un membre lié à un fidèle existant', () async {
      final membre = await repository.nommerMembre(fideleId: pasteurId, noeudId: noeudId, fonction: 'Pasteur');
      expect(membre.fideleId, pasteurId);
      expect(membre.mandatActif, isTrue);
    });

    test('clorerMandat ferme le mandat', () async {
      final membre = await repository.nommerMembre(fideleId: pasteurId, noeudId: noeudId, fonction: 'Pasteur');
      await repository.clorerMandat(membre.id);
      final membres = await repository.watchMembres(noeudId).first;
      expect(membres.single.mandatActif, isFalse);
    });
  });

  group('creerSeance (RG-VII-05)', () {
    test('quorum indéterminé sans configuration', () async {
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: [pasteurId, diacreId],
      );
      expect(seance.quorumAtteint, isNull);
    });

    test('quorum atteint si présents >= quorum configuré', () async {
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 2);
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: [pasteurId, diacreId],
      );
      expect(seance.quorumAtteint, isTrue);
      final presents = await repository.watchPresents(seance.id).first;
      expect(presents, hasLength(2));
    });

    test('quorum non atteint si présents < quorum configuré', () async {
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 3);
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: [pasteurId],
      );
      expect(seance.quorumAtteint, isFalse);
    });
  });

  group('changerStatutDecision (RG-VII-05)', () {
    test('refuse l\'adoption si le quorum n\'est pas atteint', () async {
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 3);
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: [pasteurId],
      );
      final decision = await repository.ajouterDecision(seanceId: seance.id, libelle: 'Adopter le budget');

      expect(
        () => repository.changerStatutDecision(id: decision.id, statut: StatutDecision.adopte),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'quorum_non_atteint_pour_adoption')),
      );
    });

    test('autorise l\'adoption si le quorum est atteint', () async {
      await repository.definirQuorum(noeudId: noeudId, quorumMinimum: 2);
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: [pasteurId, diacreId],
      );
      final decision = await repository.ajouterDecision(seanceId: seance.id, libelle: 'Adopter le budget');

      await repository.changerStatutDecision(id: decision.id, statut: StatutDecision.adopte);

      final decisions = await repository.watchDecisions(seance.id).first;
      expect(decisions.single.statut, StatutDecision.adopte);
    });

    test('rejeter ou ajourner ne nécessite pas de quorum', () async {
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: const [],
      );
      final decision = await repository.ajouterDecision(seanceId: seance.id, libelle: 'Test');

      await repository.changerStatutDecision(id: decision.id, statut: StatutDecision.rejete);

      final decisions = await repository.watchDecisions(seance.id).first;
      expect(decisions.single.statut, StatutDecision.rejete);
    });
  });

  group('procès-verbal (RG-VII-02/03)', () {
    test('enregistrerBrouillon crée puis modifie tant que non validé', () async {
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: const [],
      );
      await repository.enregistrerBrouillon(seanceId: seance.id, contenu: 'Version 1');
      final pv = await repository.enregistrerBrouillon(seanceId: seance.id, contenu: 'Version 2');
      expect(pv.contenu, 'Version 2');
      expect(pv.statut, StatutProcesVerbal.brouillon);
    });

    test('refuse toute modification directe après validation', () async {
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: const [],
      );
      final pv = await repository.enregistrerBrouillon(seanceId: seance.id, contenu: 'Version 1');
      await repository.validerProcesVerbal(pv.id);

      expect(
        () => repository.enregistrerBrouillon(seanceId: seance.id, contenu: 'Version modifiée'),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'proces_verbal_valide_immuable')),
      );
    });

    test('un erratum peut être ajouté après validation sans toucher le contenu original', () async {
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: const [],
      );
      final pv = await repository.enregistrerBrouillon(seanceId: seance.id, contenu: 'Version 1');
      await repository.validerProcesVerbal(pv.id);
      await repository.ajouterErratum(procesVerbalId: pv.id, texte: 'Correction du montant', auteurFideleId: pasteurId);

      final erratums = await repository.watchErratums(pv.id).first;
      expect(erratums, hasLength(1));

      final pvRelu = await repository.watchProcesVerbal(seance.id).first;
      expect(pvRelu!.contenu, 'Version 1');
    });
  });

  group('tâches de suivi (RG-VII-03)', () {
    test('creerTache puis marquerTacheFaite', () async {
      final seance = await repository.creerSeance(
        noeudId: noeudId,
        date: DateTime.now(),
        ordreDuJour: 'Budget',
        presentsFideleIds: const [],
      );
      final decision = await repository.ajouterDecision(seanceId: seance.id, libelle: 'Adopter le budget');
      await repository.creerTache(
        decisionId: decision.id,
        description: 'Transmettre au trésorier',
        assigneFideleId: diacreId,
      );

      var taches = await repository.watchTaches(decision.id).first;
      expect(taches.single.statut.code, 'a_faire');

      await repository.marquerTacheFaite(taches.single.id);
      taches = await repository.watchTaches(decision.id).first;
      expect(taches.single.statut.code, 'fait');
    });
  });
}
