import 'package:ecclesias_360/features/parametres/domain/rules/zone_geographique_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calculerNiveau', () {
    test('une zone racine (sans parent) est de niveau 0', () {
      expect(ZoneGeographiqueRules.calculerNiveau(niveauParent: null), 0);
    });

    test('une zone enfant est au niveau parent + 1', () {
      expect(ZoneGeographiqueRules.calculerNiveau(niveauParent: 0), 1);
      expect(ZoneGeographiqueRules.calculerNiveau(niveauParent: 2), 3);
    });
  });

  group('raisonBlocageSuppression (RG-XXIII-03)', () {
    test('non utilisée -> suppression autorisée', () {
      expect(ZoneGeographiqueRules.raisonBlocageSuppression(estUtilisee: false), isNull);
    });

    test('utilisée -> suppression bloquée', () {
      final erreur = ZoneGeographiqueRules.raisonBlocageSuppression(estUtilisee: true);
      expect(erreur?.code, 'referentiel_en_usage');
    });
  });
}
