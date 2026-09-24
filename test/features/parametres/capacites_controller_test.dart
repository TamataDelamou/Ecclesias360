import 'dart:async';

import 'package:ecclesias_360/features/parametres/application/capacites_controller.dart';
import 'package:ecclesias_360/features/parametres/data/referential/roles_referential.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/features/parametres/domain/rules/parametres_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CapacitesController (RG-XXIII-02)', () {
    test('refus par défaut tant que roles.json n\'est pas chargé', () async {
      final chargement = Completer<RolesReferential>();
      final capacites = CapacitesController(chargement: chargement.future);

      expect(capacites.accorde(capacite: Capacites.creerNoeudNiveauSuperieur, role: Role.administrateur), isFalse);

      chargement.complete(RolesReferential({Capacites.creerNoeudNiveauSuperieur: Role.administrateur}));
      await Future<void>.delayed(Duration.zero);
      expect(capacites.accorde(capacite: Capacites.creerNoeudNiveauSuperieur, role: Role.administrateur), isTrue);
      expect(capacites.accorde(capacite: Capacites.creerNoeudNiveauSuperieur, role: Role.pasteur), isFalse);
    });

    test('une capacité absente du référentiel n\'est jamais accordée', () async {
      final capacites = CapacitesController(chargement: Future.value(const RolesReferential({})));
      await Future<void>.delayed(Duration.zero);
      expect(capacites.accorde(capacite: Capacites.consulterAnnuaireEglises, role: Role.administrateur), isFalse);
    });

    test('un échec de chargement laisse tout refusé', () async {
      final capacites = CapacitesController(chargement: Future.error(StateError('asset absent')));
      await Future<void>.delayed(Duration.zero);
      expect(capacites.charge, isFalse);
      expect(capacites.accorde(capacite: Capacites.consulterAnnuaireEglises, role: Role.administrateur), isFalse);
    });
  });

  test('RG-XXIII-06 : administration réservée à l\'administrateur', () {
    expect(ParametresRules.raisonBlocageAdministration(roleActeur: Role.administrateur), isNull);
    expect(
      ParametresRules.raisonBlocageAdministration(roleActeur: Role.pasteur)?.code,
      'administration_parametres_reservee',
    );
  });
}
