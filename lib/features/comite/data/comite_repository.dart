import 'package:drift/drift.dart';

import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/decision.dart';
import '../domain/models/erratum_pv.dart';
import '../domain/models/membre_comite.dart';
import '../domain/models/proces_verbal.dart';
import '../domain/models/seance_comite.dart';
import '../domain/models/statut_decision.dart';
import '../domain/models/statut_proces_verbal.dart';
import '../domain/models/statut_tache.dart';
import '../domain/models/tache_suivi.dart';
import '../domain/rules/comite_rules.dart';

/// Dépôt Module VII — comité local (RG-VII-01 à 05). Pas de synchronisation
/// distante pour cette première itération, même précédent documenté que
/// ZonesGeographiques/Ministere/DonSpirituel/Profession/GroupeEglise.
class ComiteRepository {
  ComiteRepository(this._db);

  final AppDatabase _db;

  // --- Quorum (RG-VII-05) --------------------------------------------------

  Future<int?> quorumMinimumDuNoeud(String noeudId) async {
    final row =
        await (_db.select(_db.quorumsComite)..where((t) => t.noeudId.equals(noeudId))).getSingleOrNull();
    return row?.quorumMinimum;
  }

  Future<void> definirQuorum({required String noeudId, required int quorumMinimum}) async {
    final existant =
        await (_db.select(_db.quorumsComite)..where((t) => t.noeudId.equals(noeudId))).getSingleOrNull();
    if (existant != null) {
      await (_db.update(_db.quorumsComite)..where((t) => t.id.equals(existant.id)))
          .write(QuorumsComiteCompanion(quorumMinimum: Value(quorumMinimum)));
    } else {
      await _db.into(_db.quorumsComite).insert(
            QuorumsComiteCompanion.insert(id: IdGenerator.newId(), noeudId: noeudId, quorumMinimum: quorumMinimum),
          );
    }
  }

  // --- Membres du comité (RG-VII-01) ---------------------------------------

  Stream<List<MembreComite>> watchMembres(String noeudId) {
    final query = _db.select(_db.membresComite)..where((t) => t.noeudId.equals(noeudId));
    return query.watch().map((rows) => rows.map(_membreToDomain).toList(growable: false));
  }

  Future<MembreComite> nommerMembre({
    required String fideleId,
    required String noeudId,
    required String fonction,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.membresComite).insert(
          MembresComiteCompanion.insert(
            id: id,
            fideleId: fideleId,
            noeudId: noeudId,
            fonction: fonction,
            dateDebut: DateTime.now(),
          ),
        );
    final row = await (_db.select(_db.membresComite)..where((t) => t.id.equals(id))).getSingle();
    return _membreToDomain(row);
  }

  Future<void> clorerMandat(String id) async {
    await (_db.update(_db.membresComite)..where((t) => t.id.equals(id)))
        .write(MembresComiteCompanion(dateFin: Value(DateTime.now())));
  }

  // --- Séances (RG-VII-05) --------------------------------------------------

