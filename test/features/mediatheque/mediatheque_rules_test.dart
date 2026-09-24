import 'package:ecclesias_360/features/mediatheque/domain/models/statut_moderation_commentaire.dart';
import 'package:ecclesias_360/features/mediatheque/domain/rules/mediatheque_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('statutInitialCommentaire (RG-XIII-03)', () {
    test('modération a priori : le commentaire reste en attente', () {
      expect(
        MediathequeRules.statutInitialCommentaire(moderationAPriori: true),
        StatutModerationCommentaire.enAttente,
      );
    });

    test('modération a posteriori : le commentaire est publié immédiatement', () {
      expect(
        MediathequeRules.statutInitialCommentaire(moderationAPriori: false),
        StatutModerationCommentaire.publie,
      );
    });
  });

  group('doitMasquerAutomatiquement (RG-XIII-03)', () {
    test('sous le seuil : pas de masquage', () {
      expect(
        MediathequeRules.doitMasquerAutomatiquement(signaleursDistincts: 2, seuil: 3),
        isFalse,
      );
    });

    test('au seuil exact : masquage', () {
      expect(
        MediathequeRules.doitMasquerAutomatiquement(signaleursDistincts: 3, seuil: 3),
        isTrue,
      );
    });

    test('au-delà du seuil : masquage', () {
      expect(
        MediathequeRules.doitMasquerAutomatiquement(signaleursDistincts: 5, seuil: 3),
        isTrue,
      );
    });
  });

  group('commentaireVisible (RG-XIII-03)', () {
    test('un commentaire publié est visible de tous', () {
      expect(
        MediathequeRules.commentaireVisible(
          statut: StatutModerationCommentaire.publie,
          estAuteur: false,
          estModerateur: false,
        ),
        isTrue,
      );
    });

    test('un commentaire en attente : son auteur et les modérateurs seulement', () {
      bool visible({required bool auteur, required bool moderateur}) => MediathequeRules.commentaireVisible(
            statut: StatutModerationCommentaire.enAttente,
            estAuteur: auteur,
            estModerateur: moderateur,
          );
      expect(visible(auteur: true, moderateur: false), isTrue);
      expect(visible(auteur: false, moderateur: true), isTrue);
      expect(visible(auteur: false, moderateur: false), isFalse);
    });

    test("un commentaire masqué n'est affiché à personne", () {
      expect(
        MediathequeRules.commentaireVisible(
          statut: StatutModerationCommentaire.masque,
          estAuteur: true,
          estModerateur: true,
        ),
        isFalse,
      );
    });
  });
}
