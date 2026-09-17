import 'dart:async';

import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/sync/sync_coordinator.dart';
import '../../../core/utils/id_generator.dart';
import '../domain/models/categorie_confessionnelle.dart';
import '../domain/models/organisation_node.dart';
import '../domain/models/statut_noeud.dart';
import '../domain/models/type_noeud.dart';
import '../domain/rules/organisation_node_rules.dart';
import 'local/app_database.dart';
import 'remote/organisation_remote_data_source.dart';

const String _entiteOutbox = 'organisation_nodes';

/// Dépôt Module I : écriture Drift d'abord, file de synchronisation ensuite,
/// jamais bloquante (RG-OFF-01/02). La synchronisation Supabase est
/// optionnelle (`remote` nullable) pour rester testable hors ligne.
class OrganisationNodeRepository {
  OrganisationNodeRepository(
    this._db,
    this._syncCoordinator, {
    OrganisationRemoteDataSource? remote,
  })
      // Le paramètre nommé public `remote` ne peut pas partager le nom du
      // champ privé `_remote` (named initializing formals interdits ici).
      // ignore: prefer_initializing_formals
      : _remote = remote {
    // Sans source distante configurée, aucun handler n'est enregistré : les
    // entrées restent en file (jamais purgées sans confirmation serveur,
    // chapitre 7.2 du Cahier) plutôt que d'être faussement marquées traitées.
    if (remote != null) {
      _syncCoordinator.registerHandler(_entiteOutbox, _handleOutboxEntry);
    }
  }

  final AppDatabase _db;
  final SyncCoordinator _syncCoordinator;
  final OrganisationRemoteDataSource? _remote;

  Future<void> _handleOutboxEntry(SyncOutboxRow entry) async {
    final remote = _remote!;
    if (entry.operation == 'delete') {
      await remote.deleteNode(entry.entiteId);
      return;
    }
    final row = await (_db.select(_db.organisationNodes)..where((t) => t.id.equals(entry.entiteId)))
        .getSingleOrNull();
    if (row != null) {
      await remote.upsertNode(row);
    }
  }

  Stream<List<OrganisationNode>> watchAll() {
    return _db.select(_db.organisationNodes).watch().map(
          (rows) => rows.map(_toDomain).toList(growable: false),
        );
  }

  Stream<List<OrganisationNode>> watchEnfants(String noeudParentId) {
    final query = _db.select(_db.organisationNodes)
      ..where((t) => t.noeudParentId.equals(noeudParentId));
    return query.watch().map((rows) => rows.map(_toDomain).toList(growable: false));
  }

