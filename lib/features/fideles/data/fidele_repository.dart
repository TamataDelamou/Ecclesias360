import 'dart:async';

import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/sync/sync_coordinator.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/fidele.dart';
import '../domain/models/historique_fidele.dart';
import '../domain/models/lien_familial.dart';
import '../domain/models/sexe.dart';
import '../domain/models/statut_civil.dart';
import '../domain/models/statut_fidele.dart';
import '../domain/models/statut_spirituel.dart';
import '../domain/models/tuteur.dart';
import '../domain/models/type_lien.dart';
import '../domain/rules/fidele_rules.dart';
import 'remote/fidele_remote_data_source.dart';

const String _entiteOutbox = 'fideles';

/// Dépôt Module II : écriture Drift d'abord, file de synchronisation
/// ensuite, jamais bloquante (RG-OFF-01/02).
class FideleRepository {
  FideleRepository(
    this._db,
    this._syncCoordinator, {
    FideleRemoteDataSource? remote,
  })
      // ignore: prefer_initializing_formals
      : _remote = remote {
    if (remote != null) {
      _syncCoordinator.registerHandler(_entiteOutbox, _handleOutboxEntry);
    }
  }

  final AppDatabase _db;
  final SyncCoordinator _syncCoordinator;
  final FideleRemoteDataSource? _remote;

  Future<void> _handleOutboxEntry(SyncOutboxRow entry) async {
    final remote = _remote!;
    if (entry.operation == 'delete') {
      await remote.deleteFidele(entry.entiteId);
      return;
    }
    final row =
        await (_db.select(_db.fideles)..where((t) => t.id.equals(entry.entiteId))).getSingleOrNull();
    if (row != null) {
      await remote.upsertFidele(row);
    }
  }

  Stream<List<Fidele>> watchAll() {
    return _db.select(_db.fideles).watch().map((rows) => rows.map(_toDomain).toList(growable: false));
  }

