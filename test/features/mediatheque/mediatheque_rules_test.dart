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
        MediathequeRules.doitMasquerAutomatiquement(nombreSignalements: 2, seuil: 3),
        isFalse,
      );
    });

    test('au seuil exact : masquage', () {
      expect(
        MediathequeRules.doitMasquerAutomatiquement(nombreSignalements: 3, seuil: 3),
        isTrue,
      );
    });

    test('au-delà du seuil : masquage', () {
      expect(
        MediathequeRules.doitMasquerAutomatiquement(nombreSignalements: 5, seuil: 3),
        isTrue,
      );
    });
  });
}
