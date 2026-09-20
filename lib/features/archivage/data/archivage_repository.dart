import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/theme/app_defaults.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/document_archive.dart';
import '../domain/models/niveau_confidentialite.dart';
import '../domain/models/nomenclature_archivage.dart';
import '../domain/models/statut_document_archive.dart';
import '../domain/models/version_document.dart';
import '../domain/rules/archivage_rules.dart';

/// Dépôt Module VIII — archivage documentaire (RG-VIII-01 à 06). Greffe
/// transversale, consommée par les modules producteurs (ex.
/// `ComiteRepository` pour les PV, RG-VII-03) via injection optionnelle —
/// même pattern que l'intégration CV/Déplacements documentée dans
/// `RECONSTRUCTION_ecclesias360.md` §2.
///
/// RG-VIII-06 — la garantie de séquence unique inter-appareils à la
/// synchronisation reste différée pour cette itération : la numérotation est
/// calculée localement, de façon déterministe par type/nœud/année, même
/// précédent documenté que la synchronisation distante différée sur tous les
/// autres modules du dépôt.
class ArchivageRepository {
  ArchivageRepository(this._db);

  final AppDatabase _db;

  // --- Nomenclature (RG-VIII-01) -------------------------------------------

  Future<NomenclatureArchivage?> nomenclaturePour(String typeDocument) async {
    final row = await (_db.select(_db.nomenclaturesArchivage)
          ..where((t) => t.typeDocument.equals(typeDocument)))
        .getSingleOrNull();
    return row == null ? null : _nomenclatureToDomain(row);
  }

  Future<void> definirNomenclature({
    required String typeDocument,
    required String modeleNumerotation,
  }) async {
    final existante = await (_db.select(_db.nomenclaturesArchivage)
          ..where((t) => t.typeDocument.equals(typeDocument)))
        .getSingleOrNull();
    if (existante != null) {
      await (_db.update(_db.nomenclaturesArchivage)..where((t) => t.id.equals(existante.id)))
          .write(NomenclaturesArchivageCompanion(modeleNumerotation: Value(modeleNumerotation)));
    } else {
      await _db.into(_db.nomenclaturesArchivage).insert(
            NomenclaturesArchivageCompanion.insert(
              id: IdGenerator.newId(),
              typeDocument: typeDocument,
              modeleNumerotation: modeleNumerotation,
            ),
          );
    }
  }

  // --- Archivage (RG-VIII-01/03/04) -----------------------------------------

  /// RG-VIII-01 — le numéro est attribué immédiatement à l'appel : Module
  /// VIII ne reçoit jamais de contenu à l'état de brouillon, la validation a
  /// lieu dans le module producteur avant cet appel. Lève
  /// `AppError.nomenclatureArchivageIntrouvable` si aucune nomenclature n'est
  /// configurée pour ce type de document.
  Future<DocumentArchive> archiver({
    required String typeDocument,
    required String moduleOrigine,
    required String objetIdOrigine,
    required String noeudId,
    required String fichier,
    bool sensible = false,
  }) async {
    final nomenclature = await nomenclaturePour(typeDocument);
    if (nomenclature == null) {
      throw AppError.nomenclatureArchivageIntrouvable();
    }
    final noeud = await (_db.select(_db.organisationNodes)..where((t) => t.id.equals(noeudId))).getSingle();
    final annee = DateTime.now().year;
    final sequence = await _prochaineSequence(typeDocument: typeDocument, noeudId: noeudId, annee: annee);
    final numero = ArchivageRules.genererNumero(
      modeleNumerotation: nomenclature.modeleNumerotation,
      typeDocument: typeDocument,
      codeNoeud: noeud.codeInterne,
      annee: annee,
      sequence: sequence,
      sequencePadding: AppDefaults.archivageSequencePadding,
    );

    final id = IdGenerator.newId();
    final maintenant = DateTime.now();
    final niveau = ArchivageRules.niveauConfidentialiteEffectif(sensible: sensible);

    await _db.into(_db.documentsArchive).insert(
          DocumentsArchiveCompanion.insert(
            id: id,
            numeroArchive: numero,
            typeDocument: typeDocument,
            moduleOrigine: moduleOrigine,
            objetIdOrigine: objetIdOrigine,
            noeudId: noeudId,
            niveauConfidentialite: Value(niveau.code),
            fichier: fichier,
            dateArchivage: maintenant,
            createdAt: maintenant,
            updatedAt: maintenant,
          ),
        );
    await _db.into(_db.versionsDocument).insert(
          VersionsDocumentCompanion.insert(
            id: IdGenerator.newId(),
            documentId: id,
            numeroVersion: 1,
            fichier: fichier,
            date: maintenant,
          ),
        );

    final row = await (_db.select(_db.documentsArchive)..where((t) => t.id.equals(id))).getSingle();
    return _documentToDomain(row);
  }

