import 'package:drift/drift.dart';

import '../../../core/audit/consultation_disciplinaire.dart';
import '../../../core/audit/journal_consultations_repository.dart';
import '../../../core/error/app_error.dart';
import '../../../core/utils/id_generator.dart';
import '../../archivage/data/archivage_repository.dart';
import '../../fideles/data/fidele_repository.dart';
import '../../fideles/domain/models/statut_spirituel.dart';
import '../../ministeres/data/ministere_repository.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/role.dart';
import '../domain/models/commission_disciplinaire.dart';
import '../domain/models/dossier_disciplinaire.dart';
import '../domain/models/membre_commission.dart';
import '../domain/models/nature_faute.dart';
import '../domain/models/nature_piece_dossier.dart';
import '../domain/models/piece_dossier.dart';
import '../domain/models/statut_dossier_disciplinaire.dart';
import '../domain/rules/discipline_rules.dart';

/// Dépôt Module X — Discipline (RG-X-01 à 06). `FideleRepository` et
/// `MinistereRepository` sont des dépendances requises (RG-X-01 bascule le
/// statut spirituel, RG-X-03 suspend les affectations — les deux modules
/// existent déjà, contrairement au précédent Archivage/Comité où le module
/// cible n'existait pas encore) ; `ArchivageRepository` reste optionnel
/// (RG-X-06), même pattern d'injection que `ComiteRepository`/
/// `DeplacementRepository` vers le Module VIII. Synchronisation distante
/// différée pour ce module (même précédent documenté que les modules
/// précédents).
class DisciplineRepository {
  DisciplineRepository(
    this._db,
    this._fideleRepository,
    this._ministereRepository, {
    ArchivageRepository? archivageRepository,
  }) : _archivage = archivageRepository,
       _journal = JournalConsultationsRepository(_db);

  final AppDatabase _db;
  final FideleRepository _fideleRepository;
  final MinistereRepository _ministereRepository;
  final ArchivageRepository? _archivage;
  final JournalConsultationsRepository _journal;

  // --- Natures de faute (référentiel, RG-X-02) ------------------------------

  Stream<List<NatureFaute>> watchNaturesFaute() {
    final query = _db.select(_db.naturesFaute)..orderBy([(t) => OrderingTerm.asc(t.libelle)]);
    return query.watch().map((rows) => rows.map(_natureFauteToDomain).toList(growable: false));
  }