  Future<OrganisationNode?> findById(String id) async {
    final row =
        await (_db.select(_db.organisationNodes)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<bool> _racineExisteDeja() async {
    final racine = await (_db.select(_db.organisationNodes)
          ..where((t) => t.typeNoeud.equals(TypeNoeud.siege.code))
          ..limit(1))
        .getSingleOrNull();
    return racine != null;
  }

  Future<bool> _codeInterneDejaUtilise(String codeInterne, {String? excluId}) async {
    final query = _db.select(_db.organisationNodes)..where((t) => t.codeInterne.equals(codeInterne));
    final existants = await query.get();
    return existants.any((row) => row.id != excluId);
  }

  /// Crée un nœud (RG-I-01, RG-I-09). Lève [AppError] si les invariants
  /// métier ne sont pas respectés.
  Future<OrganisationNode> creerNoeud({
    required TypeNoeud typeNoeud,
    required String? noeudParentId,
    required String nom,
    required String codeInterne,
    String? logoUrl,
    String? cachetUrl,
    DateTime? dateFondation,
    CategorieConfessionnelle? categorieConfessionnelle,
    String? zoneGeoId,
  }) async {
    final racineExisteDeja = await _racineExisteDeja();
    OrganisationNodeRules.validerCoherenceType(
      type: typeNoeud,
      noeudParentId: noeudParentId,
      racineExisteDeja: racineExisteDeja,
    );
    OrganisationNodeRules.validerCategorieConfessionnelle(
      type: typeNoeud,
      categorie: categorieConfessionnelle,
    );

    if (await _codeInterneDejaUtilise(codeInterne)) {
      throw AppError.codeInterneAlreadyUsed();
    }

    String parentPath = '';
    if (noeudParentId != null) {
      final parent = await findById(noeudParentId);
      if (parent == null) {
        throw AppError.parentNotFound();
      }
      parentPath = parent.path;
    }

    final id = IdGenerator.newId();
    final path = OrganisationNodeRules.construirePath(parentPath: parentPath, nodeId: id);
    final depth = OrganisationNodeRules.calculerProfondeur(path);
    final maintenant = DateTime.now();

    await _db.into(_db.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: id,
            typeNoeud: typeNoeud.code,
            noeudParentId: Value(noeudParentId),
            nom: nom,
            codeInterne: codeInterne,
            statut: Value(StatutNoeud.provisoire.code),
            logoUrl: Value(logoUrl),
            cachetUrl: Value(cachetUrl),
            dateFondation: Value(dateFondation),
            categorieConfessionnelle: Value(categorieConfessionnelle?.code),
            zoneGeoId: Value(zoneGeoId),
            path: path,
            depth: depth,
            createdAt: maintenant,
            updatedAt: maintenant,
          ),
        );

    await _enqueueEtSynchroniser(id, 'upsert');

    return (await findById(id))!;
  }

  /// RG-I-08 — valide un nœud provisoire et le fait passer au statut actif.
  Future<void> validerNoeud(String id) async {
    await (_db.update(_db.organisationNodes)..where((t) => t.id.equals(id))).write(
      OrganisationNodesCompanion(
        statut: Value(StatutNoeud.actif.code),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _enqueueEtSynchroniser(id, 'upsert');
  }

  /// RG-I-06 — change le rattachement d'un nœud, recompute son chemin et sa
  /// profondeur ainsi que ceux de tous ses descendants, et trace
  /// l'événement dans l'historique des rattachements.
  Future<void> changerRattachement({
    required String noeudId,
    required String nouveauParentId,
    String? motif,
  }) async {
    final noeud = await findById(noeudId);
    if (noeud == null) {
      throw ArgumentError('Nœud introuvable : $noeudId');
    }
    final nouveauParent = await findById(nouveauParentId);
    if (nouveauParent == null) {
      throw AppError.parentNotFound();
    }

    OrganisationNodeRules.validerNouveauRattachement(
      nodeId: noeudId,
      nouveauParentId: nouveauParentId,
      nouveauParentPath: nouveauParent.path,
    );

    final ancienParentId = noeud.noeudParentId;
    final ancienPath = noeud.path;
    final nouveauPath = OrganisationNodeRules.construirePath(
      parentPath: nouveauParent.path,
      nodeId: noeudId,
    );
    final maintenant = DateTime.now();

    await _db.transaction(() async {
      // Recomputation en cascade : tout descendant voit son chemin réécrit
      // avec le nouveau préfixe, sa profondeur ajustée du même delta.
      final descendants = await (_db.select(_db.organisationNodes)
            ..where((t) => t.path.like('$ancienPath%')))
          .get();

      for (final descendant in descendants) {
        final estLeNoeudLuiMeme = descendant.id == noeudId;
        final suffixe = estLeNoeudLuiMeme ? '' : descendant.path.substring(ancienPath.length);
        final nouveauPathDescendant = estLeNoeudLuiMeme ? nouveauPath : '$nouveauPath$suffixe';
        final nouvelleProfondeurDescendant = OrganisationNodeRules.calculerProfondeur(
          nouveauPathDescendant,
        );
        await (_db.update(_db.organisationNodes)..where((t) => t.id.equals(descendant.id))).write(
          OrganisationNodesCompanion(
            path: Value(nouveauPathDescendant),
            depth: Value(nouvelleProfondeurDescendant),
            updatedAt: Value(maintenant),
            noeudParentId: estLeNoeudLuiMeme
                ? Value(nouveauParentId)
                : Value(descendant.noeudParentId),
          ),
        );
        await _enqueueEtSynchroniser(descendant.id, 'upsert', flush: false);
      }

      await _db.into(_db.historiqueRattachements).insert(
            HistoriqueRattachementsCompanion.insert(
              id: IdGenerator.newId(),
              noeudId: noeudId,
              ancienParentId: Value(ancienParentId),
              nouveauParentId: nouveauParentId,
              dateEffet: maintenant,
              motif: Value(motif),
            ),
          );
    });

    unawaited(_syncCoordinator.flush());
  }

  /// RG-I-02 — refuse la suppression tant que des rattachements existent.
  Future<void> supprimerNoeud(String id) async {
    final aDesEnfants = await (_db.select(_db.organisationNodes)
          ..where((t) => t.noeudParentId.equals(id))
          ..limit(1))
        .getSingleOrNull();

    final erreur = OrganisationNodeRules.raisonBlocageSuppression(
      aDesEnfants: aDesEnfants != null,
      // Les rattachements des autres modules (fidèles, biens, comptes,
      // cultes...) seront agrégés ici au fur et à mesure de leur
      // reconstruction — aucun de ces modules n'existe encore.
      aAutresRattachements: false,
    );
    if (erreur != null) {
      throw erreur;
    }

    await (_db.delete(_db.organisationNodes)..where((t) => t.id.equals(id))).go();
    await _enqueueEtSynchroniser(id, 'delete');
  }

  /// RG-I-02 — alternative non destructive à la suppression.
  Future<void> archiverNoeud(String id) async {
    await (_db.update(_db.organisationNodes)..where((t) => t.id.equals(id))).write(
      OrganisationNodesCompanion(
        statut: Value(StatutNoeud.archive.code),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _enqueueEtSynchroniser(id, 'upsert');
  }

  Future<void> _enqueueEtSynchroniser(String entiteId, String operation, {bool flush = true}) async {
    await _syncCoordinator.enqueue(
      id: IdGenerator.newId(),
      entite: _entiteOutbox,
      entiteId: entiteId,
      operation: operation,
    );
    if (flush) {
      unawaited(_syncCoordinator.flush());
    }
  }

  OrganisationNode _toDomain(OrganisationNodeRow row) {
    return OrganisationNode(
      id: row.id,
      typeNoeud: TypeNoeud.fromCode(row.typeNoeud),
      noeudParentId: row.noeudParentId,
      nom: row.nom,
      codeInterne: row.codeInterne,
      statut: StatutNoeud.fromCode(row.statut),
      logoUrl: row.logoUrl,
      cachetUrl: row.cachetUrl,
      dateFondation: row.dateFondation,
      categorieConfessionnelle: row.categorieConfessionnelle == null
          ? null
          : CategorieConfessionnelle.fromCode(row.categorieConfessionnelle!),
      zoneGeoId: row.zoneGeoId,
      path: row.path,
      depth: row.depth,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
