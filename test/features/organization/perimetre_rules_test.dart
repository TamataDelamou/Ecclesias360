import 'package:ecclesias_360/features/organization/domain/rules/perimetre_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mandatActif (RG-I-05)', () {
    test('dateFin nulle -> mandat actif', () {
      expect(PerimetreRules.mandatActif(dateFin: null), isTrue);
    });

    test('dateFin future -> mandat actif', () {
      final reference = DateTime(2026, 1, 1);
      expect(
        PerimetreRules.mandatActif(dateFin: DateTime(2026, 6, 1), reference: reference),
        isTrue,
      );
    });

    test('dateFin passée -> mandat expiré', () {
      final reference = DateTime(2026, 6, 1);
      expect(
        PerimetreRules.mandatActif(dateFin: DateTime(2026, 1, 1), reference: reference),
        isFalse,
      );
    });
  });

  group('noeudsDuPerimetre (RG-SEC-05)', () {
    // Arbre : siège(/s/) -> union(/s/u/) -> district(/s/u/d/)
    //                    -> union2(/s/u2/)
    const paths = {
      's': '/s/',
      'u': '/s/u/',
      'd': '/s/u/d/',
      'u2': '/s/u2/',
    };

    test('un mandat sur une union donne l\'union et ses descendants, jamais les pairs', () {
      final perimetre = PerimetreRules.noeudsDuPerimetre(
        racinesMandat: ['u'],
        pathParNoeudId: paths,
      );
      expect(perimetre, {'u', 'd'});
      expect(perimetre.contains('u2'), isFalse);
      expect(perimetre.contains('s'), isFalse);
    });

    test('un mandat sur le siège donne tout l\'arbre', () {
      final perimetre = PerimetreRules.noeudsDuPerimetre(
        racinesMandat: ['s'],
        pathParNoeudId: paths,
      );
      expect(perimetre, {'s', 'u', 'd', 'u2'});
    });

    test('un mandat sur une feuille (district) donne seulement elle-même', () {
      final perimetre = PerimetreRules.noeudsDuPerimetre(
        racinesMandat: ['d'],
        pathParNoeudId: paths,
      );
      expect(perimetre, {'d'});
    });

    test('aucun mandat -> périmètre vide', () {
      expect(
        PerimetreRules.noeudsDuPerimetre(racinesMandat: const [], pathParNoeudId: paths),
        isEmpty,
      );
    });

    test('plusieurs mandats s\'additionnent (union des périmètres)', () {
      final perimetre = PerimetreRules.noeudsDuPerimetre(
        racinesMandat: ['u', 'u2'],
        pathParNoeudId: paths,
      );
      expect(perimetre, {'u', 'd', 'u2'});
    });
  });
}
