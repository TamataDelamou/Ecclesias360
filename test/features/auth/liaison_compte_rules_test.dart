import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/auth/domain/models/issue_liaison.dart';
import 'package:ecclesias_360/features/auth/domain/rules/liaison_compte_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const telephone = IdentifiantTelephone('+224620000001');

  group('LiaisonCompteRules.decider (RG-SEC-01, RG-SEC-06bis)', () {
    test('une seule fiche correspondante, jamais liée : liaison automatique', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: telephone,
        baseVide: false,
        fiches: const [
          FicheCandidate(fideleId: 'f1', telephone: '+224 620 00 00 01'),
          FicheCandidate(fideleId: 'f2', telephone: '+224 620 00 00 02'),
        ],
      );
      expect(decision.issue, IssueLiaison.lieAutomatiquement);
      expect(decision.fideleId, 'f1');
    });

    test('la correspondance e-mail ignore la casse', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: const IdentifiantEmail('marie@eglise.org'),
        baseVide: false,
        fiches: const [FicheCandidate(fideleId: 'f1', email: 'Marie@Eglise.org')],
      );
      expect(decision.issue, IssueLiaison.lieAutomatiquement);
    });

    test('aucune correspondance : utilisateur simple', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: telephone,
        baseVide: false,
        fiches: const [FicheCandidate(fideleId: 'f1', telephone: '+224620000009')],
      );
      expect(decision.issue, IssueLiaison.aucuneCorrespondance);
      expect(decision.issue.enAttenteAdministrateur, isFalse);
    });

    test('plusieurs correspondances : utilisateur simple, conflit signalé, aucune fiche choisie', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: telephone,
        baseVide: false,
        fiches: const [
          FicheCandidate(fideleId: 'f1', telephone: '+224620000001'),
          FicheCandidate(fideleId: 'f2', telephone: '00224 620 000 001'),
        ],
      );
      expect(decision.issue, IssueLiaison.correspondanceMultiple);
      expect(decision.fideleId, isNull);
      expect(decision.issue.enAttenteAdministrateur, isTrue);
    });

    test('garde-fou SIM churn : une fiche déjà liée à un autre compte n\'est jamais liée à nouveau', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: telephone,
        baseVide: false,
        fiches: const [FicheCandidate(fideleId: 'f1', telephone: '+224620000001', authUserId: 'ancien-titulaire')],
      );
      expect(decision.issue, IssueLiaison.ficheDejaLiee);
      expect(decision.fideleId, 'f1');
      expect(decision.issue.enAttenteAdministrateur, isTrue);
    });

    test('garde-fou SIM churn : une fiche liée par le passé (lien retiré depuis) reste protégée', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: telephone,
        baseVide: false,
        fiches: const [FicheCandidate(fideleId: 'f1', telephone: '+224620000001', dejaLieeUneFois: true)],
      );
      expect(decision.issue, IssueLiaison.ficheDejaLiee);
    });

    test('un numéro de fiche au format national ne correspond jamais (indicatif non deviné)', () {
      final decision = LiaisonCompteRules.decider(
        identifiant: telephone,
        baseVide: false,
        fiches: const [FicheCandidate(fideleId: 'f1', telephone: '620000001')],
      );
      expect(decision.issue, IssueLiaison.aucuneCorrespondance);
    });

    test('base vide : premier compte administrateur d\'amorçage', () {
      final decision = LiaisonCompteRules.decider(identifiant: telephone, baseVide: true, fiches: const []);
      expect(decision.issue, IssueLiaison.administrateurAmorcage);
    });
  });
}
