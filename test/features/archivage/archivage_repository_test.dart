import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/archivage/data/archivage_repository.dart';
import 'package:ecclesias_360/features/archivage/domain/models/niveau_confidentialite.dart';
import 'package:ecclesias_360/features/archivage/domain/models/statut_document_archive.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ArchivageRepository repository;
  late String noeudId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = ArchivageRepository(db);

    noeudId = 'noeud-1';
    await db.into(db.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: noeudId,
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG',
            path: '/$noeudId/',
            depth: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
  });

  tearDown(() => db.close());

  group('archiver (RG-VIII-01)', () {
    test('refuse un type de document sans nomenclature configurée', () {
      expect(
        () => repository.archiver(
          typeDocument: 'type_inconnu',
          moduleOrigine: 'comite',
          objetIdOrigine: 'pv-1',
          noeudId: noeudId,
          fichier: 'contenu',
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'nomenclature_archivage_introuvable')),
      );
    });

    test('attribue un numéro conforme à la nomenclature seedée par défaut', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
      );
      final annee = DateTime.now().year;
      expect(document.numeroArchive, 'PV-GSG-$annee-0001');
      expect(document.statut, StatutDocumentArchive.actif);
      expect(document.niveauConfidentialite, NiveauConfidentialite.standard);
    });

    test('la séquence progresse par type de document et par nœud', () async {
      final premier = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu 1',
      );
      final second = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-2',
        noeudId: noeudId,
        fichier: 'contenu 2',
      );
      final annee = DateTime.now().year;
      expect(premier.numeroArchive, 'PV-GSG-$annee-0001');
      expect(second.numeroArchive, 'PV-GSG-$annee-0002');
    });

    test('sensible -> niveau de confidentialité restreint', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
        sensible: true,
      );
      expect(document.niveauConfidentialite, NiveauConfidentialite.restreint);
    });

    test('crée la version 1, accessible via watchVersions', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu v1',
      );
      final versions = await repository.watchVersions(document.id).first;
      expect(versions, hasLength(1));
      expect(versions.single.numeroVersion, 1);
      expect(versions.single.fichier, 'contenu v1');
    });
  });

  group('nouvelleVersion (RG-VIII-02)', () {
    test('ajoute une version sans effacer les précédentes', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu v1',
      );
      await repository.nouvelleVersion(documentId: document.id, fichier: 'contenu v2');

      final versions = await repository.watchVersions(document.id).first;
      expect(versions, hasLength(2));
      expect(versions.map((v) => v.numeroVersion), containsAll([1, 2]));

      final relu = await repository.findById(document.id);
      expect(relu!.fichier, 'contenu v2');
    });
  });

  group('corbeille et purge (RG-VIII-05)', () {
    test('mettreEnCorbeille puis restaurerDeCorbeille', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
      );
      await repository.mettreEnCorbeille(document.id);
      var relu = await repository.findById(document.id);
      expect(relu!.statut, StatutDocumentArchive.enCorbeille);
      expect(relu.dateMiseCorbeille, isNotNull);

      await repository.restaurerDeCorbeille(document.id);
      relu = await repository.findById(document.id);
      expect(relu!.statut, StatutDocumentArchive.actif);
      expect(relu.dateMiseCorbeille, isNull);
    });

    test('purgerDefinitivement refuse un document actif (jamais mis en corbeille)', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
      );
      expect(
        () => repository.purgerDefinitivement(document.id, delaiPurgeJours: 365, roleActeur: Role.pasteur),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'document_archive_non_purgeable')),
      );
    });

    test('purgerDefinitivement refuse tant que le délai n\'est pas écoulé', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
      );
      await repository.mettreEnCorbeille(document.id);
      expect(
        () => repository.purgerDefinitivement(document.id, delaiPurgeJours: 365, roleActeur: Role.pasteur),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'document_archive_non_purgeable')),
      );
    });

    test('purgerDefinitivement supprime le document et ses versions une fois le délai écoulé', () async {
      final document = await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
      );
      await repository.mettreEnCorbeille(document.id);

      await repository.purgerDefinitivement(document.id, delaiPurgeJours: 0, roleActeur: Role.pasteur);

      expect(await repository.findById(document.id), isNull);
      expect(await repository.watchVersions(document.id).first, isEmpty);
    });
  });

  group('documentsDe (RG-VIII-04)', () {
    test('retrouve les documents par module et objet d\'origine', () async {
      await repository.archiver(
        typeDocument: 'proces_verbal_comite',
        moduleOrigine: 'comite',
        objetIdOrigine: 'pv-1',
        noeudId: noeudId,
        fichier: 'contenu',
      );
      final documents = await repository.documentsDe(moduleOrigine: 'comite', objetIdOrigine: 'pv-1');
      expect(documents, hasLength(1));
      expect(documents.single.objetIdOrigine, 'pv-1');

      final aucun = await repository.documentsDe(moduleOrigine: 'comite', objetIdOrigine: 'pv-inexistant');
      expect(aucun, isEmpty);
    });
  });
}
