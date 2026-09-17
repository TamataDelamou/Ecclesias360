import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/organization/domain/models/categorie_confessionnelle.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:ecclesias_360/features/organization/domain/rules/organisation_node_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validerCoherenceType (RG-I-01)', () {
    test('siège sans parent et sans racine existante est valide', () {
      expect(
        () => OrganisationNodeRules.validerCoherenceType(
          type: TypeNoeud.siege,
          noeudParentId: null,
          racineExisteDeja: false,
        ),
        returnsNormally,
      );
    });

    test('siège avec un parent est rejeté', () {
      expect(
        () => OrganisationNodeRules.validerCoherenceType(
          type: TypeNoeud.siege,
          noeudParentId: 'un-id',
          racineExisteDeja: false,
        ),
        throwsArgumentError,
      );
    });

    test('second siège alors qu\'une racine existe déjà lève AppError.rootAlreadyExists', () {
      expect(
        () => OrganisationNodeRules.validerCoherenceType(
          type: TypeNoeud.siege,
          noeudParentId: null,
          racineExisteDeja: true,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'root_already_exists')),
      );
    });

    test('nœud non-siège sans parent est rejeté', () {
      expect(
        () => OrganisationNodeRules.validerCoherenceType(
          type: TypeNoeud.egliseLocale,
          noeudParentId: null,
          racineExisteDeja: true,
        ),
        throwsArgumentError,
      );
    });

    test('nœud non-siège avec parent est valide', () {
      expect(
        () => OrganisationNodeRules.validerCoherenceType(
          type: TypeNoeud.district,
          noeudParentId: 'parent-id',
          racineExisteDeja: true,
        ),
        returnsNormally,
      );
    });
  });

  group('validerCategorieConfessionnelle (RG-I-09)', () {
    test('église locale sans catégorie est rejetée', () {
      expect(
        () => OrganisationNodeRules.validerCategorieConfessionnelle(
          type: TypeNoeud.egliseLocale,
          categorie: null,
        ),
        throwsArgumentError,
      );
    });

    test('église locale avec catégorie est valide', () {
      expect(
        () => OrganisationNodeRules.validerCategorieConfessionnelle(
          type: TypeNoeud.egliseLocale,
          categorie: CategorieConfessionnelle.autres,
        ),
        returnsNormally,
      );
    });

    test('nœud non-église-locale avec catégorie renseignée est rejeté', () {
      expect(
        () => OrganisationNodeRules.validerCategorieConfessionnelle(
          type: TypeNoeud.district,
          categorie: CategorieConfessionnelle.autres,
        ),
        throwsArgumentError,
      );
    });

    test('nœud non-église-locale sans catégorie est valide', () {
      expect(
        () => OrganisationNodeRules.validerCategorieConfessionnelle(
          type: TypeNoeud.district,
          categorie: null,
        ),
        returnsNormally,
      );
    });
  });

  group('construirePath / calculerProfondeur', () {
    test('racine produit un chemin à un seul segment et une profondeur de 0', () {
      final path = OrganisationNodeRules.construirePath(parentPath: null, nodeId: 'siege-id');
      expect(path, '/siege-id/');
      expect(OrganisationNodeRules.calculerProfondeur(path), 0);
    });

    test('un enfant concatène son id au chemin du parent et incrémente la profondeur', () {
      const parentPath = '/siege-id/';
      final path = OrganisationNodeRules.construirePath(parentPath: parentPath, nodeId: 'union-id');
      expect(path, '/siege-id/union-id/');
      expect(OrganisationNodeRules.calculerProfondeur(path), 1);
    });

    test('trois niveaux donnent une profondeur de 2', () {
      const path = '/siege-id/union-id/district-id/';
      expect(OrganisationNodeRules.calculerProfondeur(path), 2);
    });
  });

  group('validerNouveauRattachement (RG-I-06)', () {
    test('rattacher un nœud à lui-même est rejeté', () {
      expect(
        () => OrganisationNodeRules.validerNouveauRattachement(
          nodeId: 'a',
          nouveauParentId: 'a',
          nouveauParentPath: '/a/',
        ),
        throwsArgumentError,
      );
    });

    test('rattacher un nœud à l\'un de ses propres descendants est rejeté (cycle)', () {
      expect(
        () => OrganisationNodeRules.validerNouveauRattachement(
          nodeId: 'a',
          nouveauParentId: 'b',
          nouveauParentPath: '/racine/a/b/',
        ),
        throwsArgumentError,
      );
    });

    test('rattacher un nœud à un nœud pair est valide', () {
      expect(
        () => OrganisationNodeRules.validerNouveauRattachement(
          nodeId: 'a',
          nouveauParentId: 'c',
          nouveauParentPath: '/racine/c/',
        ),
        returnsNormally,
      );
    });
  });

  group('raisonBlocageSuppression (RG-I-02)', () {
    test('aucun rattachement -> suppression autorisée', () {
      final erreur = OrganisationNodeRules.raisonBlocageSuppression(
        aDesEnfants: false,
        aAutresRattachements: false,
      );
      expect(erreur, isNull);
    });

    test('des enfants actifs -> suppression bloquée', () {
      final erreur = OrganisationNodeRules.raisonBlocageSuppression(
        aDesEnfants: true,
        aAutresRattachements: false,
      );
      expect(erreur?.code, 'node_has_blocking_references');
    });

    test('d\'autres rattachements -> suppression bloquée', () {
      final erreur = OrganisationNodeRules.raisonBlocageSuppression(
        aDesEnfants: false,
        aAutresRattachements: true,
      );
      expect(erreur?.code, 'node_has_blocking_references');
    });
  });
}