  Future<Fidele?> findById(String id) async {
    final row = await (_db.select(_db.fideles)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Stream<List<Tuteur>> watchTuteurs(String mineurId) {
    final query = _db.select(_db.tuteurs)..where((t) => t.mineurId.equals(mineurId));
    return query.watch().map((rows) => rows.map(_tuteurToDomain).toList(growable: false));
  }

  Stream<List<LienFamilial>> watchLiensFamiliaux(String fideleId) {
    final query = _db.select(_db.liensFamiliaux)
      ..where((t) => t.fideleId1.equals(fideleId) | t.fideleId2.equals(fideleId));
    return query.watch().map((rows) => rows.map(_lienToDomain).toList(growable: false));
  }

  Stream<List<HistoriqueFidele>> watchHistorique(String fideleId) {
    final query = _db.select(_db.historiqueFideles)
      ..where((t) => t.fideleId.equals(fideleId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_historiqueToDomain).toList(growable: false));
  }

  /// RG-II-01 — `id` sert de matricule, généré une fois pour toutes.
  Future<Fidele> creerFidele({
    required String noeudId,
    required String nom,
    required String prenoms,
    required DateTime dateNaissance,
    required Sexe sexe,
    required StatutCivil statutCivil,
    String? egliseProvenance,
    String? photoUrl,
    String? telephone,
    String? email,
    String? adresse,
  }) async {
    final id = IdGenerator.newId();
    final maintenant = DateTime.now();

    await _db.into(_db.fideles).insert(
          FidelesCompanion.insert(
            id: id,
            noeudId: noeudId,
            nom: nom,
            prenoms: prenoms,
            dateNaissance: dateNaissance,
            sexe: sexe.code,
            statutCivil: statutCivil.code,
            statutSpirituel: Value(StatutSpirituel.visiteur.code),
            statut: Value(StatutFidele.actif.code),
            egliseProvenance: Value(egliseProvenance),
            photoUrl: Value(photoUrl),
            telephone: Value(telephone),
            email: Value(email),
            adresse: Value(adresse),
            createdAt: maintenant,
            updatedAt: maintenant,
          ),
        );

    await _enqueueEtSynchroniser(id, 'upsert');
    return (await findById(id))!;
  }

  /// RG-II-02/03/05/06 — transition de statut spirituel, historisée. Le
  /// passage à `baptise` exige un tuteur enregistré si le fidèle est
  /// mineur (RG-II-06) ; `membreEnDiscipline` n'est atteignable que
  /// depuis le Module X (RG-II-03, [viaModuleDiscipline]).
  Future<void> modifierStatutSpirituel({
    required String fideleId,
    required StatutSpirituel cible,
    bool sautHistorique = false,
    bool viaModuleDiscipline = false,
    String? auteurFideleId,
  }) async {
    final fidele = await findById(fideleId);
    if (fidele == null) {
      throw ArgumentError('Fidèle introuvable : $fideleId');
    }

    FideleRules.validerTransitionStatutSpirituel(
      actuel: fidele.statutSpirituel,
      cible: cible,
      sautHistorique: sautHistorique,
      viaModuleDiscipline: viaModuleDiscipline,
    );

    if (cible == StatutSpirituel.baptise &&
        !sautHistorique &&
        FideleRules.estMineur(fidele.dateNaissance)) {
      final tuteurs = await (_db.select(_db.tuteurs)..where((t) => t.mineurId.equals(fideleId))).get();
      if (tuteurs.isEmpty) {
        throw AppError.mineurSansTuteur();
      }
    }

    await (_db.update(_db.fideles)..where((t) => t.id.equals(fideleId))).write(
      FidelesCompanion(
        statutSpirituel: Value(cible.code),
        dateBapteme: cible == StatutSpirituel.baptise ? Value(DateTime.now()) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await _historiser(
      fideleId: fideleId,
      champModifie: 'statut_spirituel',
      ancienneValeur: fidele.statutSpirituel.code,
      nouvelleValeur: cible.code,
      auteurFideleId: auteurFideleId,
    );
    await _enqueueEtSynchroniser(fideleId, 'upsert');
  }

  /// RG-II-05 — modification de coordonnées/photo, historisée champ par
  /// champ.
  Future<void> modifierCoordonnees({
    required String fideleId,
    String? telephone,
    String? email,
    String? adresse,
    String? photoUrl,
    String? auteurFideleId,
  }) async {
    final fidele = await findById(fideleId);
    if (fidele == null) {
      throw ArgumentError('Fidèle introuvable : $fideleId');
    }

    await (_db.update(_db.fideles)..where((t) => t.id.equals(fideleId))).write(
      FidelesCompanion(
        telephone: telephone == null ? const Value.absent() : Value(telephone),
        email: email == null ? const Value.absent() : Value(email),
        adresse: adresse == null ? const Value.absent() : Value(adresse),
        photoUrl: photoUrl == null ? const Value.absent() : Value(photoUrl),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final changements = <String, (String?, String?)>{
      if (telephone != null) 'telephone': (fidele.telephone, telephone),
      if (email != null) 'email': (fidele.email, email),
      if (adresse != null) 'adresse': (fidele.adresse, adresse),
      if (photoUrl != null) 'photo': (fidele.photoUrl, photoUrl),
    };
    for (final entry in changements.entries) {
      await _historiser(
        fideleId: fideleId,
        champModifie: entry.key,
        ancienneValeur: entry.value.$1,
        nouvelleValeur: entry.value.$2,
        auteurFideleId: auteurFideleId,
      );
    }
    await _enqueueEtSynchroniser(fideleId, 'upsert');
  }

  /// RG-IX-01/03 — change le nœud de rattachement d'un fidèle (mutation
  /// validée, Module IX) et historise le changement (RG-IX-03 : l'historique
  /// des rattachements successifs reste consultable depuis la fiche).
  Future<void> changerNoeud({
    required String fideleId,
    required String nouveauNoeudId,
    String? auteurFideleId,
  }) async {
    final fidele = await findById(fideleId);
    if (fidele == null) {
      throw ArgumentError('Fidèle introuvable : $fideleId');
    }

    await (_db.update(_db.fideles)..where((t) => t.id.equals(fideleId))).write(
      FidelesCompanion(
        noeudId: Value(nouveauNoeudId),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await _historiser(
      fideleId: fideleId,
      champModifie: 'noeud_id',
      ancienneValeur: fidele.noeudId,
      nouvelleValeur: nouveauNoeudId,
      auteurFideleId: auteurFideleId,
    );
    await _enqueueEtSynchroniser(fideleId, 'upsert');
  }

  /// RG-II-06 — ajoute un tuteur légal (fidèle enregistré ou tiers).
  Future<void> ajouterTuteur({
    required String mineurId,
    required String lien,
    String? tuteurFideleId,
    String? tuteurTiersNom,
    String? tuteurTiersTelephone,
  }) async {
    FideleRules.validerTuteur(tuteurFideleId: tuteurFideleId, tuteurTiersNom: tuteurTiersNom);

    await _db.into(_db.tuteurs).insert(
          TuteursCompanion.insert(
            id: IdGenerator.newId(),
            mineurId: mineurId,
            lien: lien,
            tuteurFideleId: Value(tuteurFideleId),
            tuteurTiersNom: Value(tuteurTiersNom),
            tuteurTiersTelephone: Value(tuteurTiersTelephone),
          ),
        );
  }

  Future<void> retirerTuteur(String id) async {
    await (_db.delete(_db.tuteurs)..where((t) => t.id.equals(id))).go();
  }

  /// RG-II-04 — la suppression d'un lien familial n'entraîne jamais la
  /// suppression des fidèles liés (aucune cascade vers `fideles`).
  Future<void> ajouterLienFamilial({
    required String fideleId1,
    required String fideleId2,
    required TypeLien typeLien,
  }) async {
    await _db.into(_db.liensFamiliaux).insert(
          LiensFamiliauxCompanion.insert(
            id: IdGenerator.newId(),
            fideleId1: fideleId1,
            fideleId2: fideleId2,
            typeLien: typeLien.code,
          ),
        );
  }

  Future<void> retirerLienFamilial(String id) async {
    await (_db.delete(_db.liensFamiliaux)..where((t) => t.id.equals(id))).go();
  }

  /// RG-II-08 — refuse la suppression tant que des rattachements existent
  /// (liens familiaux, tuteur, et — une fois ces modules construits —
  /// mouvements financiers, disciplinaires ou documentaires).
  Future<void> supprimerFidele(String id) async {
    final liens = await (_db.select(_db.liensFamiliaux)
          ..where((t) => t.fideleId1.equals(id) | t.fideleId2.equals(id))
          ..limit(1))
        .getSingleOrNull();
    final tuteurs = await (_db.select(_db.tuteurs)
          ..where((t) => t.mineurId.equals(id) | t.tuteurFideleId.equals(id))
          ..limit(1))
        .getSingleOrNull();

    final erreur = FideleRules.raisonBlocageSuppression(
      aDesRattachements: liens != null || tuteurs != null,
    );
    if (erreur != null) {
      throw erreur;
    }

    await (_db.delete(_db.fideles)..where((t) => t.id.equals(id))).go();
    await _enqueueEtSynchroniser(id, 'delete');
  }

  /// RG-II-08 — alternative non destructive à la suppression.
  Future<void> archiverFidele(String id) async {
    await (_db.update(_db.fideles)..where((t) => t.id.equals(id))).write(
      FidelesCompanion(
        statut: Value(StatutFidele.inactif.code),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _enqueueEtSynchroniser(id, 'upsert');
  }

  Future<void> _historiser({
    required String fideleId,
    required String champModifie,
    required String? ancienneValeur,
    required String? nouvelleValeur,
    required String? auteurFideleId,
  }) {
    return _db.into(_db.historiqueFideles).insert(
          HistoriqueFidelesCompanion.insert(
            id: IdGenerator.newId(),
            fideleId: fideleId,
            champModifie: champModifie,
            ancienneValeur: Value(ancienneValeur),
            nouvelleValeur: Value(nouvelleValeur),
            auteurFideleId: Value(auteurFideleId),
            date: DateTime.now(),
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
    unawaited(_syncCoordinator.flush());
  }

  Fidele _toDomain(FideleRow row) {
    return Fidele(
      id: row.id,
      noeudId: row.noeudId,
      nom: row.nom,
      prenoms: row.prenoms,
      dateNaissance: row.dateNaissance,
      sexe: Sexe.fromCode(row.sexe),
      statutCivil: StatutCivil.fromCode(row.statutCivil),
      statutSpirituel: StatutSpirituel.fromCode(row.statutSpirituel),
      statut: StatutFidele.fromCode(row.statut),
      dateConversion: row.dateConversion,
      dateBapteme: row.dateBapteme,
      egliseProvenance: row.egliseProvenance,
      photoUrl: row.photoUrl,
      telephone: row.telephone,
      email: row.email,
      adresse: row.adresse,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Tuteur _tuteurToDomain(TuteurRow row) {
    return Tuteur(
      id: row.id,
      mineurId: row.mineurId,
      lien: row.lien,
      tuteurFideleId: row.tuteurFideleId,
      tuteurTiersNom: row.tuteurTiersNom,
      tuteurTiersTelephone: row.tuteurTiersTelephone,
    );
  }

  LienFamilial _lienToDomain(LienFamilialRow row) {
    return LienFamilial(
      id: row.id,
      fideleId1: row.fideleId1,
      fideleId2: row.fideleId2,
      typeLien: TypeLien.fromCode(row.typeLien),
    );
  }

  HistoriqueFidele _historiqueToDomain(HistoriqueFideleRow row) {
    return HistoriqueFidele(
      id: row.id,
      fideleId: row.fideleId,
      champModifie: row.champModifie,
      ancienneValeur: row.ancienneValeur,
      nouvelleValeur: row.nouvelleValeur,
      auteurFideleId: row.auteurFideleId,
      date: row.date,
    );
  }
}
