import 'package:ecclesias_360/features/ministeres/domain/models/mandat_responsable.dart';
import 'package:ecclesias_360/features/ministeres/domain/rules/ministere_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('raisonBlocageResponsableSupplementaire (RG-III-01)', () {
    test('aucun responsable actif -> affectation autorisée', () {
      expect(
        MinistereRules.raisonBlocageResponsableSupplementaire(existeDejaResponsableActif: false),
        isNull,
      );
    });

    test('un responsable déjà actif -> affectation bloquée', () {
      final erreur = MinistereRules.raisonBlocageResponsableSupplementaire(
        existeDejaResponsableActif: true,
      );
      expect(erreur?.code, 'responsable_ministere_deja_actif');
    });
  });

  group('raisonBlocageDesactivationType (RG-III-04)', () {
    test('type personnalisé -> désactivation autorisée', () {
      expect(MinistereRules.raisonBlocageDesactivationType(standard: false), isNull);
    });

    test('type standard -> désactivation bloquée', () {
      final erreur = MinistereRules.raisonBlocageDesactivationType(standard: true);
      expect(erreur?.code, 'type_ministere_standard_protege');
    });
  });

  group('mandatsArrivantAEcheance (RG-III-02)', () {
    final maintenant = DateTime(2026, 1, 1);

    test('exclut un mandat déjà clos', () {
      final mandat = MandatResponsable(
        id: 'm1',
        ministereId: 'min1',
        fideleId: 'f1',
        dateDebut: DateTime(2025, 1, 1),
        dateFinPrevue: DateTime(2026, 1, 10),
        dateFinReelle: DateTime(2025, 12, 1),
      );
      expect(
        MinistereRules.mandatsArrivantAEcheance([mandat], maintenant: maintenant),
        isEmpty,
      );
    });

    test('exclut un mandat sans échéance prévue', () {
      final mandat = MandatResponsable(
        id: 'm1',
        ministereId: 'min1',
        fideleId: 'f1',
        dateDebut: DateTime(2025, 1, 1),
      );
      expect(
        MinistereRules.mandatsArrivantAEcheance([mandat], maintenant: maintenant),
        isEmpty,
      );
    });

    test('inclut un mandat dont l\'échéance prévue tombe dans l\'horizon', () {
      final mandat = MandatResponsable(
        id: 'm1',
        ministereId: 'min1',
        fideleId: 'f1',
        dateDebut: DateTime(2025, 1, 1),
        dateFinPrevue: DateTime(2026, 1, 15),
      );
      final resultat = MinistereRules.mandatsArrivantAEcheance(
        [mandat],
        maintenant: maintenant,
        horizon: const Duration(days: 30),
      );
      expect(resultat, [mandat]);
    });

    test('exclut un mandat dont l\'échéance prévue est hors horizon', () {
      final mandat = MandatResponsable(
        id: 'm1',
        ministereId: 'min1',
        fideleId: 'f1',
        dateDebut: DateTime(2025, 1, 1),
        dateFinPrevue: DateTime(2026, 6, 1),
      );
      final resultat = MinistereRules.mandatsArrivantAEcheance(
        [mandat],
        maintenant: maintenant,
        horizon: const Duration(days: 30),
      );
      expect(resultat, isEmpty);
    });

    test('inclut un mandat dont l\'échéance prévue est déjà dépassée', () {
      final mandat = MandatResponsable(
        id: 'm1',
        ministereId: 'min1',
        fideleId: 'f1',
        dateDebut: DateTime(2025, 1, 1),
        dateFinPrevue: DateTime(2025, 12, 1),
      );
      final resultat = MinistereRules.mandatsArrivantAEcheance([mandat], maintenant: maintenant);
      expect(resultat, [mandat]);
    });
  });
}
