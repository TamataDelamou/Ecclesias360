import 'package:ecclesias_360/features/comite/domain/models/statut_proces_verbal.dart';
import 'package:ecclesias_360/features/comite/domain/rules/comite_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('quorumAtteint (RG-VII-05)', () {
    test('aucun quorum configuré -> indéterminé (null)', () {
      expect(ComiteRules.quorumAtteint(nombrePresents: 5, quorumMinimum: null), isNull);
    });

    test('présents >= quorum -> atteint', () {
      expect(ComiteRules.quorumAtteint(nombrePresents: 5, quorumMinimum: 5), isTrue);
      expect(ComiteRules.quorumAtteint(nombrePresents: 6, quorumMinimum: 5), isTrue);
    });

    test('présents < quorum -> non atteint', () {
      expect(ComiteRules.quorumAtteint(nombrePresents: 4, quorumMinimum: 5), isFalse);
    });
  });

  group('raisonBlocageAdoption (RG-VII-05)', () {
    test('quorum atteint -> adoption autorisée', () {
      expect(ComiteRules.raisonBlocageAdoption(quorumAtteint: true), isNull);
    });

    test('quorum non atteint -> adoption bloquée', () {
      final erreur = ComiteRules.raisonBlocageAdoption(quorumAtteint: false);
      expect(erreur?.code, 'quorum_non_atteint_pour_adoption');
    });

    test('quorum indéterminé (non configuré) -> adoption bloquée', () {
      final erreur = ComiteRules.raisonBlocageAdoption(quorumAtteint: null);
      expect(erreur?.code, 'quorum_non_atteint_pour_adoption');
    });
  });

  group('raisonBlocageModificationProcesVerbal (RG-VII-02)', () {
    test('brouillon -> modification autorisée', () {
      expect(
        ComiteRules.raisonBlocageModificationProcesVerbal(statut: StatutProcesVerbal.brouillon),
        isNull,
      );
    });

    test('validé -> modification bloquée, immuable', () {
      final erreur = ComiteRules.raisonBlocageModificationProcesVerbal(statut: StatutProcesVerbal.valide);
      expect(erreur?.code, 'proces_verbal_valide_immuable');
    });
  });
}
