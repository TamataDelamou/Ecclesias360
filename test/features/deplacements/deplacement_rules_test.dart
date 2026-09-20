import 'package:ecclesias_360/features/deplacements/domain/rules/deplacement_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('estValidee (RG-IX-01)', () {
    test('politique bilatérale (défaut) : un seul côté ne suffit pas', () {
      expect(
        DeplacementRules.estValidee(
          valideeParOrigine: true,
          valideeParDestination: false,
          validationUnilateraleAutorisee: false,
        ),
        isFalse,
      );
    });

    test('politique bilatérale : les deux côtés valident -> validée', () {
      expect(
        DeplacementRules.estValidee(
          valideeParOrigine: true,
          valideeParDestination: true,
          validationUnilateraleAutorisee: false,
        ),
        isTrue,
      );
    });

    test('politique unilatérale : un seul côté suffit', () {
      expect(
        DeplacementRules.estValidee(
          valideeParOrigine: false,
          valideeParDestination: true,
          validationUnilateraleAutorisee: true,
        ),
        isTrue,
      );
    });

    test('aucun côté validé -> jamais validée, quelle que soit la politique', () {
      expect(
        DeplacementRules.estValidee(
          valideeParOrigine: false,
          valideeParDestination: false,
          validationUnilateraleAutorisee: true,
        ),
        isFalse,
      );
    });
  });
}
