import 'package:ecclesias_360/features/archivage/domain/models/dossier_rattache.dart';
import 'package:ecclesias_360/features/archivage/domain/models/niveau_confidentialite.dart';
import 'package:ecclesias_360/features/archivage/domain/rules/archivage_rules.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
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

  group('peutConsulterDocument (RG-VIII-03, RG-X-05, miroir de document_archive_accessible)', () {
    const dossierInstruit = DossierRattache(dossierId: 'd1', commissionId: 'k1', trouve: true);
    const dossierSansCommission = DossierRattache(dossierId: 'd2', commissionId: null, trouve: true);

    bool peut(Role role, NiveauConfidentialite niveau, List<DossierRattache> dossiers, {Set<String> commissions = const {}}) =>
        ArchivageRules.peutConsulterDocument(
          role: role,
          niveau: niveau,
          dossiersRattaches: dossiers,
          commissionsDuConsultant: commissions,
        );

    test('document standard : à partir du rang responsable', () {
      expect(peut(Role.responsable, NiveauConfidentialite.standard, const []), isTrue);
      expect(peut(Role.membre, NiveauConfidentialite.standard, const []), isFalse);
    });

    test('document restreint : à partir du rang pasteur', () {
      expect(peut(Role.pasteur, NiveauConfidentialite.restreint, const []), isTrue);
      expect(peut(Role.responsable, NiveauConfidentialite.restreint, const []), isFalse);
    });

    test('pièce disciplinaire abaissée à standard : un responsable ne la lit toujours pas', () {
      expect(peut(Role.responsable, NiveauConfidentialite.standard, const [dossierInstruit]), isFalse);
    });

    test('pièce disciplinaire : la commission assignée la lit, quel que soit son rang', () {
      expect(peut(Role.membre, NiveauConfidentialite.restreint, const [dossierInstruit], commissions: {'k1'}), isTrue);
      expect(peut(Role.membre, NiveauConfidentialite.restreint, const [dossierInstruit], commissions: {'k2'}), isFalse);
    });

    test('pièce rattachée à plusieurs dossiers : chacun doit être accessible', () {
      expect(
        peut(Role.membre, NiveauConfidentialite.restreint, const [dossierInstruit, dossierSansCommission], commissions: {'k1'}),
        isFalse,
      );
      expect(peut(Role.pasteur, NiveauConfidentialite.restreint, const [dossierInstruit, dossierSansCommission]), isTrue);
    });

    test('origine disciplinaire introuvable : refus, même pour un pasteur', () {
      expect(
        peut(Role.pasteur, NiveauConfidentialite.restreint, const [DossierRattache(dossierId: 'x', commissionId: null, trouve: false)]),
        isFalse,
      );
    });
  });

  group('raisonBlocagePurge (RG-VIII-05)', () {
    test('un pasteur purge', () => expect(ArchivageRules.raisonBlocagePurge(roleActeur: Role.pasteur), isNull));

    test('un responsable ne purge pas', () {
      expect(ArchivageRules.raisonBlocagePurge(roleActeur: Role.responsable)?.code, 'role_insuffisant_pour_purge_document');
    });
  });
}