  Stream<List<SeanceComite>> watchSeances(String noeudId) {
    final query = _db.select(_db.seancesComite)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_seanceToDomain).toList(growable: false));
  }

  Future<SeanceComite?> findSeanceById(String id) async {
    final row = await (_db.select(_db.seancesComite)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _seanceToDomain(row);
  }

  Stream<List<String>> watchPresents(String seanceId) {
    final query = _db.select(_db.presentsSeance)..where((t) => t.seanceId.equals(seanceId));
    return query.watch().map((rows) => rows.map((r) => r.fideleId).toList(growable: false));
  }

  /// RG-VII-05 — le quorum est calculé par le système à partir du nombre de
  /// présents et du quorum configuré pour le nœud, jamais déclaré librement.
  Future<SeanceComite> creerSeance({
    required String noeudId,
    required DateTime date,
    required String ordreDuJour,
    required List<String> presentsFideleIds,
  }) async {
    final quorumMinimum = await quorumMinimumDuNoeud(noeudId);
    final quorumAtteint = ComiteRules.quorumAtteint(
      nombrePresents: presentsFideleIds.length,
      quorumMinimum: quorumMinimum,
    );

    final id = IdGenerator.newId();
    await _db.into(_db.seancesComite).insert(
          SeancesComiteCompanion.insert(
            id: id,
            noeudId: noeudId,
            date: date,
            ordreDuJour: ordreDuJour,
            quorumAtteint: Value(quorumAtteint),
          ),
        );
    await _db.batch((b) {
      b.insertAll(
        _db.presentsSeance,
        [
          for (final fideleId in presentsFideleIds)
            PresentsSeanceCompanion.insert(id: IdGenerator.newId(), seanceId: id, fideleId: fideleId),
        ],
      );
    });

    final row = await (_db.select(_db.seancesComite)..where((t) => t.id.equals(id))).getSingle();
    return _seanceToDomain(row);
  }

  // --- Décisions (RG-VII-04/05) ----------------------------------------------

  Stream<List<Decision>> watchDecisions(String seanceId) {
    final query = _db.select(_db.decisions)..where((t) => t.seanceId.equals(seanceId));
    return query.watch().map((rows) => rows.map(_decisionToDomain).toList(growable: false));
  }

  Future<Decision> ajouterDecision({
    required String seanceId,
    required String libelle,
    String? resultatVote,
    bool porteeDisciplinaire = false,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.decisions).insert(
          DecisionsCompanion.insert(
            id: id,
            seanceId: seanceId,
            libelle: libelle,
            resultatVote: Value(resultatVote),
            porteeDisciplinaire: Value(porteeDisciplinaire),
          ),
        );
    final row = await (_db.select(_db.decisions)..where((t) => t.id.equals(id))).getSingle();
    return _decisionToDomain(row);
  }

  /// RG-VII-05 — refuse le passage à `adopte` si le quorum de la séance
  /// n'est pas explicitement atteint.
  Future<void> changerStatutDecision({required String id, required StatutDecision statut}) async {
    if (statut == StatutDecision.adopte) {
      final decision = await (_db.select(_db.decisions)..where((t) => t.id.equals(id))).getSingle();
      final seance =
          await (_db.select(_db.seancesComite)..where((t) => t.id.equals(decision.seanceId))).getSingle();
      final erreur = ComiteRules.raisonBlocageAdoption(quorumAtteint: seance.quorumAtteint);
      if (erreur != null) {
        throw erreur;
      }
    }
    await (_db.update(_db.decisions)..where((t) => t.id.equals(id)))
        .write(DecisionsCompanion(statut: Value(statut.code)));
  }

  // --- Procès-verbaux (RG-VII-02/03) ------------------------------------------

  Stream<ProcesVerbal?> watchProcesVerbal(String seanceId) {
    final query = _db.select(_db.procesVerbaux)..where((t) => t.seanceId.equals(seanceId));
    return query.watchSingleOrNull().map((row) => row == null ? null : _pvToDomain(row));
  }

  Future<ProcesVerbal> enregistrerBrouillon({required String seanceId, required String contenu}) async {
    final existant =
        await (_db.select(_db.procesVerbaux)..where((t) => t.seanceId.equals(seanceId))).getSingleOrNull();

    if (existant != null) {
      final erreur = ComiteRules.raisonBlocageModificationProcesVerbal(
        statut: StatutProcesVerbal.fromCode(existant.statut),
      );
      if (erreur != null) {
        throw erreur;
      }
      await (_db.update(_db.procesVerbaux)..where((t) => t.id.equals(existant.id)))
          .write(ProcesVerbauxCompanion(contenu: Value(contenu)));
      final row = await (_db.select(_db.procesVerbaux)..where((t) => t.id.equals(existant.id))).getSingle();
      return _pvToDomain(row);
    }

    final id = IdGenerator.newId();
    await _db.into(_db.procesVerbaux).insert(
          ProcesVerbauxCompanion.insert(id: id, seanceId: seanceId, contenu: contenu),
        );
    final row = await (_db.select(_db.procesVerbaux)..where((t) => t.id.equals(id))).getSingle();
    return _pvToDomain(row);
  }

  /// RG-VII-02 — après validation, le contenu devient immuable (voir
  /// `ajouterErratum`). RG-VII-03 — l'archivage automatique (Module VIII)
  /// et la numérotation restent différés, non construits.
  Future<void> validerProcesVerbal(String id) async {
    await (_db.update(_db.procesVerbaux)..where((t) => t.id.equals(id)))
        .write(ProcesVerbauxCompanion(statut: Value(StatutProcesVerbal.valide.code)));
  }

  Stream<List<ErratumPv>> watchErratums(String procesVerbalId) {
    final query = _db.select(_db.erratumsPv)
      ..where((t) => t.procesVerbalId.equals(procesVerbalId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateAjout)]);
    return query.watch().map((rows) => rows.map(_erratumToDomain).toList(growable: false));
  }

  Future<void> ajouterErratum({
    required String procesVerbalId,
    required String texte,
    String? auteurFideleId,
  }) {
    return _db.into(_db.erratumsPv).insert(
          ErratumsPvCompanion.insert(
            id: IdGenerator.newId(),
            procesVerbalId: procesVerbalId,
            texte: texte,
            dateAjout: DateTime.now(),
            auteurFideleId: Value(auteurFideleId),
          ),
        );
  }

  // --- Tâches de suivi (RG-VII-03) --------------------------------------------

  Stream<List<TacheSuivi>> watchTaches(String decisionId) {
    final query = _db.select(_db.tachesSuivi)..where((t) => t.decisionId.equals(decisionId));
    return query.watch().map((rows) => rows.map(_tacheToDomain).toList(growable: false));
  }

  Future<void> creerTache({
    required String decisionId,
    required String description,
    required String assigneFideleId,
  }) {
    return _db.into(_db.tachesSuivi).insert(
          TachesSuiviCompanion.insert(
            id: IdGenerator.newId(),
            decisionId: decisionId,
            description: description,
            assigneFideleId: assigneFideleId,
            dateCreation: DateTime.now(),
          ),
        );
  }

  Future<void> marquerTacheFaite(String id) async {
    await (_db.update(_db.tachesSuivi)..where((t) => t.id.equals(id)))
        .write(TachesSuiviCompanion(statut: Value(StatutTache.fait.code)));
  }

  MembreComite _membreToDomain(MembreComiteRow row) {
    return MembreComite(
      id: row.id,
      fideleId: row.fideleId,
      noeudId: row.noeudId,
      fonction: row.fonction,
      dateDebut: row.dateDebut,
      dateFin: row.dateFin,
    );
  }

  SeanceComite _seanceToDomain(SeanceComiteRow row) {
    return SeanceComite(
      id: row.id,
      noeudId: row.noeudId,
      date: row.date,
      ordreDuJour: row.ordreDuJour,
      quorumAtteint: row.quorumAtteint,
    );
  }

  Decision _decisionToDomain(DecisionRow row) {
    return Decision(
      id: row.id,
      seanceId: row.seanceId,
      libelle: row.libelle,
      resultatVote: row.resultatVote,
      statut: StatutDecision.fromCode(row.statut),
      porteeDisciplinaire: row.porteeDisciplinaire,
    );
  }

  ProcesVerbal _pvToDomain(ProcesVerbalRow row) {
    return ProcesVerbal(
      id: row.id,
      seanceId: row.seanceId,
      contenu: row.contenu,
      statut: StatutProcesVerbal.fromCode(row.statut),
      documentArchiveId: row.documentArchiveId,
    );
  }

  ErratumPv _erratumToDomain(ErratumPvRow row) {
    return ErratumPv(
      id: row.id,
      procesVerbalId: row.procesVerbalId,
      texte: row.texte,
      dateAjout: row.dateAjout,
      auteurFideleId: row.auteurFideleId,
    );
  }

  TacheSuivi _tacheToDomain(TacheSuiviRow row) {
    return TacheSuivi(
      id: row.id,
      decisionId: row.decisionId,
      description: row.description,
      assigneFideleId: row.assigneFideleId,
      statut: StatutTache.fromCode(row.statut),
      dateCreation: row.dateCreation,
    );
  }
}