  Future<int> _prochaineSequence({
    required String typeDocument,
    required String noeudId,
    required int annee,
  }) async {
    final rows = await (_db.select(_db.documentsArchive)
          ..where((t) => t.typeDocument.equals(typeDocument) & t.noeudId.equals(noeudId)))
        .get();
    return rows.where((r) => r.dateArchivage.year == annee).length + 1;
  }

  // --- Versions (RG-VIII-02) --------------------------------------------------

  Stream<List<VersionDocument>> watchVersions(String documentId) {
    final query = _db.select(_db.versionsDocument)
      ..where((t) => t.documentId.equals(documentId))
      ..orderBy([(t) => OrderingTerm.desc(t.numeroVersion)]);
    return query.watch().map((rows) => rows.map(_versionToDomain).toList(growable: false));
  }

  /// RG-VIII-02 — un document archivé est en lecture seule : toute nouvelle
  /// version crée un enregistrement lié, l'original (version 1) restant
  /// accessible via `watchVersions`. Ce dépôt n'expose volontairement aucune
  /// méthode de modification directe du contenu (voir RG-VIII-05 pour la
  /// suppression : même absence délibérée d'API).
  Future<VersionDocument> nouvelleVersion({
    required String documentId,
    required String fichier,
  }) async {
    final derniere = await (_db.select(_db.versionsDocument)
          ..where((t) => t.documentId.equals(documentId))
          ..orderBy([(t) => OrderingTerm.desc(t.numeroVersion)])
          ..limit(1))
        .getSingle();

    final id = IdGenerator.newId();
    final maintenant = DateTime.now();
    await _db.into(_db.versionsDocument).insert(
          VersionsDocumentCompanion.insert(
            id: id,
            documentId: documentId,
            numeroVersion: derniere.numeroVersion + 1,
            fichier: fichier,
            date: maintenant,
          ),
        );
    await (_db.update(_db.documentsArchive)..where((t) => t.id.equals(documentId)))
        .write(DocumentsArchiveCompanion(fichier: Value(fichier), updatedAt: Value(maintenant)));

    final row = await (_db.select(_db.versionsDocument)..where((t) => t.id.equals(id))).getSingle();
    return _versionToDomain(row);
  }

  // --- Bibliothèque / navigation croisée (RG-VIII-04) --------------------------

  Stream<List<DocumentArchive>> watchBibliotheque({String? noeudId, String? moduleOrigine}) {
    final query = _db.select(_db.documentsArchive)
      ..where((t) => t.statut.equals(StatutDocumentArchive.actif.code));
    if (noeudId != null) {
      query.where((t) => t.noeudId.equals(noeudId));
    }
    if (moduleOrigine != null) {
      query.where((t) => t.moduleOrigine.equals(moduleOrigine));
    }
    return query.watch().map((rows) => rows.map(_documentToDomain).toList(growable: false));
  }

