import 'package:ecclesias_360/features/comptabilite/domain/models/statut_periode_comptable.dart';
import 'package:ecclesias_360/features/comptabilite/domain/models/type_compte.dart';
import 'package:ecclesias_360/features/comptabilite/domain/rules/comptabilite_rules.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('raisonBlocageEcritureSurPeriode (RG-XXI-03)', () {
    test('aucun blocage sur une période ouverte', () {
      expect(
        ComptabiliteRules.raisonBlocageEcritureSurPeriode(statutPeriode: StatutPeriodeComptable.ouverte),
        isNull,
      );
    });

    test('blocage sur une période clôturée', () {
      final erreur = ComptabiliteRules.raisonBlocageEcritureSurPeriode(statutPeriode: StatutPeriodeComptable.cloturee);
      expect(erreur, isNotNull);
      expect(erreur!.code, 'periode_comptable_cloturee');
    });
  });

  group('raisonBlocageClotureComptable (RG-XXI-03)', () {
    test('un pasteur peut clôturer', () {
      expect(ComptabiliteRules.raisonBlocageClotureComptable(roleActeur: Role.pasteur), isNull);
    });

    test('un administrateur (rôle supérieur) peut clôturer', () {
      expect(ComptabiliteRules.raisonBlocageClotureComptable(roleActeur: Role.administrateur), isNull);
    });

    test('un responsable ne peut pas clôturer', () {
      final erreur = ComptabiliteRules.raisonBlocageClotureComptable(roleActeur: Role.responsable);
      expect(erreur, isNotNull);
      expect(erreur!.code, 'role_insuffisant_pour_cloture_comptable');
    });
  });

  group('calculerSoldeCompte (RG-XXI-01)', () {
    test('compte actif : le débit augmente le solde', () {
      expect(
        ComptabiliteRules.calculerSoldeCompte(type: TypeCompte.actif, totalDebit: 10000, totalCredit: 4000),
        6000,
      );
    });

    test('compte charge : le débit augmente le solde', () {
      expect(
        ComptabiliteRules.calculerSoldeCompte(type: TypeCompte.charge, totalDebit: 5000, totalCredit: 0),
        5000,
      );
    });

    test('compte passif : le crédit augmente le solde', () {
      expect(
        ComptabiliteRules.calculerSoldeCompte(type: TypeCompte.passif, totalDebit: 1000, totalCredit: 9000),
        8000,
      );
    });

    test('compte produit : le crédit augmente le solde', () {
      expect(
        ComptabiliteRules.calculerSoldeCompte(type: TypeCompte.produit, totalDebit: 0, totalCredit: 7000),
        7000,
      );
    });
  });

  group('depassementSeuilBudget (RG-XXI-04)', () {
    test('pas de dépassement sous le seuil', () {
      expect(
        ComptabiliteRules.depassementSeuilBudget(montantEngage: 80, montantPrevu: 100, seuilAlertePourcentage: 90),
        isFalse,
      );
    });

    test('dépassement au seuil exact', () {
      expect(
        ComptabiliteRules.depassementSeuilBudget(montantEngage: 90, montantPrevu: 100, seuilAlertePourcentage: 90),
        isTrue,
      );
    });

    test('dépassement au-delà du seuil', () {
      expect(
        ComptabiliteRules.depassementSeuilBudget(montantEngage: 150, montantPrevu: 100, seuilAlertePourcentage: 90),
        isTrue,
      );
    });

    test('budget prévu nul : tout engagement positif est un dépassement', () {
      expect(
        ComptabiliteRules.depassementSeuilBudget(montantEngage: 1, montantPrevu: 0, seuilAlertePourcentage: 90),
        isTrue,
      );
      expect(
        ComptabiliteRules.depassementSeuilBudget(montantEngage: 0, montantPrevu: 0, seuilAlertePourcentage: 90),
        isFalse,
      );
    });
  });

  group('ecartRapprochement (RG-XXI-05)', () {
    test('aucun écart quand les soldes concordent', () {
      expect(ComptabiliteRules.ecartRapprochement(soldeSysteme: 5000, soldeReleve: 5000), 0);
    });

    test('écart positif quand le système excède le relevé', () {
      expect(ComptabiliteRules.ecartRapprochement(soldeSysteme: 5200, soldeReleve: 5000), 200);
    });

    test('écart négatif quand le relevé excède le système', () {
      expect(ComptabiliteRules.ecartRapprochement(soldeSysteme: 4800, soldeReleve: 5000), -200);
    });
  });

  group('peutConsulterComptabilite (RG-SEC-06, miroir de ecritures_comptables_lecture)', () {
    test('un pasteur consulte sans être trésorier', () {
      expect(ComptabiliteRules.peutConsulterComptabilite(role: Role.pasteur, estTresorierDuNoeud: false), isTrue);
    });

    test('un trésorier du nœud consulte quel que soit son rang', () {
      expect(ComptabiliteRules.peutConsulterComptabilite(role: Role.membre, estTresorierDuNoeud: true), isTrue);
    });

    test('un responsable non trésorier ne consulte pas', () {
      expect(ComptabiliteRules.peutConsulterComptabilite(role: Role.responsable, estTresorierDuNoeud: false), isFalse);
    });
  });
}
