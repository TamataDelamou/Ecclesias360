import 'package:ecclesias_360/features/finances/domain/models/periodicite_engagement.dart';
import 'package:ecclesias_360/features/finances/domain/rules/finances_rules.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('raisonBlocageValidationContribution (RG-XI-02)', () {
    test('un pasteur peut valider une contribution', () {
      expect(
        FinancesRules.raisonBlocageValidationContribution(roleActeur: Role.pasteur, estTresorierDuNoeud: false),
        isNull,
      );
    });

    test('un administrateur (rang supérieur) peut valider une contribution', () {
      expect(
        FinancesRules.raisonBlocageValidationContribution(
          roleActeur: Role.administrateur,
          estTresorierDuNoeud: false,
        ),
        isNull,
      );
    });

    test('un trésorier désigné peut valider même sans rang suffisant', () {
      expect(
        FinancesRules.raisonBlocageValidationContribution(roleActeur: Role.membre, estTresorierDuNoeud: true),
        isNull,
      );
    });

    test('un simple membre hors désignation trésorier ne peut pas valider', () {
      final erreur =
          FinancesRules.raisonBlocageValidationContribution(roleActeur: Role.membre, estTresorierDuNoeud: false);
      expect(erreur?.code, 'role_insuffisant_pour_validation_contribution');
    });

    test('un responsable (rang inférieur au pasteur) hors désignation ne peut pas valider', () {
      final erreur = FinancesRules.raisonBlocageValidationContribution(
        roleActeur: Role.responsable,
        estTresorierDuNoeud: false,
      );
      expect(erreur?.code, 'role_insuffisant_pour_validation_contribution');
    });
  });

  group('raisonBlocageDepense (RG-XI-03)', () {
    test('une dépense inférieure ou égale au solde disponible est autorisée', () {
      expect(
        FinancesRules.raisonBlocageDepense(soldeDisponible: 1000, montantDepense: 1000, derogationTracee: false),
        isNull,
      );
    });

    test('une dépense supérieure au solde est bloquée sans dérogation', () {
      final erreur =
          FinancesRules.raisonBlocageDepense(soldeDisponible: 500, montantDepense: 600, derogationTracee: false);
      expect(erreur?.code, 'depense_depasse_solde_sans_derogation');
    });

    test('une dépense supérieure au solde est autorisée avec dérogation tracée', () {
      expect(
        FinancesRules.raisonBlocageDepense(soldeDisponible: 500, montantDepense: 600, derogationTracee: true),
        isNull,
      );
    });
  });

  group('calculerSoldeProjet (RG-XI-03)', () {
    test('le solde est la différence recettes moins dépenses', () {
      expect(
        FinancesRules.calculerSoldeProjet(totalContributionsValidees: 10000, totalDepenses: 3000),
        7000,
      );
    });

    test('le solde peut être négatif (dérogation antérieure)', () {
      expect(
        FinancesRules.calculerSoldeProjet(totalContributionsValidees: 1000, totalDepenses: 1500),
        -500,
      );
    });
  });

  group('sontDoublonsPotentiels (RG-XI-06)', () {
    test('même fidèle, même montant, même minute : doublon potentiel', () {
      final dateA = DateTime(2026, 1, 15, 10, 30, 5);
      final dateB = DateTime(2026, 1, 15, 10, 30, 45);
      expect(
        FinancesRules.sontDoublonsPotentiels(
          fideleIdA: 'f1',
          montantA: 5000,
          dateA: dateA,
          fideleIdB: 'f1',
          montantB: 5000,
          dateB: dateB,
        ),
        isTrue,
      );
    });

    test('fidèles différents : pas un doublon', () {
      final date = DateTime(2026, 1, 15, 10, 30);
      expect(
        FinancesRules.sontDoublonsPotentiels(
          fideleIdA: 'f1',
          montantA: 5000,
          dateA: date,
          fideleIdB: 'f2',
          montantB: 5000,
          dateB: date,
        ),
        isFalse,
      );
    });

    test('montants différents : pas un doublon', () {
      final date = DateTime(2026, 1, 15, 10, 30);
      expect(
        FinancesRules.sontDoublonsPotentiels(
          fideleIdA: 'f1',
          montantA: 5000,
          dateA: date,
          fideleIdB: 'f1',
          montantB: 6000,
          dateB: date,
        ),
        isFalse,
      );
    });

    test('minutes différentes : pas un doublon', () {
      expect(
        FinancesRules.sontDoublonsPotentiels(
          fideleIdA: 'f1',
          montantA: 5000,
          dateA: DateTime(2026, 1, 15, 10, 30),
          fideleIdB: 'f1',
          montantB: 5000,
          dateB: DateTime(2026, 1, 15, 10, 32),
        ),
        isFalse,
      );
    });

    test('donateur anonyme (fideleId null) : jamais un doublon détecté', () {
      final date = DateTime(2026, 1, 15, 10, 30);
      expect(
        FinancesRules.sontDoublonsPotentiels(
          fideleIdA: null,
          montantA: 5000,
          dateA: date,
          fideleIdB: null,
          montantB: 5000,
          dateB: date,
        ),
        isFalse,
      );
    });
  });

  group('genererDatesEcheance (RG-XI-04)', () {
    test('génère le bon nombre de dates, espacées selon la périodicité mensuelle', () {
      final debut = DateTime(2026, 1, 1);
      final dates = FinancesRules.genererDatesEcheance(
        dateDebut: debut,
        periodicite: PeriodiciteEngagement.mensuelle,
        nombre: 3,
      );
      expect(dates.length, 3);
      expect(dates[0], debut.add(const Duration(days: 30)));
      expect(dates[1], debut.add(const Duration(days: 60)));
      expect(dates[2], debut.add(const Duration(days: 90)));
    });

    test('périodicité hebdomadaire', () {
      final debut = DateTime(2026, 1, 1);
      final dates = FinancesRules.genererDatesEcheance(
        dateDebut: debut,
        periodicite: PeriodiciteEngagement.hebdomadaire,
        nombre: 2,
      );
      expect(dates[0], debut.add(const Duration(days: 7)));
      expect(dates[1], debut.add(const Duration(days: 14)));
    });
  });

  group('estEnRetard (RG-XI-04)', () {
    test('une échéance passée est en retard', () {
      expect(
        FinancesRules.estEnRetard(dateEcheance: DateTime(2026, 1, 1), maintenant: DateTime(2026, 1, 2)),
        isTrue,
      );
    });

    test('une échéance future n\'est pas en retard', () {
      expect(
        FinancesRules.estEnRetard(dateEcheance: DateTime(2026, 2, 1), maintenant: DateTime(2026, 1, 2)),
        isFalse,
      );
    });
  });
}
