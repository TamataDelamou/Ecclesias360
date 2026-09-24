import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/id_generator.dart';
import '../../fideles/data/fidele_repository.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/role.dart';
import '../domain/models/contribution.dart';
import '../domain/models/depense_projet.dart';
import '../domain/models/echeance_engagement.dart';
import '../domain/models/engagement.dart';
import '../domain/models/origine_contribution.dart';
import '../domain/models/periodicite_engagement.dart';
import '../domain/models/projet.dart';
import '../domain/models/statut_contribution.dart';
import '../domain/models/statut_echeance.dart';
import '../domain/models/statut_engagement.dart';
import '../domain/models/statut_projet.dart';
import '../domain/models/tresorier_noeud.dart';
import '../domain/models/type_engagement.dart';
import '../domain/models/type_offrande.dart';
import '../../comptabilite/data/comptabilite_repository.dart';
import '../domain/rules/finances_rules.dart';

/// Dépôt Module XI — Finances (RG-XI-01 à 07). `FideleRepository` n'est pas
/// une dépendance directe (aucune écriture croisée requise dans ce lot,
/// contrairement à Déplacements/Discipline) ; le rattachement au fidèle
/// contributeur reste un simple identifiant validé côté application.
/// Synchronisation distante différée pour ce module (même précédent
/// documenté que les modules précédents).
class FinancesRepository {
  FinancesRepository(this._db, this._fideleRepository, {ComptabiliteRepository? comptabiliteRepository})
      : _comptabilite = comptabiliteRepository;

  final AppDatabase _db;
  // ignore: unused_field
  final FideleRepository _fideleRepository;
  final ComptabiliteRepository? _comptabilite;

  // --- Types d'offrande (référentiel, RG-XI-01) -----------------------------

  Stream<List<TypeOffrande>> watchTypesOffrande() {
    final query = _db.select(_db.typesOffrande)..orderBy([(t) => OrderingTerm.asc(t.libelle)]);
    return query.watch().map((rows) => rows.map(_typeOffrandeToDomain).toList(growable: false));
  }

