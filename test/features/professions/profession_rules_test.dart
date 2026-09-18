import 'package:ecclesias_360/features/professions/domain/models/statut_verification.dart';
import 'package:ecclesias_360/features/professions/domain/rules/profession_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('peutVerifier (RG-V-01)', () {
    test('une déclaration non vérifiée peut être vérifiée', () {
      expect(ProfessionRules.peutVerifier(StatutVerification.declare), isTrue);
    });

    test('une déclaration déjà vérifiée ne peut pas être re-vérifiée', () {
      expect(ProfessionRules.peutVerifier(StatutVerification.verifie), isFalse);
    });
  });

  group('raisonBlocageSuppression (RG-V-02)', () {
    test('non utilisée -> suppression autorisée', () {
      expect(ProfessionRules.raisonBlocageSuppression(estUtilisee: false), isNull);
    });

    test('utilisée -> suppression bloquée', () {
      final erreur = ProfessionRules.raisonBlocageSuppression(estUtilisee: true);
      expect(erreur?.code, 'referentiel_en_usage');
    });
  });
}
