import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_spirituel.dart';
import 'package:ecclesias_360/features/fideles/domain/rules/fidele_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validerTransitionStatutSpirituel (RG-II-02)', () {
    test('visiteur -> nouveau converti est valide (un cran)', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.visiteur,
          cible: StatutSpirituel.nouveauConverti,
        ),
        returnsNormally,
      );
    });

    test('visiteur -> membre actif directement est rejeté (saut de cran)', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.visiteur,
          cible: StatutSpirituel.membreActif,
        ),
        throwsArgumentError,
      );
    });

    test('visiteur -> membre actif est autorisé avec sautHistorique (import, RG-II-09)', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.visiteur,
          cible: StatutSpirituel.membreActif,
          sautHistorique: true,
        ),
        returnsNormally,
      );
    });

    test('nouveau converti -> baptisé est valide', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.nouveauConverti,
          cible: StatutSpirituel.baptise,
        ),
        returnsNormally,
      );
    });

    test('baptisé -> visiteur (régression) est rejeté', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.baptise,
          cible: StatutSpirituel.visiteur,
        ),
        throwsArgumentError,
      );
    });

    test('passage direct à membre en discipline est rejeté (RG-II-03)', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreActif,
          cible: StatutSpirituel.membreEnDiscipline,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'statut_discipline_reserve_au_module_x')),
      );
    });

    test('passage à membre en discipline est autorisé via le module discipline', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreActif,
          cible: StatutSpirituel.membreEnDiscipline,
          viaModuleDiscipline: true,
        ),
        returnsNormally,
      );
    });

    test('sortie de discipline hors module discipline est rejetée', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreEnDiscipline,
          cible: StatutSpirituel.membreActif,
        ),
        throwsArgumentError,
      );
    });

    test('sortie de discipline est autorisée via le module discipline (RG-X-04)', () {
      // Restauration vers le statut antérieur : ne suit pas la chaîne de
      // progression normale (un statut hors chaîne ne peut pas « avancer »
      // vers membre actif autrement), d'où la branche symétrique dédiée.
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreEnDiscipline,
          cible: StatutSpirituel.membreActif,
          viaModuleDiscipline: true,
        ),
        returnsNormally,
      );
    });

    test('sortie de discipline via le module discipline vers un statut terminal (RG-X-04)', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreEnDiscipline,
          cible: StatutSpirituel.membreDecede,
          viaModuleDiscipline: true,
        ),
        returnsNormally,
      );
    });

    test('membre actif -> décédé est valide', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreActif,
          cible: StatutSpirituel.membreDecede,
        ),
        returnsNormally,
      );
    });

    test('visiteur -> transféré est valide (aucune restriction de stade dans le Cahier)', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.visiteur,
          cible: StatutSpirituel.membreTransfere,
        ),
        returnsNormally,
      );
    });

    test('décédé est terminal', () {
      expect(
        () => FideleRules.validerTransitionStatutSpirituel(
          actuel: StatutSpirituel.membreDecede,
          cible: StatutSpirituel.membreActif,
        ),
        throwsArgumentError,
      );
    });
  });

  group('estMineur (RG-II-06)', () {
    test('moins de 18 ans est mineur', () {
      final reference = DateTime(2026, 6, 15);
      final naissance = DateTime(2010, 6, 16); // aura 16 ans le lendemain de la référence
      expect(FideleRules.estMineur(naissance, reference: reference), isTrue);
    });

    test('exactement 18 ans (anniversaire du jour) n\'est plus mineur', () {
      final reference = DateTime(2026, 6, 15);
      final naissance = DateTime(2008, 6, 15);
      expect(FideleRules.estMineur(naissance, reference: reference), isFalse);
    });

    test('anniversaire pas encore atteint cette année reste mineur jusqu\'au jour J', () {
      final reference = DateTime(2026, 6, 14);
      final naissance = DateTime(2008, 6, 15);
      expect(FideleRules.estMineur(naissance, reference: reference), isTrue);
    });
  });

  group('validerTuteur (RG-II-06)', () {
    test('tuteur fidèle enregistré seul est valide', () {
      expect(
        () => FideleRules.validerTuteur(tuteurFideleId: 'fidele-1', tuteurTiersNom: null),
        returnsNormally,
      );
    });

    test('tuteur tiers seul est valide', () {
      expect(
        () => FideleRules.validerTuteur(tuteurFideleId: null, tuteurTiersNom: 'Jean Tiers'),
        returnsNormally,
      );
    });

    test('aucun tuteur renseigné est rejeté', () {
      expect(
        () => FideleRules.validerTuteur(tuteurFideleId: null, tuteurTiersNom: null),
        throwsArgumentError,
      );
    });

    test('les deux renseignés à la fois est rejeté', () {
      expect(
        () => FideleRules.validerTuteur(tuteurFideleId: 'fidele-1', tuteurTiersNom: 'Jean Tiers'),
        throwsArgumentError,
      );
    });
  });

  group('raisonBlocageSuppression (RG-II-08)', () {
    test('aucun rattachement -> suppression autorisée', () {
      expect(FideleRules.raisonBlocageSuppression(aDesRattachements: false), isNull);
    });

    test('des rattachements -> suppression bloquée', () {
      final erreur = FideleRules.raisonBlocageSuppression(aDesRattachements: true);
      expect(erreur?.code, 'fidele_has_blocking_references');
    });
  });
}