  /// RG-VIII-04 — navigation croisée depuis l'objet métier d'origine (ex.
  /// fiche fidèle, séance de comité) vers ses documents archivés.
  Future<List<DocumentArchive>> documentsDe({
    required String moduleOrigine,
    required String objetIdOrigine,
  }) async {
    final rows = await (_db.select(_db.documentsArchive)
          ..where((t) => t.moduleOrigine.equals(moduleOrigine) & t.objetIdOrigine.equals(objetIdOrigine)))
        .get();
    return rows.map(_documentToDomain).toList(growable: false);
  }

  Future<DocumentArchive?> findById(String id) async {
    final row = await (_db.select(_db.documentsArchive)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _documentToDomain(row);
  }

  // --- Corbeille (RG-VIII-05) ---------------------------------------------------

  Stream<List<DocumentArchive>> watchCorbeille({String? noeudId}) {
    final query = _db.select(_db.documentsArchive)
      ..where((t) => t.statut.equals(StatutDocumentArchive.enCorbeille.code));
    if (noeudId != null) {
      query.where((t) => t.noeudId.equals(noeudId));
    }
    return query.watch().map((rows) => rows.map(_documentToDomain).toList(growable: false));
  }

  Future<void> mettreEnCorbeille(String id) {
    return (_db.update(_db.documentsArchive)..where((t) => t.id.equals(id))).write(
      DocumentsArchiveCompanion(
        statut: Value(StatutDocumentArchive.enCorbeille.code),
        dateMiseCorbeille: Value(DateTime.now()),
      ),
    );
  }

  Future<void> restaurerDeCorbeille(String id) {
    return (_db.update(_db.documentsArchive)..where((t) => t.id.equals(id))).write(
      const DocumentsArchiveCompanion(statut: Value('actif'), dateMiseCorbeille: Value(null)),
    );
  }

  /// RG-VIII-05 — purge définitive, uniquement une fois le délai paramétré
  /// écoulé depuis la mise en corbeille ; jamais automatique. Lève
  /// `AppError.documentArchiveNonPurgeable` sinon.
  Future<void> purgerDefinitivement(String id, {required int delaiPurgeJours}) async {
    final document = await (_db.select(_db.documentsArchive)..where((t) => t.id.equals(id))).getSingle();
    final purgeable = document.statut == StatutDocumentArchive.enCorbeille.code &&
        document.dateMiseCorbeille != null &&
        ArchivageRules.estPurgeable(
          dateMiseCorbeille: document.dateMiseCorbeille!,
          delaiPurgeJours: delaiPurgeJours,
          maintenant: DateTime.now(),
        );
    if (!purgeable) {
      throw AppError.documentArchiveNonPurgeable();
    }
    await _db.transaction(() async {
      await (_db.delete(_db.versionsDocument)..where((t) => t.documentId.equals(id))).go();
      await (_db.delete(_db.documentsArchive)..where((t) => t.id.equals(id))).go();
    });
  }

  // --- Mapping ---------------------------------------------------------------

  DocumentArchive _documentToDomain(DocumentArchiveRow row) {
    return DocumentArchive(
      id: row.id,
      numeroArchive: row.numeroArchive,
      typeDocument: row.typeDocument,
      moduleOrigine: row.moduleOrigine,
      objetIdOrigine: row.objetIdOrigine,
      noeudId: row.noeudId,
      niveauConfidentialite: NiveauConfidentialite.fromCode(row.niveauConfidentialite),
      statut: StatutDocumentArchive.fromCode(row.statut),
      fichier: row.fichier,
      dateArchivage: row.dateArchivage,
      dateMiseCorbeille: row.dateMiseCorbeille,
    );
  }

  VersionDocument _versionToDomain(VersionDocumentRow row) {
    return VersionDocument(
      id: row.id,
      documentId: row.documentId,
      numeroVersion: row.numeroVersion,
      fichier: row.fichier,
      date: row.date,
    );
  }

  NomenclatureArchivage _nomenclatureToDomain(NomenclatureArchivageRow row) {
    return NomenclatureArchivage(id: row.id, typeDocument: row.typeDocument, modeleNumerotation: row.modeleNumerotation);
  }
}
