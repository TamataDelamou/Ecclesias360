import 'package:ecclesias_360/features/bible/domain/models/livre_biblique.dart';
import 'package:ecclesias_360/features/bible/domain/rules/bible_reference_rules.dart';
import 'package:ecclesias_360/features/bible/domain/rules/recherche_biblique_rules.dart';
import 'package:ecclesias_360/features/bible/domain/rules/verset_du_jour_rules.dart';
import 'package:flutter_test/flutter_test.dart';

/// Module XXIV — règles pures de référence, de recherche et de verset du jour.
void main() {
  const genese = LivreBiblique(bookId: 1, nom: 'Genèse', abreviation: 'Gn', ordre: 1, deuterocanonique: false, nbChapitres: 50);
  const esaie = LivreBiblique(bookId: 23, nom: 'Ésaïe', abreviation: 'Es', ordre: 2, deuterocanonique: false, nbChapitres: 66);
  const jean = LivreBiblique(bookId: 43, nom: 'Jean', abreviation: 'Jn', ordre: 3, deuterocanonique: false, nbChapitres: 21);
  const corinthiens =
      LivreBiblique(bookId: 46, nom: '1 Corinthiens', abreviation: '1Co', ordre: 4, deuterocanonique: false, nbChapitres: 16);
  const apocalypse =
      LivreBiblique(bookId: 66, nom: 'Apocalypse', abreviation: 'Ap', ordre: 5, deuterocanonique: false, nbChapitres: 22);
  const livres = [genese, esaie, jean, corinthiens, apocalypse];

  group('BibleReferenceRules.lire', () {
    test('nom complet, abréviation, séparateurs « : » et « , »', () {
      expect(BibleReferenceRules.lire('Jean 3:16', livres), const ReferenceBiblique(bookId: 43, chapitre: 3, verset: 16));
      expect(BibleReferenceRules.lire('jn 3,16', livres), const ReferenceBiblique(bookId: 43, chapitre: 3, verset: 16));
      expect(BibleReferenceRules.lire('1 Co 13', livres), const ReferenceBiblique(bookId: 46, chapitre: 13));
    });

    test('insensible aux accents et aux préfixes non ambigus', () {
      expect(BibleReferenceRules.lire('esaie 40', livres), const ReferenceBiblique(bookId: 23, chapitre: 40));
      expect(BibleReferenceRules.lire('Genes 1', livres), const ReferenceBiblique(bookId: 1, chapitre: 1));
    });

    test('refuse un livre inconnu ou un chapitre absent de la version', () {
      expect(BibleReferenceRules.lire('Tobie 1', livres), isNull);
      expect(BibleReferenceRules.lire('Jean 22', livres), isNull);
      expect(BibleReferenceRules.lire('eternel', livres), isNull);
    });
  });

  group('navigation entre chapitres, dans l\'ordre d\'affichage de la version', () {
    test('passe au livre suivant après le dernier chapitre, s\'arrête à la fin', () {
      expect(BibleReferenceRules.chapitreSuivant(const ReferenceBiblique(bookId: 43, chapitre: 21), livres),
          const ReferenceBiblique(bookId: 46, chapitre: 1));
      expect(BibleReferenceRules.chapitreSuivant(const ReferenceBiblique(bookId: 66, chapitre: 22), livres), isNull);
    });

    test('revient au dernier chapitre du livre précédent, s\'arrête au début', () {
      expect(BibleReferenceRules.chapitrePrecedent(const ReferenceBiblique(bookId: 43, chapitre: 1), livres),
          const ReferenceBiblique(bookId: 23, chapitre: 66));
      expect(BibleReferenceRules.chapitrePrecedent(const ReferenceBiblique(bookId: 1, chapitre: 1), livres), isNull);
    });

    test('suit l\'ordre propre à la version, jamais l\'identifiant stable', () {
      // Ordre catholique : Tobie (67) s'intercale après Néhémie (16).
      const nehemie = LivreBiblique(bookId: 16, nom: 'Néhémie', abreviation: 'Né', ordre: 16, deuterocanonique: false, nbChapitres: 13);
      const tobie = LivreBiblique(bookId: 67, nom: 'Tobie', abreviation: 'Tb', ordre: 17, deuterocanonique: true, nbChapitres: 14);
      const esther = LivreBiblique(bookId: 17, nom: 'Esther', abreviation: 'Est', ordre: 19, deuterocanonique: false, nbChapitres: 16);
      expect(BibleReferenceRules.chapitreSuivant(const ReferenceBiblique(bookId: 16, chapitre: 13), [esther, tobie, nehemie]),
          const ReferenceBiblique(bookId: 67, chapitre: 1));
    });
  });

  group('adapterAVersion', () {
    test('garde livre, chapitre et verset quand la version les possède', () {
      expect(BibleReferenceRules.adapterAVersion(const ReferenceBiblique(bookId: 43, chapitre: 3, verset: 16), livres),
          const ReferenceBiblique(bookId: 43, chapitre: 3, verset: 16));
    });

    test('un livre deutérocanonique absent de la version ramène au début', () {
      expect(BibleReferenceRules.adapterAVersion(const ReferenceBiblique(bookId: 67, chapitre: 3), livres),
          const ReferenceBiblique(bookId: 1, chapitre: 1));
    });

    test('un chapitre au-delà de la versification ramène au dernier chapitre', () {
      expect(BibleReferenceRules.adapterAVersion(const ReferenceBiblique(bookId: 43, chapitre: 30), livres),
          const ReferenceBiblique(bookId: 43, chapitre: 21));
    });
  });

  group('RechercheBibliqueRules.expressionFts (RG-XXIV-05)', () {
    test('chaque mot entre guillemets, le dernier en préfixe', () {
      expect(RechercheBibliqueRules.expressionFts('Éternel berger'), '"Éternel" "berger"*');
    });

    test('neutralise la syntaxe FTS5 saisie par l\'utilisateur', () {
      expect(RechercheBibliqueRules.expressionFts('amour OR "haine" NEAR(x)'), '"amour" "OR" "haine" "NEAR"*');
    });

    test('rien à chercher : null', () {
      expect(RechercheBibliqueRules.expressionFts('  a , ; '), isNull);
    });
  });

  group('VersetDuJourRules', () {
    const rotation = [
      ReferenceBiblique(bookId: 19, chapitre: 23, verset: 1),
      ReferenceBiblique(bookId: 43, chapitre: 3, verset: 16),
    ];

    test('précédence : manuel, puis plan, puis rotation', () {
      const manuel = ReferenceBiblique(bookId: 1, chapitre: 1, verset: 1);
      const plan = ReferenceBiblique(bookId: 66, chapitre: 1, verset: 1);
      final date = DateTime(2026, 9, 24);
      expect(VersetDuJourRules.choisir(date: date, rotation: rotation, manuel: manuel, plan: plan),
          (manuel, OrigineVersetDuJour.manuel));
      expect(VersetDuJourRules.choisir(date: date, rotation: rotation, plan: plan), (plan, OrigineVersetDuJour.plan));
      expect(VersetDuJourRules.choisir(date: date, rotation: rotation).$2, OrigineVersetDuJour.rotation);
    });

    test('rotation : le même verset toute la journée, un autre le lendemain', () {
      final matin = VersetDuJourRules.choisir(date: DateTime(2026, 9, 24, 6), rotation: rotation).$1;
      final soir = VersetDuJourRules.choisir(date: DateTime(2026, 9, 24, 23, 59), rotation: rotation).$1;
      final lendemain = VersetDuJourRules.choisir(date: DateTime(2026, 9, 25, 6), rotation: rotation).$1;
      expect(soir, matin);
      expect(lendemain, isNot(matin));
    });
  });
}
