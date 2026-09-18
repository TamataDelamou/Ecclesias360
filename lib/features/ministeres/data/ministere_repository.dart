import 'package:drift/drift.dart';

import '../../../core/sync/sync_coordinator.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/statut_referentiel.dart';
import '../domain/models/activite_ministere.dart';
import '../domain/models/affectation_ministere.dart';
import '../domain/models/mandat_responsable.dart';
import '../domain/models/ministere.dart';
import '../domain/models/role_affectation.dart';
import '../domain/models/statut_affectation.dart';
import '../domain/models/statut_ministere.dart';
import '../domain/models/type_ministere.dart';
import '../domain/rules/ministere_rules.dart';
import 'remote/ministere_remote_data_source.dart';

const String _entiteOutbox = 'ministeres';

/// Dépôt Module III — écriture Drift d'abord, file de synchronisation
/// ensuite pour `ministeres` (RG-OFF-01/02). Les entités liées
/// (affectations, mandats, activités, types) restent locales pour cette
/// première itération — voir `MinistereRemoteDataSource`.
class MinistereRepository {
  MinistereRepository(
    this._db,
    this._syncCoordinator, {
    MinistereRemoteDataSource? remote,
  })
      // ignore: prefer_initializing_formals
      : _remote = remote {
    if (remote != null) {
      _syncCoordinator.registerHandler(_entiteOutbox, _handleOutboxEntry);
    }
  }

  final AppDatabase _db;
  final SyncCoordinator _syncCoordinator;
  final MinistereRemoteDataSource? _remote;

  Future<void> _handleOutboxEntry(SyncOutboxRow entry) async {
    final remote = _remote!;
    if (entry.operation == 'delete') {
      await remote.deleteMinistere(entry.entiteId);
      return;
    }
    final row =
        await (_db.select(_db.ministeres)..where((t) => t.id.equals(entry.entiteId))).getSingleOrNull();
    if (row != null) {
      await remote.upsertMinistere(row);
    }
  }

  // --- Types de ministères (RG-III-04) ---------------------------------

  Stream<List<TypeMinistere>> watchTypes() {
    return _db.select(_db.typesMinisteres).watch().map(
          (rows) => rows.map(_typeToDomain).toList(growable: false),
        );
  }

