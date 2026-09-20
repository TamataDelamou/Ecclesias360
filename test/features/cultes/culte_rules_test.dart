import 'package:ecclesias_360/features/cultes/domain/models/mode_presence.dart';
import 'package:ecclesias_360/features/cultes/domain/models/valeur_vote.dart';
import 'package:ecclesias_360/features/cultes/domain/models/vote_proposition.dart';
import 'package:ecclesias_360/features/cultes/domain/rules/culte_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('raisonBlocagePresence (RG-XII-02)', () {
    test('mode demandé identique au mode du culte -> autorisé', () {
      expect(
        CulteRules.raisonBlocagePresence(
          modeDuCulte: ModePresence.nominal,
          modeDemande: ModePresence.nominal,
        ),
        isNull,
      );
      expect(
        CulteRules.raisonBlocagePresence(
          modeDuCulte: ModePresence.global,
          modeDemande: ModePresence.global,
        ),
        isNull,
      );
    });

    test('mode demandé différent du mode du culte -> bloqué (modes mutuellement exclusifs)', () {
      final erreur = CulteRules.raisonBlocagePresence(
        modeDuCulte: ModePresence.nominal,
        modeDemande: ModePresence.global,
      );
      expect(erreur?.code, 'mode_presence_incompatible');
    });
  });

  group('genererDatesRecurrentes (RG-XII-05)', () {
    test('génère les occurrences hebdomadaires, première date incluse', () {
      final dates = CulteRules.genererDatesRecurrentes(
        premiereDateHeure: DateTime(2026, 1, 4, 10),
        nombreOccurrences: 3,
      );
      expect(dates, [
        DateTime(2026, 1, 4, 10),
        DateTime(2026, 1, 11, 10),
        DateTime(2026, 1, 18, 10),
      ]);
    });

    test('une seule occurrence -> uniquement la date de départ', () {
      final dates = CulteRules.genererDatesRecurrentes(
        premiereDateHeure: DateTime(2026, 1, 4, 10),
        nombreOccurrences: 1,
      );
      expect(dates, [DateTime(2026, 1, 4, 10)]);
    });

    test('nombre d\'occurrences invalide (< 1) -> aucune date générée', () {
      expect(
        CulteRules.genererDatesRecurrentes(premiereDateHeure: DateTime(2026, 1, 4), nombreOccurrences: 0),
        isEmpty,
      );
      expect(
        CulteRules.genererDatesRecurrentes(premiereDateHeure: DateTime(2026, 1, 4), nombreOccurrences: -1),
        isEmpty,
      );
    });
  });

  group('decompterVotes (RG-XII-06)', () {
    test('aucun vote -> décompte à zéro', () {
      final decompte = CulteRules.decompterVotes(const []);
      expect(decompte.likes, 0);
      expect(decompte.dislikes, 0);
    });

    test('décompte réel à partir des votes, jamais un compteur mutable indépendant', () {
      final votes = [
        const VoteProposition(id: 'v1', propositionId: 'p1', fideleId: 'f1', valeur: ValeurVote.jaime),
        const VoteProposition(id: 'v2', propositionId: 'p1', fideleId: 'f2', valeur: ValeurVote.jaime),
        const VoteProposition(id: 'v3', propositionId: 'p1', fideleId: 'f3', valeur: ValeurVote.jenaimepas),
      ];
      final decompte = CulteRules.decompterVotes(votes);
      expect(decompte.likes, 2);
      expect(decompte.dislikes, 1);
    });
  });
}
