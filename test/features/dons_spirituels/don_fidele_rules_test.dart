import 'package:ecclesias_360/features/dons_spirituels/domain/models/don_fidele.dart';
import 'package:ecclesias_360/features/dons_spirituels/domain/models/don_ministere_compatible.dart';
import 'package:ecclesias_360/features/dons_spirituels/domain/models/niveau_maturite.dart';
import 'package:ecclesias_360/features/dons_spirituels/domain/rules/don_fidele_rules.dart';
import 'package:flutter_test/flutter_test.dart';

DonFidele _evaluation({required String id, required DateTime date, required NiveauMaturite niveau}) {
  return DonFidele(
    id: id,
    fideleId: 'f1',
    donId: 'don1',
    niveauMaturite: niveau,
    responsableSuiviId: 'pasteur1',
    dateEvaluation: date,
  );
}

void main() {
  group('evaluationCourante (RG-IV-02)', () {
    test('aucune évaluation -> null', () {
      expect(DonFideleRules.evaluationCourante(const []), isNull);
    });

    test('une seule évaluation -> elle-même', () {
      final e = _evaluation(id: 'e1', date: DateTime(2026, 1, 1), niveau: NiveauMaturite.emergent);
      expect(DonFideleRules.evaluationCourante([e]), e);
    });

    test('plusieurs évaluations -> la plus récente, l\'historique n\'est jamais écrasé', () {
      final ancienne = _evaluation(id: 'e1', date: DateTime(2025, 1, 1), niveau: NiveauMaturite.emergent);
      final recente = _evaluation(id: 'e2', date: DateTime(2026, 1, 1), niveau: NiveauMaturite.confirme);
      final resultat = DonFideleRules.evaluationCourante([ancienne, recente]);
      expect(resultat, recente);
      expect(resultat!.niveauMaturite, NiveauMaturite.confirme);
    });
  });

  group('typesMinisteresCompatibles (RG-IV-03)', () {
    test('aucune correspondance configurée -> liste vide (jamais d\'affectation automatique)', () {
      expect(DonFideleRules.typesMinisteresCompatibles('don1', const []), isEmpty);
    });

    test('ne retourne que les correspondances du don demandé', () {
      const correspondances = [
        DonMinistereCompatible(id: 'c1', donId: 'don1', typeMinistereId: 'type-chorale'),
        DonMinistereCompatible(id: 'c2', donId: 'don2', typeMinistereId: 'type-media'),
      ];
      expect(
        DonFideleRules.typesMinisteresCompatibles('don1', correspondances),
        ['type-chorale'],
      );
    });
  });
}
