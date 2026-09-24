import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:ecclesias_360/features/organization/domain/rules/organisation_acces_rules.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

/// Miroir local des policies `organisation_nodes` / `node_responsables` (0019).
void main() {
  group('peutConsulterNoeud (RG-SEC-04/05)', () {
    test('un responsable voit tout l\'arbre', () {
      expect(
        OrganisationAccesRules.peutConsulterNoeud(role: Role.responsable, noeudId: 'n2', noeudDuConsultant: 'n1'),
        isTrue,
      );
    });

    test('un membre ne voit que son église', () {
      expect(
        OrganisationAccesRules.peutConsulterNoeud(role: Role.membre, noeudId: 'n1', noeudDuConsultant: 'n1'),
        isTrue,
      );
      expect(
        OrganisationAccesRules.peutConsulterNoeud(role: Role.membre, noeudId: 'n2', noeudDuConsultant: 'n1'),
        isFalse,
      );
    });

    test('un utilisateur simple ne voit aucun nœud (RG-SEC-06bis)', () {
      expect(
        OrganisationAccesRules.peutConsulterNoeud(role: Role.utilisateurSimple, noeudId: 'n1', noeudDuConsultant: null),
        isFalse,
      );
    });
  });

  test('gestion des nœuds au rang responsable, désignation des responsables au rang pasteur', () {
    expect(OrganisationAccesRules.peutGererNoeuds(Role.responsable), isTrue);
    expect(OrganisationAccesRules.peutGererNoeuds(Role.membre), isFalse);
    expect(OrganisationAccesRules.peutDesignerResponsables(Role.pasteur), isTrue);
    expect(OrganisationAccesRules.peutDesignerResponsables(Role.responsable), isFalse);
  });

  test('RG-I-03 : seule l\'église locale échappe à la capacité de niveau supérieur', () {
    expect(OrganisationAccesRules.exigeCapaciteNiveauSuperieur(TypeNoeud.egliseLocale), isFalse);
    for (final type in TypeNoeud.values.where((t) => t != TypeNoeud.egliseLocale)) {
      expect(OrganisationAccesRules.exigeCapaciteNiveauSuperieur(type), isTrue, reason: type.code);
    }
  });
}
