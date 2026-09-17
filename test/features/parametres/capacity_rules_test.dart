import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/features/parametres/domain/rules/capacity_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('possede (RG-XXIII-02)', () {
    test('un rôle strictement supérieur au minimum requis possède la capacité', () {
      expect(
        CapacityRules.possede(role: Role.administrateur, roleMinimalRequis: Role.responsable),
        isTrue,
      );
    });

    test('un rôle exactement égal au minimum requis possède la capacité', () {
      expect(
        CapacityRules.possede(role: Role.responsable, roleMinimalRequis: Role.responsable),
        isTrue,
      );
    });

    test('un rôle inférieur au minimum requis ne possède pas la capacité', () {
      expect(
        CapacityRules.possede(role: Role.membre, roleMinimalRequis: Role.responsable),
        isFalse,
      );
    });

    test('utilisateur_simple ne possède aucune capacité au-delà de son propre rang', () {
      expect(
        CapacityRules.possede(role: Role.utilisateurSimple, roleMinimalRequis: Role.membre),
        isFalse,
      );
    });

    test('administrateur possède toutes les capacités (rang maximal)', () {
      for (final roleMinimal in Role.values) {
        expect(
          CapacityRules.possede(role: Role.administrateur, roleMinimalRequis: roleMinimal),
          isTrue,
        );
      }
    });
  });
}
