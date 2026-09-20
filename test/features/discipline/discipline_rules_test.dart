import 'package:ecclesias_360/features/discipline/domain/models/statut_dossier_disciplinaire.dart';
import 'package:ecclesias_360/features/discipline/domain/rules/discipline_rules.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('raisonBlocageOuverture (RG-X-01)', () {
    test('un pasteur peut ouvrir un dossier', () {
      expect(
        DisciplineRules.raisonBlocageOuverture(roleActeur: Role.pasteur, estMembreCommission: false),
        isNull,
      );
    });

    test('un administrateur (rôle supérieur) peut ouvrir un dossier', () {
      expect(
        DisciplineRules.raisonBlocageOuverture(roleActeur: Role.administrateur, estMembreCommission: false),
        isNull,
      );
    });

    test('un membre de commission désigné peut ouvrir un dossier même sans rang suffisant', () {
      expect(
        DisciplineRules.raisonBlocageOuverture(roleActeur: Role.membre, estMembreCommission: true),
        isNull,
      );
    });

    test('un simple membre hors commission ne peut pas ouvrir de dossier', () {
      final erreur =
          DisciplineRules.raisonBlocageOuverture(roleActeur: Role.membre, estMembreCommission: false);
      expect(erreur?.code, 'role_insuffisant_pour_ouverture_dossier');
    });

    test('un responsable (rang inférieur au pasteur) hors commission ne peut pas ouvrir de dossier', () {
      final erreur =
          DisciplineRules.raisonBlocageOuverture(roleActeur: Role.responsable, estMembreCommission: false);
      expect(erreur?.code, 'role_insuffisant_pour_ouverture_dossier');
    });
  });

  group('raisonBlocageDecision (RG-X-02)', () {
    test('commission assignée -> décision autorisée', () {
      expect(DisciplineRules.raisonBlocageDecision(commissionRenseignee: true), isNull);
    });

    test('sans commission assignée -> décision bloquée', () {
      final erreur = DisciplineRules.raisonBlocageDecision(commissionRenseignee: false);
      expect(erreur?.code, 'commission_requise_pour_decision');
    });
  });

  group('raisonBlocagePrononceDecision (RG-X-02)', () {
    test('dossier en instruction -> décision autorisée', () {
      expect(
        DisciplineRules.raisonBlocagePrononceDecision(statut: StatutDossierDisciplinaire.enInstruction),
        isNull,
      );
    });

    test('dossier déjà sanctionné -> nouvelle décision bloquée', () {
      final erreur =
          DisciplineRules.raisonBlocagePrononceDecision(statut: StatutDossierDisciplinaire.sanctionne);
      expect(erreur?.code, 'dossier_disciplinaire_non_en_instruction');
    });

    test('dossier clos -> décision bloquée', () {
      final erreur = DisciplineRules.raisonBlocagePrononceDecision(statut: StatutDossierDisciplinaire.clos);
      expect(erreur?.code, 'dossier_disciplinaire_non_en_instruction');
    });
  });

  group('raisonBlocageCloture (RG-X-02/04)', () {
    test('dossier sanctionné -> clôture autorisée', () {
      expect(
        DisciplineRules.raisonBlocageCloture(statut: StatutDossierDisciplinaire.sanctionne),
        isNull,
      );
    });

    test('dossier encore en instruction -> clôture bloquée (aucune décision rendue)', () {
      final erreur = DisciplineRules.raisonBlocageCloture(statut: StatutDossierDisciplinaire.enInstruction);
      expect(erreur?.code, 'dossier_disciplinaire_non_sanctionne');
    });

    test('dossier déjà clos -> nouvelle clôture bloquée', () {
      final erreur = DisciplineRules.raisonBlocageCloture(statut: StatutDossierDisciplinaire.clos);
      expect(erreur?.code, 'dossier_disciplinaire_non_sanctionne');
    });
  });

  group('calculerDateReintegrationPrevue (RG-X-04)', () {
    test('durée déterminée -> date de réintégration calculée', () {
      final date = DisciplineRules.calculerDateReintegrationPrevue(
        dateDecision: DateTime(2026, 1, 1),
        dureeSanctionJours: 30,
      );
      expect(date, DateTime(2026, 1, 31));
    });

    test('durée indéterminée -> aucune date de réintégration', () {
      final date = DisciplineRules.calculerDateReintegrationPrevue(
        dateDecision: DateTime(2026, 1, 1),
        dureeSanctionJours: null,
      );
      expect(date, isNull);
    });
  });

  group('necessiteRevuePeriodique (RG-X-04)', () {
    test('seuil non atteint -> pas de revue nécessaire', () {
      expect(
        DisciplineRules.necessiteRevuePeriodique(
          dateDecision: DateTime(2026, 1, 1),
          maintenant: DateTime(2026, 2, 1),
          seuilJours: 90,
        ),
        isFalse,
      );
    });

    test('seuil atteint ou dépassé -> revue nécessaire', () {
      expect(
        DisciplineRules.necessiteRevuePeriodique(
          dateDecision: DateTime(2026, 1, 1),
          maintenant: DateTime(2026, 4, 1),
          seuilJours: 90,
        ),
        isTrue,
      );
    });
  });
}