  Future<TypeOffrande> ajouterTypeOffrande({required String code, required String libelle}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.typesOffrande).insert(TypesOffrandeCompanion.insert(id: id, code: code, libelle: libelle));
    final row = await (_db.select(_db.typesOffrande)..where((t) => t.id.equals(id))).getSingle();
    return _typeOffrandeToDomain(row);
  }

  // --- Trésoriers (RG-XI-02) -------------------------------------------------

  Stream<List<TresorierNoeud>> watchTresoriers(String noeudId) {
    final query = _db.select(_db.tresoriersNoeud)..where((t) => t.noeudId.equals(noeudId) & t.dateFin.isNull());
    return query.watch().map((rows) => rows.map(_tresorierToDomain).toList(growable: false));
  }

  Future<TresorierNoeud> designerTresorier({required String fideleId, required String noeudId}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.tresoriersNoeud).insert(
          TresoriersNoeudCompanion.insert(id: id, fideleId: fideleId, noeudId: noeudId, dateDebut: DateTime.now()),
        );
    final row = await (_db.select(_db.tresoriersNoeud)..where((t) => t.id.equals(id))).getSingle();
    return _tresorierToDomain(row);
  }

  Future<void> retirerTresorier(String id) async {
    await (_db.update(_db.tresoriersNoeud)..where((t) => t.id.equals(id)))
        .write(TresoriersNoeudCompanion(dateFin: Value(DateTime.now())));
  }

  /// Nœuds dont [fideleId] est trésorier en fonction (RG-XI-02, RG-SEC-06) :
  /// habilitation par désignation, indépendante du rang.
  Stream<Set<String>> watchNoeudsDuTresorier(String fideleId) {
    final query = _db.select(_db.tresoriersNoeud)..where((t) => t.fideleId.equals(fideleId) & t.dateFin.isNull());
    return query.watch().map((rows) => {for (final row in rows) row.noeudId});
  }

  Future<bool> estTresorierDuNoeud({required String fideleId, required String noeudId}) async {
    final rows = await (_db.select(_db.tresoriersNoeud)
          ..where((t) => t.fideleId.equals(fideleId) & t.noeudId.equals(noeudId) & t.dateFin.isNull())
          ..limit(1))
        .get();
    return rows.isNotEmpty;
  }

  // --- Contributions (RG-XI-01/02/05/06) -------------------------------------

  Stream<List<Contribution>> watchContributions(String noeudId) {
    final query = _db.select(_db.contributions)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateSaisie)]);
    return query.watch().map((rows) => rows.map(_contributionToDomain).toList(growable: false));
  }

  Stream<List<Contribution>> watchContributionsDuFidele(String fideleId) {
    final query = _db.select(_db.contributions)
      ..where((t) => t.fideleId.equals(fideleId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateSaisie)]);
    return query.watch().map((rows) => rows.map(_contributionToDomain).toList(growable: false));
  }

  Future<Contribution?> findContributionById(String id) async {
    final row = await (_db.select(_db.contributions)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _contributionToDomain(row);
  }

  /// RG-XI-01/04 — la saisie démarre toujours `enAttente` (RG-XI-02) : la
  /// validation comptable est un acte distinct.
  Future<Contribution> saisirContribution({
    String? fideleId,
    String? libelleDonateurAnonyme,
    required String typeOffrandeId,
    required int montant,
    required String devise,
    required String noeudId,
    String? culteId,
    String? projetId,
    required String modePaiement,
    required OrigineContribution origine,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.contributions).insert(
          ContributionsCompanion.insert(
            id: id,
            fideleId: Value(fideleId),
            libelleDonateurAnonyme: Value(libelleDonateurAnonyme),
            typeOffrandeId: typeOffrandeId,
            montant: montant,
            devise: devise,
            noeudId: noeudId,
            culteId: Value(culteId),
            projetId: Value(projetId),
            modePaiement: modePaiement,
            origine: origine.code,
            dateSaisie: DateTime.now(),
          ),
        );
    return (await findContributionById(id))!;
  }

  /// RG-XI-02 — validation comptable : habilitée au rang pasteur/
  /// administrateur ou à un trésorier désigné du nœud de la contribution.
  Future<Contribution> validerContribution({
    required String id,
    required Role roleActeur,
    required String valideParFideleId,
  }) async {
    final contribution = await _findContributionOrThrow(id);
    if (contribution.statut != StatutContribution.enAttente) {
      throw AppError.contributionNonEnAttente();
    }
    await _verifierHabilitation(roleActeur: roleActeur, acteurFideleId: valideParFideleId, noeudId: contribution.noeudId);

    await (_db.update(_db.contributions)..where((t) => t.id.equals(id))).write(
      ContributionsCompanion(
        statut: Value(StatutContribution.validee.code),
        valideParFideleId: Value(valideParFideleId),
        dateValidation: Value(DateTime.now()),
      ),
    );

    final comptabilite = _comptabilite;
    if (comptabilite != null) {
      await comptabilite.genererEcecturesContributionValidee(
        contributionId: id,
        montant: contribution.montant,
        noeudId: contribution.noeudId,
      );
    }
    return (await findContributionById(id))!;
  }

  /// RG-XI-02 — même habilitation que la validation ; l'auteur de la
  /// décision est tracé dans `valideParFideleId` (auteur de la décision
  /// comptable, validation ou rejet — `dateValidation` reste vide).
  Future<Contribution> rejeterContribution({
    required String id,
    required Role roleActeur,
    required String rejeteParFideleId,
    String? motifRejet,
  }) async {
    final contribution = await _findContributionOrThrow(id);
    if (contribution.statut != StatutContribution.enAttente) {
      throw AppError.contributionNonEnAttente();
    }
    await _verifierHabilitation(roleActeur: roleActeur, acteurFideleId: rejeteParFideleId, noeudId: contribution.noeudId);
    await (_db.update(_db.contributions)..where((t) => t.id.equals(id))).write(
      ContributionsCompanion(
        statut: Value(StatutContribution.rejetee.code),
        motifRejet: Value(motifRejet),
        valideParFideleId: Value(rejeteParFideleId),
      ),
    );
    return (await findContributionById(id))!;
  }

  /// RG-XI-05 — une contribution validée n'est jamais éditée : la correction
  /// prend la forme d'une nouvelle contribution de montant inverse,
  /// directement validée (acte comptable), qui référence l'originale. Même
  /// habilitation que la validation (RG-XI-02), valideur tracé.
  Future<Contribution> contrePasserContribution({
    required String id,
    required Role roleActeur,
    required String valideParFideleId,
    String? motif,
  }) async {
    final origine = await _findContributionOrThrow(id);
    if (origine.statut != StatutContribution.validee) {
      throw AppError.contributionNonValideePourContrePassation();
    }
    await _verifierHabilitation(roleActeur: roleActeur, acteurFideleId: valideParFideleId, noeudId: origine.noeudId);

    final nouvelId = IdGenerator.newId();
    final maintenant = DateTime.now();
    await _db.into(_db.contributions).insert(
          ContributionsCompanion.insert(
            id: nouvelId,
            fideleId: Value(origine.fideleId),
            libelleDonateurAnonyme: Value(origine.libelleDonateurAnonyme),
            typeOffrandeId: origine.typeOffrandeId,
            montant: -origine.montant,
            devise: origine.devise,
            noeudId: origine.noeudId,
            culteId: Value(origine.culteId),
            projetId: Value(origine.projetId),
            modePaiement: origine.modePaiement,
            statut: Value(StatutContribution.validee.code),
            origine: origine.origine.code,
            dateSaisie: maintenant,
            dateValidation: Value(maintenant),
            valideParFideleId: Value(valideParFideleId),
            motifRejet: Value(motif),
            contributionOrigineId: Value(origine.id),
            estContrePassation: const Value(true),
          ),
        );

    final comptabilite = _comptabilite;
    if (comptabilite != null) {
      await comptabilite.genererEcecturesContributionValidee(
        contributionId: nouvelId,
        montant: -origine.montant,
        noeudId: origine.noeudId,
      );
    }
    return (await findContributionById(nouvelId))!;
  }

  /// RG-XI-06 — détecte les doublons potentiels (même fidèle, même montant,
  /// même minute) parmi les contributions déjà saisies au même nœud, pour
  /// rapprochement à la reconnexion.
  Future<List<Contribution>> detecterDoublonsPotentiels(Contribution nouvelle) async {
    if (nouvelle.fideleId == null) return const [];
    final candidates = await (_db.select(_db.contributions)
          ..where((t) => t.noeudId.equals(nouvelle.noeudId) & t.fideleId.equals(nouvelle.fideleId!) & t.id.equals(nouvelle.id).not()))
        .get();
    return candidates
        .map(_contributionToDomain)
        .where(
          (c) => FinancesRules.sontDoublonsPotentiels(
            fideleIdA: c.fideleId,
            montantA: c.montant,
            dateA: c.dateSaisie,
            fideleIdB: nouvelle.fideleId,
            montantB: nouvelle.montant,
            dateB: nouvelle.dateSaisie,
          ),
        )
        .toList(growable: false);
  }

  /// RG-XI-02 — rang pasteur (ou plus), ou trésorier désigné du nœud ; la
  /// désignation se vérifie toujours sur l'acteur, jamais sur le donateur.
  Future<void> _verifierHabilitation({
    required Role roleActeur,
    required String acteurFideleId,
    required String noeudId,
  }) async {
    final erreur = FinancesRules.raisonBlocageValidationContribution(
      roleActeur: roleActeur,
      estTresorierDuNoeud: await estTresorierDuNoeud(fideleId: acteurFideleId, noeudId: noeudId),
    );
    if (erreur != null) throw erreur;
  }

  Future<Contribution> _findContributionOrThrow(String id) async {
    final contribution = await findContributionById(id);
    if (contribution == null) {
      throw ArgumentError('Contribution introuvable : $id');
    }
    return contribution;
  }

  // --- Projets et dépenses (RG-XI-03) -----------------------------------------

  Stream<List<Projet>> watchProjets(String noeudId) {
    final query = _db.select(_db.projets)..where((t) => t.noeudId.equals(noeudId));
    return query.watch().map((rows) => rows.map(_projetToDomain).toList(growable: false));
  }

  Future<Projet?> findProjetById(String id) async {
    final row = await (_db.select(_db.projets)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _projetToDomain(row);
  }

  Future<Projet> creerProjet({
    required String noeudId,
    required String nom,
    required int budgetPrevisionnel,
    required String devise,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.projets).insert(
          ProjetsCompanion.insert(id: id, noeudId: noeudId, nom: nom, budgetPrevisionnel: budgetPrevisionnel, devise: devise),
        );
    return (await findProjetById(id))!;
  }

  Stream<List<DepenseProjet>> watchDepensesProjet(String projetId) {
    final query = _db.select(_db.depensesProjet)
      ..where((t) => t.projetId.equals(projetId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_depenseToDomain).toList(growable: false));
  }

  /// RG-XI-03 — solde en temps réel : recettes (contributions validées
  /// rattachées, contre-passations comprises) moins dépenses validées.
  Future<int> soldeProjet(String projetId) async {
    final contributions = await (_db.select(_db.contributions)
          ..where((t) => t.projetId.equals(projetId) & t.statut.equals(StatutContribution.validee.code)))
        .get();
    final depenses = await (_db.select(_db.depensesProjet)..where((t) => t.projetId.equals(projetId))).get();
    final totalContributions = contributions.fold<int>(0, (s, c) => s + c.montant);
    final totalDepenses = depenses.fold<int>(0, (s, d) => s + d.montant);
    return FinancesRules.calculerSoldeProjet(totalContributionsValidees: totalContributions, totalDepenses: totalDepenses);
  }

  /// RG-XI-03 — engage une dépense, bloquée au-delà du solde disponible
  /// sans dérogation tracée.
  Future<DepenseProjet> ajouterDepenseProjet({
    required String projetId,
    required int montant,
    required String libelle,
    required String valideParFideleId,
    bool derogationTracee = false,
    String? motifDerogation,
  }) async {
    final solde = await soldeProjet(projetId);
    final erreur = FinancesRules.raisonBlocageDepense(
      soldeDisponible: solde,
      montantDepense: montant,
      derogationTracee: derogationTracee,
    );
    if (erreur != null) {
      throw erreur;
    }

    final id = IdGenerator.newId();
    await _db.into(_db.depensesProjet).insert(
          DepensesProjetCompanion.insert(
            id: id,
            projetId: projetId,
            montant: montant,
            libelle: libelle,
            date: DateTime.now(),
            valideParFideleId: valideParFideleId,
            derogationTracee: Value(derogationTracee),
            motifDerogation: Value(motifDerogation),
          ),
        );
    final row = await (_db.select(_db.depensesProjet)..where((t) => t.id.equals(id))).getSingle();
    return _depenseToDomain(row);
  }

  // --- Engagements et échéances (RG-XI-04) ------------------------------------

  Stream<List<Engagement>> watchEngagements(String fideleId) {
    final query = _db.select(_db.engagements)..where((t) => t.fideleId.equals(fideleId));
    return query.watch().map((rows) => rows.map(_engagementToDomain).toList(growable: false));
  }

  /// RG-XI-04 — crée l'engagement et génère immédiatement ses [nombreEcheances]
  /// premières échéances (`en_attente`).
  Future<Engagement> creerEngagement({
    required String fideleId,
    required TypeEngagement type,
    required int montantPrevu,
    required PeriodiciteEngagement periodicite,
    required DateTime dateDebut,
    int nombreEcheances = 12,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.engagements).insert(
          EngagementsCompanion.insert(
            id: id,
            fideleId: fideleId,
            type: type.code,
            montantPrevu: montantPrevu,
            periodicite: periodicite.code,
            dateDebut: dateDebut,
          ),
        );

    final dates = FinancesRules.genererDatesEcheance(dateDebut: dateDebut, periodicite: periodicite, nombre: nombreEcheances);
    await _db.batch((b) {
      b.insertAll(
        _db.echeancesEngagement,
        [
          for (final date in dates)
            EcheancesEngagementCompanion.insert(id: IdGenerator.newId(), engagementId: id, dateEcheance: date),
        ],
      );
    });

    final row = await (_db.select(_db.engagements)..where((t) => t.id.equals(id))).getSingle();
    return _engagementToDomain(row);
  }

  Stream<List<EcheanceEngagement>> watchEcheances(String engagementId) {
    final query = _db.select(_db.echeancesEngagement)
      ..where((t) => t.engagementId.equals(engagementId))
      ..orderBy([(t) => OrderingTerm.asc(t.dateEcheance)]);
    return query.watch().map((rows) => rows.map(_echeanceToDomain).toList(growable: false));
  }

  /// RG-XI-04 — échéances en attente déjà passées, pour relance (aucun
  /// scheduler ni notification poussée dans ce lot : lecture seule, voir
  /// AGENTS.md, entrée Module XI).
  Future<List<EcheanceEngagement>> echeancesEnRetard({DateTime? maintenant}) async {
    final reference = maintenant ?? DateTime.now();
    final rows = await (_db.select(_db.echeancesEngagement)
          ..where((t) => t.statut.equals(StatutEcheance.enAttente.code)))
        .get();
    return rows
        .map(_echeanceToDomain)
        .where((e) => FinancesRules.estEnRetard(dateEcheance: e.dateEcheance, maintenant: reference))
        .toList(growable: false);
  }

  Future<void> honorerEcheance({required String id, required String contributionId}) async {
    await (_db.update(_db.echeancesEngagement)..where((t) => t.id.equals(id))).write(
      EcheancesEngagementCompanion(
        statut: Value(StatutEcheance.honoree.code),
        contributionId: Value(contributionId),
      ),
    );
  }

  // --- Conversions ------------------------------------------------------------

  TypeOffrande _typeOffrandeToDomain(TypeOffrandeRow row) {
    return TypeOffrande(id: row.id, code: row.code, libelle: row.libelle, standard: row.standard, statut: row.statut);
  }

  TresorierNoeud _tresorierToDomain(TresorierNoeudRow row) {
    return TresorierNoeud(id: row.id, fideleId: row.fideleId, noeudId: row.noeudId, dateDebut: row.dateDebut, dateFin: row.dateFin);
  }

  Contribution _contributionToDomain(ContributionRow row) {
    return Contribution(
      id: row.id,
      fideleId: row.fideleId,
      libelleDonateurAnonyme: row.libelleDonateurAnonyme,
      typeOffrandeId: row.typeOffrandeId,
      montant: row.montant,
      devise: row.devise,
      noeudId: row.noeudId,
      culteId: row.culteId,
      projetId: row.projetId,
      modePaiement: row.modePaiement,
      statut: StatutContribution.fromCode(row.statut),
      origine: OrigineContribution.fromCode(row.origine),
      dateSaisie: row.dateSaisie,
      valideParFideleId: row.valideParFideleId,
      dateValidation: row.dateValidation,
      motifRejet: row.motifRejet,
      contributionOrigineId: row.contributionOrigineId,
      estContrePassation: row.estContrePassation,
    );
  }

  Projet _projetToDomain(ProjetRow row) {
    return Projet(
      id: row.id,
      noeudId: row.noeudId,
      nom: row.nom,
      budgetPrevisionnel: row.budgetPrevisionnel,
      devise: row.devise,
      statut: StatutProjet.fromCode(row.statut),
    );
  }

  DepenseProjet _depenseToDomain(DepenseProjetRow row) {
    return DepenseProjet(
      id: row.id,
      projetId: row.projetId,
      montant: row.montant,
      libelle: row.libelle,
      date: row.date,
      valideParFideleId: row.valideParFideleId,
      derogationTracee: row.derogationTracee,
      motifDerogation: row.motifDerogation,
    );
  }

  Engagement _engagementToDomain(EngagementRow row) {
    return Engagement(
      id: row.id,
      fideleId: row.fideleId,
      type: TypeEngagement.fromCode(row.type),
      montantPrevu: row.montantPrevu,
      periodicite: PeriodiciteEngagement.fromCode(row.periodicite),
      dateDebut: row.dateDebut,
      statut: StatutEngagement.fromCode(row.statut),
    );
  }

  EcheanceEngagement _echeanceToDomain(EcheanceEngagementRow row) {
    return EcheanceEngagement(
      id: row.id,
      engagementId: row.engagementId,
      dateEcheance: row.dateEcheance,
      statut: StatutEcheance.fromCode(row.statut),
      contributionId: row.contributionId,
    );
  }
}
