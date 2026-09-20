import 'package:ecclesias_360/features/archivage/domain/models/niveau_confidentialite.dart';
import 'package:ecclesias_360/features/archivage/domain/rules/archivage_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('genererNumero (RG-VIII-01)', () {
    test('remplace tous les jetons et complète la séquence à gauche', () {
      final numero = ArchivageRules.genererNumero(
        modeleNumerotation: 'PV-{noeud}-{annee}-{sequence}',
        typeDocument: 'proces_verbal_comite',
        codeNoeud: 'GSG',
        annee: 2026,
        sequence: 7,
        sequencePadding: 4,
      );
      expect(numero, 'PV-GSG-2026-0007');
    });

    test('jeton {type} disponible pour une nomenclature qui le référence', () {
      final numero = ArchivageRules.genererNumero(
        modeleNumerotation: '{type}-{sequence}',
        typeDocument: 'certificat',
        codeNoeud: 'GSG',
        annee: 2026,
        sequence: 1,
        sequencePadding: 2,
      );
      expect(numero, 'certificat-01');
    });
  });

  group('niveauConfidentialiteEffectif (RG-VIII-03)', () {
    test('sensible -> restreint', () {
      expect(
        ArchivageRules.niveauConfidentialiteEffectif(sensible: true),
        NiveauConfidentialite.restreint,
      );
    });

    test('non sensible -> standard', () {
      expect(
        ArchivageRules.niveauConfidentialiteEffectif(sensible: false),
        NiveauConfidentialite.standard,
      );
    });
  });

  group('estPurgeable (RG-VIII-05)', () {
    test('délai non écoulé -> non purgeable', () {
      final miseCorbeille = DateTime(2026, 1, 1);
      expect(
        ArchivageRules.estPurgeable(
          dateMiseCorbeille: miseCorbeille,
          delaiPurgeJours: 365,
          maintenant: DateTime(2026, 6, 1),
        ),
        isFalse,
      );
    });

    test('délai tout juste écoulé -> purgeable', () {
      final miseCorbeille = DateTime(2026, 1, 1);
      expect(
        ArchivageRules.estPurgeable(
          dateMiseCorbeille: miseCorbeille,
          delaiPurgeJours: 365,
          maintenant: DateTime(2027, 1, 1),
        ),
        isTrue,
      );
    });

    test('délai largement dépassé -> purgeable', () {
      final miseCorbeille = DateTime(2020, 1, 1);
      expect(
        ArchivageRules.estPurgeable(
          dateMiseCorbeille: miseCorbeille,
          delaiPurgeJours: 365,
          maintenant: DateTime(2026, 1, 1),
        ),
        isTrue,
      );
    });
  });
}
