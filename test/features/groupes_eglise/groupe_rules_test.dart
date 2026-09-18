import 'package:ecclesias_360/features/fideles/domain/models/fidele.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_fidele.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_spirituel.dart';
import 'package:ecclesias_360/features/groupes_eglise/domain/models/criteres_groupe.dart';
import 'package:ecclesias_360/features/groupes_eglise/domain/models/type_regle_groupe.dart';
import 'package:ecclesias_360/features/groupes_eglise/domain/rules/groupe_rules.dart';
import 'package:flutter_test/flutter_test.dart';

Fidele _fidele({
  required DateTime dateNaissance,
  Sexe sexe = Sexe.masculin,
  StatutCivil statutCivil = StatutCivil.celibataire,
  StatutSpirituel statutSpirituel = StatutSpirituel.membreActif,
}) {
  return Fidele(
    id: 'f1',
    noeudId: 'n1',
    nom: 'Doe',
    prenoms: 'Jean',
    dateNaissance: dateNaissance,
    sexe: sexe,
    statutCivil: statutCivil,
    statutSpirituel: statutSpirituel,
    statut: StatutFidele.actif,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  final maintenant = DateTime(2026, 6, 15);

  group('correspond (RG-VI-01)', () {
    test('un critère sexe correspondant valide', () {
      final fidele = _fidele(dateNaissance: DateTime(1990, 1, 1), sexe: Sexe.feminin);
      expect(
        GroupeRules.correspond(fidele, const CriteresGroupe(sexe: 'feminin'), maintenant: maintenant),
        isTrue,
      );
    });

    test('un critère sexe non correspondant invalide', () {
      final fidele = _fidele(dateNaissance: DateTime(1990, 1, 1), sexe: Sexe.masculin);
      expect(
        GroupeRules.correspond(fidele, const CriteresGroupe(sexe: 'feminin'), maintenant: maintenant),
        isFalse,
      );
    });

    test('aucun critère renseigné -> tout le monde correspond', () {
      final fidele = _fidele(dateNaissance: DateTime(1990, 1, 1));
      expect(GroupeRules.correspond(fidele, const CriteresGroupe(), maintenant: maintenant), isTrue);
    });

    test('tranche d\'âge : anniversaire déjà passé cette année', () {
      // Né le 1er janvier 2000, "maintenant" le 15 juin 2026 -> 26 ans.
      final fidele = _fidele(dateNaissance: DateTime(2000, 1, 1));
      expect(
        GroupeRules.correspond(fidele, const CriteresGroupe(ageMin: 26, ageMax: 26), maintenant: maintenant),
        isTrue,
      );
    });

    test('tranche d\'âge : anniversaire pas encore atteint cette année', () {
      // Né le 1er décembre 2000 -> encore 25 ans le 15 juin 2026.
      final fidele = _fidele(dateNaissance: DateTime(2000, 12, 1));
      expect(
        GroupeRules.correspond(fidele, const CriteresGroupe(ageMin: 26), maintenant: maintenant),
        isFalse,
      );
      expect(
        GroupeRules.correspond(fidele, const CriteresGroupe(ageMin: 25, ageMax: 25), maintenant: maintenant),
        isTrue,
      );
    });

    test('plusieurs critères combinés (ET logique)', () {
      final fidele = _fidele(
        dateNaissance: DateTime(2000, 1, 1),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.celibataire,
      );
      expect(
        GroupeRules.correspond(
          fidele,
          const CriteresGroupe(sexe: 'feminin', statutCivil: 'celibataire', ageMax: 30),
          maintenant: maintenant,
        ),
        isTrue,
      );
      expect(
        GroupeRules.correspond(
          fidele,
          const CriteresGroupe(sexe: 'feminin', statutCivil: 'marie', ageMax: 30),
          maintenant: maintenant,
        ),
        isFalse,
      );
    });

    test('critère statut spirituel', () {
      final fidele = _fidele(
        dateNaissance: DateTime(1990, 1, 1),
        statutSpirituel: StatutSpirituel.nouveauConverti,
      );
      expect(
        GroupeRules.correspond(
          fidele,
          const CriteresGroupe(statutSpirituel: 'nouveau_converti'),
          maintenant: maintenant,
        ),
        isTrue,
      );
    });
  });

  group('raisonBlocageAffectationManuelle (RG-VI-01)', () {
    test('groupe manuel -> toujours autorisé, aucun motif requis', () {
      expect(
        GroupeRules.raisonBlocageAffectationManuelle(
          typeRegle: TypeRegleGroupe.manuel,
          correspondAuxCriteres: false,
          aMotifDerogation: false,
        ),
        isNull,
      );
    });

    test('groupe auto, fidèle correspondant -> autorisé sans motif', () {
      expect(
        GroupeRules.raisonBlocageAffectationManuelle(
          typeRegle: TypeRegleGroupe.auto,
          correspondAuxCriteres: true,
          aMotifDerogation: false,
        ),
        isNull,
      );
    });

    test('groupe auto, fidèle non correspondant, sans motif -> bloqué', () {
      final erreur = GroupeRules.raisonBlocageAffectationManuelle(
        typeRegle: TypeRegleGroupe.auto,
        correspondAuxCriteres: false,
        aMotifDerogation: false,
      );
      expect(erreur?.code, 'derogation_requise_pour_affectation_manuelle');
    });

    test('groupe auto, fidèle non correspondant, avec motif -> autorisé (dérogation tracée)', () {
      expect(
        GroupeRules.raisonBlocageAffectationManuelle(
          typeRegle: TypeRegleGroupe.auto,
          correspondAuxCriteres: false,
          aMotifDerogation: true,
        ),
        isNull,
      );
    });
  });
}