  /// RG-X-02 — le référentiel reste extensible ; l'ajout d'une nature de
  /// faute est un choix pastoral/administratif pris hors du logiciel, jamais
  /// une catégorie imposée par le code (voir AGENTS.md §7, entrée Module X :
  /// aucune catégorie à caractère moral, doctrinal ou théologique).
  Future<NatureFaute> ajouterNatureFaute({required String code, required String libelle}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.naturesFaute).insert(
          NaturesFauteCompanion.insert(id: id, code: code, libelle: libelle),
        );
    final row = await (_db.select(_db.naturesFaute)..where((t) => t.id.equals(id))).getSingle();
    return _natureFauteToDomain(row);
  }

  // --- Commissions (RG-X-02) -------------------------------------------------

  Stream<List<CommissionDisciplinaire>> watchCommissions(String noeudId) {
    final query = _db.select(_db.commissionsDisciplinaires)..where((t) => t.noeudId.equals(noeudId));
    return query.watch().map((rows) => rows.map(_commissionToDomain).toList(growable: false));
  }

  Future<CommissionDisciplinaire> creerCommission({required String noeudId, required String nom}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.commissionsDisciplinaires).insert(
          CommissionsDisciplinairesCompanion.insert(id: id, noeudId: noeudId, nom: nom),
        );
    final row =
        await (_db.select(_db.commissionsDisciplinaires)..where((t) => t.id.equals(id))).getSingle();
    return _commissionToDomain(row);
  }

  Stream<List<MembreCommission>> watchMembresCommission(String commissionId) {
    final query = _db.select(_db.membresCommissionDisciplinaire)
      ..where((t) => t.commissionId.equals(commissionId));
    return query.watch().map((rows) => rows.map(_membreCommissionToDomain).toList(growable: false));
  }

  Future<void> ajouterMembreCommission({required String commissionId, required String fideleId}) async {
    await _db.into(_db.membresCommissionDisciplinaire).insert(
          MembresCommissionDisciplinaireCompanion.insert(
            id: IdGenerator.newId(),
            commissionId: commissionId,
            fideleId: fideleId,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> retirerMembreCommission(String id) async {
    await (_db.delete(_db.membresCommissionDisciplinaire)..where((t) => t.id.equals(id))).go();
  }

  /// Commissions dont [fideleId] est membre (RG-X-05) : habilitation par
  /// appartenance, indépendante du rang.
  Stream<List<CommissionDisciplinaire>> watchCommissionsDuFidele(String fideleId) {
    final query = _db.select(_db.commissionsDisciplinaires).join([
      innerJoin(
        _db.membresCommissionDisciplinaire,
        _db.membresCommissionDisciplinaire.commissionId.equalsExp(_db.commissionsDisciplinaires.id),
      ),
    ])
      ..where(_db.membresCommissionDisciplinaire.fideleId.equals(fideleId));
    return query.watch().map(
          (rows) => rows
              .map((row) => _commissionToDomain(row.readTable(_db.commissionsDisciplinaires)))
              .toList(growable: false),
        );
  }

  Future<bool> estMembreDuneCommissionDuNoeud({required String fideleId, required String noeudId}) async {
    final query = _db.select(_db.membresCommissionDisciplinaire).join([
      innerJoin(
        _db.commissionsDisciplinaires,
        _db.commissionsDisciplinaires.id.equalsExp(_db.membresCommissionDisciplinaire.commissionId),
      ),
    ])
      ..where(
        _db.membresCommissionDisciplinaire.fideleId.equals(fideleId) &
            _db.commissionsDisciplinaires.noeudId.equals(noeudId),
      )
      ..limit(1);
    final rows = await query.get();
    return rows.isNotEmpty;
  }

  // --- Dossiers (RG-X-01 à 04) -----------------------------------------------

  Stream<List<DossierDisciplinaire>> watchDossiers(String noeudId) {
    final query = _db.select(_db.dossiersDisciplinaires)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateOuverture)]);
    return query.watch().map((rows) => rows.map(_dossierToDomain).toList(growable: false));
  }

  /// RG-X-05 — historique confidentiel d'un fidèle (écran 6), tous nœuds
  /// confondus.
  Stream<List<DossierDisciplinaire>> watchDossiersDuFidele(String fideleId) {
    final query = _db.select(_db.dossiersDisciplinaires)
      ..where((t) => t.fideleId.equals(fideleId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateOuverture)]);
    return query.watch().map((rows) => rows.map(_dossierToDomain).toList(growable: false));
  }

  Future<DossierDisciplinaire?> findDossierById(String id) async {
    final row =
        await (_db.select(_db.dossiersDisciplinaires)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _dossierToDomain(row);
  }

  /// RG-X-05 / RG-SEC-06 — ouverture de la fiche d'un dossier par le compte
  /// courant : refusée (`AppError.dossierDisciplinaireAccesRefuse`) sans
  /// habilitation — vérifiée ici, pas seulement par l'écran —, sinon
  /// journalisée (journal systématique de toute consultation).
  Future<DossierDisciplinaire?> consulterDossier({
    required String dossierId,
    required String authUserId,
    required String? fideleId,
    required Role role,
  }) async {
    final dossier = await findDossierById(dossierId);
    if (dossier == null) return null;
    final estMembre = fideleId != null &&
        dossier.commissionId != null &&
        await (_db.select(_db.membresCommissionDisciplinaire)
                  ..where((t) => t.fideleId.equals(fideleId) & t.commissionId.equals(dossier.commissionId!)))
                .getSingleOrNull() !=
            null;
    if (!DisciplineRules.peutConsulterDossier(role: role, estMembreCommissionAssignee: estMembre)) {
      throw AppError.dossierDisciplinaireAccesRefuse();
    }
    await _journal.journaliser(dossierId: dossierId, authUserId: authUserId, fideleId: fideleId, role: role);
    return dossier;
  }

  /// RG-SEC-06 — journal des consultations d'un dossier (fiche et pièces).
  Stream<List<ConsultationDisciplinaire>> watchConsultations(String dossierId) =>
      _journal.watchConsultations(dossierId);

  /// RG-X-01 — ouverture d'un dossier : bascule immédiatement le statut
  /// spirituel du fidèle (module II) vers `membreEnDiscipline`, en
  /// mémorisant le statut antérieur pour une restauration exacte à la
  /// clôture (RG-X-04).
  Future<DossierDisciplinaire> ouvrirDossier({
    required String fideleId,
    required String noeudId,
    required String natureFauteId,
    required Role roleActeur,
    String? ouvertParFideleId,
    String? decisionComiteOrigineId,
  }) async {
    // L'appartenance à une commission se vérifie pour l'acteur qui ouvre le
    // dossier (RG-X-01), jamais pour le fidèle mis en cause.
    final estMembreCommission = ouvertParFideleId == null
        ? false
        : await estMembreDuneCommissionDuNoeud(fideleId: ouvertParFideleId, noeudId: noeudId);
    final erreur = DisciplineRules.raisonBlocageOuverture(
      roleActeur: roleActeur,
      estMembreCommission: estMembreCommission,
    );
    if (erreur != null) {
      throw erreur;
    }

    final fidele = await _fideleRepository.findById(fideleId);
    if (fidele == null) {
      throw ArgumentError('Fidèle introuvable : $fideleId');
    }

    final id = IdGenerator.newId();
    final maintenant = DateTime.now();
    await _db.into(_db.dossiersDisciplinaires).insert(
          DossiersDisciplinairesCompanion.insert(
            id: id,
            fideleId: fideleId,
            noeudId: noeudId,
            natureFauteId: natureFauteId,
            dateOuverture: maintenant,
            ouvertParFideleId: Value(ouvertParFideleId),
            statutSpirituelAnterieur: Value(fidele.statutSpirituel.code),
            decisionComiteOrigineId: Value(decisionComiteOrigineId),
          ),
        );

    await _fideleRepository.modifierStatutSpirituel(
      fideleId: fideleId,
      cible: StatutSpirituel.membreEnDiscipline,
      viaModuleDiscipline: true,
      auteurFideleId: ouvertParFideleId,
    );

    return (await findDossierById(id))!;
  }

  Future<void> assignerCommission({required String dossierId, required String commissionId}) async {
    await (_db.update(_db.dossiersDisciplinaires)..where((t) => t.id.equals(dossierId)))
        .write(DossiersDisciplinairesCompanion(commissionId: Value(commissionId)));
  }

  Stream<List<PieceDossier>> watchPieces(String dossierId) {
    final query = _db.select(_db.piecesDossier)..where((t) => t.dossierId.equals(dossierId));
    return query.watch().map((rows) => rows.map(_pieceToDomain).toList(growable: false));
  }

  /// RG-X-02/06 — [contenu] est archivé (module VIII, confidentialité
  /// `restreint` : le niveau maximal disponible aujourd'hui, voir
  /// `ArchivageRules.niveauConfidentialiteEffectif`) quand un dépôt
  /// d'archivage est injecté ; sinon `documentArchiveId` reste `null`, même
  /// précédent que `ProcesVerbal` (module VII). La capture de pièces
  /// binaires (photo/scan) reste bloquée faute d'infra caméra/galerie, comme
  /// documenté pour le Module II.
  Future<PieceDossier> ajouterPiece({
    required String dossierId,
    required NaturePieceDossier nature,
    required String contenu,
    required String noeudId,
  }) async {
    String? documentArchiveId;
    final archivage = _archivage;
    if (archivage != null) {
      final document = await archivage.archiver(
        typeDocument: 'piece_dossier_disciplinaire',
        moduleOrigine: 'discipline',
        objetIdOrigine: dossierId,
        noeudId: noeudId,
        fichier: contenu,
        sensible: true,
      );
      documentArchiveId = document.id;
    }

    final id = IdGenerator.newId();
    await _db.into(_db.piecesDossier).insert(
          PiecesDossierCompanion.insert(
            id: id,
            dossierId: dossierId,
            nature: nature.code,
            ajouteLe: DateTime.now(),
            documentArchiveId: Value(documentArchiveId),
          ),
        );
    final row = await (_db.select(_db.piecesDossier)..where((t) => t.id.equals(id))).getSingle();
    return _pieceToDomain(row);
  }

  /// RG-X-02/03/04 — prononce la décision : exige une commission assignée,
  /// calcule la date de réintégration prévue si la durée est déterminée, et
  /// suspend les affectations ministérielles actives (module III) si
  /// demandé.
  Future<void> prononcerDecision({
    required String dossierId,
    required String decision,
    int? dureeSanctionJours,
    bool suspendreMinisteres = false,
  }) async {
    final dossier = await findDossierById(dossierId);
    if (dossier == null) {
      throw ArgumentError('Dossier disciplinaire introuvable : $dossierId');
    }

    final erreurStatut = DisciplineRules.raisonBlocagePrononceDecision(statut: dossier.statut);
    if (erreurStatut != null) {
      throw erreurStatut;
    }
    final erreurCommission =
        DisciplineRules.raisonBlocageDecision(commissionRenseignee: dossier.commissionId != null);
    if (erreurCommission != null) {
      throw erreurCommission;
    }

    final dateDecision = DateTime.now();
    final dateReintegrationPrevue = DisciplineRules.calculerDateReintegrationPrevue(
      dateDecision: dateDecision,
      dureeSanctionJours: dureeSanctionJours,
    );

    if (suspendreMinisteres) {
      await _ministereRepository.suspendreAffectationsActives(dossier.fideleId);
    }

    await (_db.update(_db.dossiersDisciplinaires)..where((t) => t.id.equals(dossierId))).write(
      DossiersDisciplinairesCompanion(
        decision: Value(decision),
        dateDecision: Value(dateDecision),
        dureeSanctionJours: Value(dureeSanctionJours),
        dateReintegrationPrevue: Value(dateReintegrationPrevue),
        suspensionMinisteresAppliquee: Value(suspendreMinisteres),
        statut: Value(StatutDossierDisciplinaire.sanctionne.code),
      ),
    );
  }

  /// RG-X-04 — clôture/réintégration : restaure le statut spirituel
  /// antérieur (module II) et réintègre les affectations ministérielles si
  /// elles avaient été suspendues (module III).
  Future<void> cloturer(String dossierId) async {
    final dossier = await findDossierById(dossierId);
    if (dossier == null) {
      throw ArgumentError('Dossier disciplinaire introuvable : $dossierId');
    }

    final erreur = DisciplineRules.raisonBlocageCloture(statut: dossier.statut);
    if (erreur != null) {
      throw erreur;
    }

    final statutAnterieur = dossier.statutSpirituelAnterieur == null
        ? StatutSpirituel.membreActif
        : StatutSpirituel.fromCode(dossier.statutSpirituelAnterieur!);

    await _fideleRepository.modifierStatutSpirituel(
      fideleId: dossier.fideleId,
      cible: statutAnterieur,
      viaModuleDiscipline: true,
    );

    if (dossier.suspensionMinisteresAppliquee) {
      await _ministereRepository.reintegrerAffectations(dossier.fideleId);
    }

    await (_db.update(_db.dossiersDisciplinaires)..where((t) => t.id.equals(dossierId))).write(
      DossiersDisciplinairesCompanion(statut: Value(StatutDossierDisciplinaire.clos.code)),
    );
  }

  /// RG-X-04 — dossiers sanctionnés dont la durée déterminée est arrivée à
  /// échéance (alerte de fin de période au responsable de suivi).
  Future<List<DossierDisciplinaire>> dossiersEnAlerteFinDePeriode({DateTime? maintenant}) async {
    final reference = maintenant ?? DateTime.now();
    final rows = await (_db.select(_db.dossiersDisciplinaires)
          ..where(
            (t) =>
                t.statut.equals(StatutDossierDisciplinaire.sanctionne.code) &
                t.dateReintegrationPrevue.isNotNull() &
                t.dateReintegrationPrevue.isSmallerOrEqualValue(reference),
          ))
        .get();
    return rows.map(_dossierToDomain).toList(growable: false);
  }

  /// RG-X-04 — dossiers sanctionnés à durée indéterminée nécessitant une
  /// revue périodique (voir `AppDefaults.disciplineRevuePeriodiqueJours`).
  Future<List<DossierDisciplinaire>> dossiersEnRevuePeriodique({
    required int seuilJours,
    DateTime? maintenant,
  }) async {
    final reference = maintenant ?? DateTime.now();
    final rows = await (_db.select(_db.dossiersDisciplinaires)
          ..where(
            (t) =>
                t.statut.equals(StatutDossierDisciplinaire.sanctionne.code) &
                t.dureeSanctionJours.isNull() &
                t.dateDecision.isNotNull(),
          ))
        .get();
    return rows
        .where(
          (row) => DisciplineRules.necessiteRevuePeriodique(
            dateDecision: row.dateDecision!,
            maintenant: reference,
            seuilJours: seuilJours,
          ),
        )
        .map(_dossierToDomain)
        .toList(growable: false);
  }

  NatureFaute _natureFauteToDomain(NatureFauteRow row) {
    return NatureFaute(id: row.id, code: row.code, libelle: row.libelle, standard: row.standard, statut: row.statut);
  }

  CommissionDisciplinaire _commissionToDomain(CommissionDisciplinaireRow row) {
    return CommissionDisciplinaire(id: row.id, noeudId: row.noeudId, nom: row.nom, statut: row.statut);
  }

  MembreCommission _membreCommissionToDomain(MembreCommissionRow row) {
    return MembreCommission(id: row.id, commissionId: row.commissionId, fideleId: row.fideleId);
  }

  PieceDossier _pieceToDomain(PieceDossierRow row) {
    return PieceDossier(
      id: row.id,
      dossierId: row.dossierId,
      nature: NaturePieceDossier.fromCode(row.nature),
      ajouteLe: row.ajouteLe,
      documentArchiveId: row.documentArchiveId,
    );
  }

  DossierDisciplinaire _dossierToDomain(DossierDisciplinaireRow row) {
    return DossierDisciplinaire(
      id: row.id,
      fideleId: row.fideleId,
      noeudId: row.noeudId,
      natureFauteId: row.natureFauteId,
      dateOuverture: row.dateOuverture,
      statut: StatutDossierDisciplinaire.fromCode(row.statut),
      ouvertParFideleId: row.ouvertParFideleId,
      statutSpirituelAnterieur: row.statutSpirituelAnterieur,
      commissionId: row.commissionId,
      decision: row.decision,
      dateDecision: row.dateDecision,
      dureeSanctionJours: row.dureeSanctionJours,
      dateReintegrationPrevue: row.dateReintegrationPrevue,
      suspensionMinisteresAppliquee: row.suspensionMinisteresAppliquee,
      decisionComiteOrigineId: row.decisionComiteOrigineId,
    );
  }
}
