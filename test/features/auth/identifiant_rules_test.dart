import 'package:ecclesias_360/features/auth/domain/rules/identifiant_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IdentifiantRules.normaliserTelephone (E.164, KER-ID-06)', () {
    test('accepte un numéro international et retire les séparateurs', () {
      expect(IdentifiantRules.normaliserTelephone('+224 620 00-00.01'), '+224620000001');
    });

    test('convertit le préfixe international 00 en +', () {
      expect(IdentifiantRules.normaliserTelephone('00224620000001'), '+224620000001');
    });

    test('refuse un numéro national sans indicatif pays (jamais deviné)', () {
      expect(IdentifiantRules.normaliserTelephone('620000001'), isNull);
      expect(IdentifiantRules.normaliserTelephone('0620000001'), isNull);
    });

    test('refuse un indicatif commençant par 0, trop court ou trop long', () {
      expect(IdentifiantRules.normaliserTelephone('+0224620000001'), isNull);
      expect(IdentifiantRules.normaliserTelephone('+2246200'), isNull);
      expect(IdentifiantRules.normaliserTelephone('+2246200000011234'), isNull);
    });

    test('refuse les lettres', () {
      expect(IdentifiantRules.normaliserTelephone('+224 62O 000 001'), isNull);
    });
  });

  group('IdentifiantRules.normaliserEmail', () {
    test('met en minuscules et retire les espaces', () {
      expect(IdentifiantRules.normaliserEmail('  Pasteur@Eglise.ORG '), 'pasteur@eglise.org');
    });

    test('refuse une adresse sans domaine', () {
      expect(IdentifiantRules.normaliserEmail('pasteur@eglise'), isNull);
      expect(IdentifiantRules.normaliserEmail('pasteur'), isNull);
    });
  });
}