  Future<TypeMinistere> creerTypePersonnalise({required String libelle, required String code}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.typesMinisteres).insert(
          TypesMinisteresCompanion.insert(
            id: id,
            code: code,
            libelle: libelle,
            standard: const Value(false),
          ),
        );
    final row = await (_db.select(_db.typesMinisteres)..where((t) => t.id.equals(id))).getSingle();
    return _typeToDomain(row);
  }

  /// RG-III-04 — refuse la désactivation d'un type standard.
  Future<void> desactiverType(String id) async {
    final type = await (_db.select(_db.typesMinisteres)..where((t) => t.id.equals(id))).getSingle();
    final erreur = MinistereRules.raisonBlocageDesactivationType(standard: type.standard);
    if (erreur != null) {
      throw erreur;
    }
    await (_db.update(_db.typesMinisteres)..where((t) => t.id.equals(id))).write(
      TypesMinisteresCompanion(statut: Value(StatutReferentiel.desactive.code)),
    );
  }

  // --- Ministères (RG-III-01/04/05) -------------------------------------

  Stream<List<Ministere>> watchMinisteres({String? noeudId}) {
    final query = _db.select(_db.ministeres);
    if (noeudId != null) {
      query.where((t) => t.noeudId.equals(noeudId));
    }
    return query.watch().map((rows) => rows.map(_ministereToDomain).toList(growable: false));
  }

  Future<Ministere?> findMinistereById(String id) async {
    final row = await (_db.select(_db.ministeres)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _ministereToDomain(row);
  }

  Future<Ministere> creerMinistere({
    required String noeudId,
    required String typeMinistereId,
    required String nom,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.ministeres).insert(
          MinisteresCompanion.insert(
            id: id,
            noeudId: noeudId,
            typeMinistereId: typeMinistereId,
            nom: nom,
            dateCreation: DateTime.now(),
            statut: Value(StatutMinistere.actif.code),
          ),
        );
    await _enqueueEtSynchroniser(id, 'upsert');
    return (await findMinistereById(id))!;
  }

  /// Alternative non destructive à la suppression, cohérente avec les
  /// autres modules du dépôt.
  Future<void> archiverMinistere(String id) async {
    await (_db.update(_db.ministeres)..where((t) => t.id.equals(id))).write(
      MinisteresCompanion(statut: Value(StatutMinistere.archive.code)),
    );
    await _enqueueEtSynchroniser(id, 'upsert');
  }

  // --- Affectations (RG-III-01/03) --------------------------------------

  Stream<List<AffectationMinistere>> watchAffectations(String ministereId) {
    final query = _db.select(_db.affectationsMinisteres)..where((t) => t.ministereId.equals(ministereId));
    return query.watch().map((rows) => rows.map(_affectationToDomain).toList(growable: false));
  }

  /// RG-III-01 — affecte un fidèle à un ministère ; si [role] est
  /// `responsable`, ouvre également un `MandatResponsable` (RG-III-02) et
  /// refuse s'il en existe déjà un actif.
  Future<AffectationMinistere> affecter({
    required String ministereId,
    required String fideleId,
    required RoleAffectation role,
    DateTime? dateFinPrevue,
  }) async {
    if (role == RoleAffectation.responsable) {
      final responsableActif = await (_db.select(_db.affectationsMinisteres)
            ..where(
              (t) =>
                  t.ministereId.equals(ministereId) &
                  t.role.equals(RoleAffectation.responsable.code) &
                  t.statut.equals(StatutAffectation.active.code),
            )
            ..limit(1))
          .getSingleOrNull();
      final erreur = MinistereRules.raisonBlocageResponsableSupplementaire(
        existeDejaResponsableActif: responsableActif != null,
      );
      if (erreur != null) {
        throw erreur;
      }
    }

    final id = IdGenerator.newId();
    final maintenant = DateTime.now();
    await _db.into(_db.affectationsMinisteres).insert(
          AffectationsMinisteresCompanion.insert(
            id: id,
            ministereId: ministereId,
            fideleId: fideleId,
            role: role.code,
            dateDebut: maintenant,
            statut: Value(StatutAffectation.active.code),
          ),
        );

    if (role == RoleAffectation.responsable) {
      await _db.into(_db.mandatsResponsables).insert(
            MandatsResponsablesCompanion.insert(
              id: IdGenerator.newId(),
              ministereId: ministereId,
              fideleId: fideleId,
              dateDebut: maintenant,
              dateFinPrevue: Value(dateFinPrevue),
            ),
          );
    }

    final row = await (_db.select(_db.affectationsMinisteres)..where((t) => t.id.equals(id))).getSingle();
    return _affectationToDomain(row);
  }

  /// Clôture l'affectation et, le cas échéant, le mandat de responsable
  /// ouvert correspondant (RG-III-02, alimente l'historique écran 6).
  Future<void> retirerAffectation(String id) async {
    final affectation =
        await (_db.select(_db.affectationsMinisteres)..where((t) => t.id.equals(id))).getSingle();
    final maintenant = DateTime.now();

    await (_db.update(_db.affectationsMinisteres)..where((t) => t.id.equals(id))).write(
      AffectationsMinisteresCompanion(
        dateFin: Value(maintenant),
        statut: Value(StatutAffectation.terminee.code),
      ),
    );

    if (affectation.role == RoleAffectation.responsable.code) {
      final mandatOuvert = await (_db.select(_db.mandatsResponsables)
            ..where(
              (t) =>
                  t.ministereId.equals(affectation.ministereId) &
                  t.fideleId.equals(affectation.fideleId) &
                  t.dateFinReelle.isNull(),
            )
            ..limit(1))
          .getSingleOrNull();
      if (mandatOuvert != null) {
        await (_db.update(_db.mandatsResponsables)..where((t) => t.id.equals(mandatOuvert.id))).write(
          MandatsResponsablesCompanion(dateFinReelle: Value(maintenant)),
        );
      }
    }
  }

  /// RG-III-03 — point d'intégration pour le Module X (discipline, pas
  /// encore construit) : suspend toutes les affectations actives d'un
  /// fidèle. Volontairement non appelée depuis l'UI actuelle.
  Future<void> suspendreAffectationsActives(String fideleId) async {
    await (_db.update(_db.affectationsMinisteres)
          ..where((t) => t.fideleId.equals(fideleId) & t.statut.equals(StatutAffectation.active.code)))
        .write(AffectationsMinisteresCompanion(statut: Value(StatutAffectation.suspendue.code)));
  }

  /// RG-III-03 — réintégration manuelle après clôture d'une procédure
  /// disciplinaire (Module X, pas encore construit).
  Future<void> reintegrerAffectations(String fideleId) async {
    await (_db.update(_db.affectationsMinisteres)
          ..where((t) => t.fideleId.equals(fideleId) & t.statut.equals(StatutAffectation.suspendue.code)))
        .write(AffectationsMinisteresCompanion(statut: Value(StatutAffectation.active.code)));
  }

  // --- Mandats de responsable (RG-III-02/05) -----------------------------

  Stream<List<MandatResponsable>> watchMandats(String ministereId) {
    final query = _db.select(_db.mandatsResponsables)
      ..where((t) => t.ministereId.equals(ministereId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateDebut)]);
    return query.watch().map((rows) => rows.map(_mandatToDomain).toList(growable: false));
  }

  /// RG-III-02 — tous les mandats ouverts, tous ministères confondus (écran
  /// 9, « suivi des mandats arrivant à échéance »).
  Future<List<MandatResponsable>> mandatsOuverts() async {
    final rows = await (_db.select(_db.mandatsResponsables)..where((t) => t.dateFinReelle.isNull())).get();
    return rows.map(_mandatToDomain).toList(growable: false);
  }

  // --- Journal d'activités (RG-III-05) ------------------------------------

  Stream<List<ActiviteMinistere>> watchActivites(String ministereId) {
    final query = _db.select(_db.activitesMinisteres)
      ..where((t) => t.ministereId.equals(ministereId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_activiteToDomain).toList(growable: false));
  }

  Future<void> ajouterActivite({
    required String ministereId,
    required TypeActiviteMinistere type,
    required String description,
    String? auteurFideleId,
  }) {
    return _db.into(_db.activitesMinisteres).insert(
          ActivitesMinisteresCompanion.insert(
            id: IdGenerator.newId(),
            ministereId: ministereId,
            type: type.code,
            description: description,
            date: DateTime.now(),
            auteurFideleId: Value(auteurFideleId),
          ),
        );
  }

  Future<void> _enqueueEtSynchroniser(String entiteId, String operation) async {
    await _syncCoordinator.enqueue(
      id: IdGenerator.newId(),
      entite: _entiteOutbox,
      entiteId: entiteId,
      operation: operation,
    );
    // ignore: discarded_futures
    _syncCoordinator.flush();
  }

  TypeMinistere _typeToDomain(TypeMinistereRow row) {
    return TypeMinistere(
      id: row.id,
      code: row.code,
      libelle: row.libelle,
      standard: row.standard,
      statut: StatutReferentiel.fromCode(row.statut),
    );
  }

  Ministere _ministereToDomain(MinistereRow row) {
    return Ministere(
      id: row.id,
      noeudId: row.noeudId,
      typeMinistereId: row.typeMinistereId,
      nom: row.nom,
      dateCreation: row.dateCreation,
      statut: StatutMinistere.fromCode(row.statut),
    );
  }

  AffectationMinistere _affectationToDomain(AffectationMinistereRow row) {
    return AffectationMinistere(
      id: row.id,
      ministereId: row.ministereId,
      fideleId: row.fideleId,
      role: RoleAffectation.fromCode(row.role),
      dateDebut: row.dateDebut,
      dateFin: row.dateFin,
      statut: StatutAffectation.fromCode(row.statut),
    );
  }

  MandatResponsable _mandatToDomain(MandatResponsableRow row) {
    return MandatResponsable(
      id: row.id,
      ministereId: row.ministereId,
      fideleId: row.fideleId,
      dateDebut: row.dateDebut,
      dateFinPrevue: row.dateFinPrevue,
      dateFinReelle: row.dateFinReelle,
    );
  }

  ActiviteMinistere _activiteToDomain(ActiviteMinistereRow row) {
    return ActiviteMinistere(
      id: row.id,
      ministereId: row.ministereId,
      type: TypeActiviteMinistere.fromCode(row.type),
      description: row.description,
      date: row.date,
      auteurFideleId: row.auteurFideleId,
    );
  }
}
