import 'package:drift/drift.dart';

import '../../../core/theme/app_defaults.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/role.dart';
import '../domain/models/budget.dart';
import '../domain/models/compte_comptable.dart';
import '../domain/models/ecriture_comptable.dart';
import '../domain/models/periode_comptable.dart';
import '../domain/models/statut_periode_comptable.dart';
import '../domain/models/type_compte.dart';
import '../domain/rules/comptabilite_rules.dart';

/// Dépôt Module XXI — Comptabilité (RG-XXI-01 à 06). Producteur consommé par
/// injection optionnelle dans `FinancesRepository` (RG-XI-02, validation
/// d'une contribution) et `PatrimoineRepository` (RG-XX-02, sortie d'un
/// bien) — même motif d'injection optionnelle qu'`ArchivageRepository` dans
/// `ComiteRepository`/`DisciplineRepository`. Synchronisation distante
/// différée pour ce module (même précédent documenté que les modules
/// précédents).
class ComptabiliteRepository {
  ComptabiliteRepository(this._db);

  final AppDatabase _db;

  // --- Plan comptable (référentiel, RG-XXI-01) --------------------------------

  Stream<List<CompteComptable>> watchPlanComptable() {
    final query = _db.select(_db.comptesComptables)..orderBy([(t) => OrderingTerm.asc(t.codeCompte)]);
    return query.watch().map((rows) => rows.map(_compteToDomain).toList(growable: false));
  }

  Future<CompteComptable?> trouverCompteParCode(String code) async {
    final row = await (_db.select(_db.comptesComptables)..where((t) => t.codeCompte.equals(code))).getSingleOrNull();
    return row == null ? null : _compteToDomain(row);
  }

  Future<CompteComptable> _trouverCompteOuThrow(String code) async {
    final compte = await trouverCompteParCode(code);
    if (compte == null) {
      throw StateError("Compte comptable '$code' introuvable — le plan comptable de départ n'a pas été seedé.");
    }
    return compte;
  }

  // --- Périodes comptables (RG-XXI-03) ----------------------------------------

  Stream<List<PeriodeComptable>> watchPeriodes() {
    final query = _db.select(_db.periodesComptables)..orderBy([(t) => OrderingTerm.desc(t.exercice)]);
    return query.watch().map((rows) => rows.map(_periodeToDomain).toList(growable: false));
  }

  /// Période comptable ouverte la plus récente : cible par défaut de toute
  /// nouvelle écriture (RG-XXI-02/03). Amorcée au premier lancement de
  /// l'application (voir `AppDatabase._seedPeriodeComptableCourante`).
  Future<PeriodeComptable> periodeCouranteOuverte() async {
    final row = await (_db.select(_db.periodesComptables)
          ..where((t) => t.statut.equals(StatutPeriodeComptable.ouverte.code))
          ..orderBy([(t) => OrderingTerm.desc(t.exercice)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) {
      throw StateError('Aucune période comptable ouverte : toutes les périodes sont clôturées.');
    }
    return _periodeToDomain(row);
  }

  /// RG-XXI-03 — clôture une période comptable : habilitée au rang pasteur
  /// (ou supérieur), même seuil que la validation comptable du Module XI.
  /// Une fois clôturée, la période devient immuable (voir
  /// `_enregistrerLignesDoublePartie`).
  Future<void> cloturerPeriode({required String id, required Role roleActeur}) async {
    final erreur = ComptabiliteRules.raisonBlocageClotureComptable(roleActeur: roleActeur);
    if (erreur != null) {
      throw erreur;
    }
    await (_db.update(_db.periodesComptables)..where((t) => t.id.equals(id)))
        .write(PeriodesComptablesCompanion(statut: Value(StatutPeriodeComptable.cloturee.code)));
  }

  // --- Écritures comptables (RG-XXI-01/02/03) ---------------------------------

  Stream<List<EcritureComptable>> watchEcritures(String noeudId) {
    final query = _db.select(_db.ecrituresComptables)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_ecritureToDomain).toList(growable: false));
  }

  /// RG-XXI-01/03 — génère les deux lignes équilibrées (débit + crédit)
  /// d'une opération comptable ; bloque toute écriture sur une période déjà
  /// clôturée (RG-XXI-03 — la correction se fait par une nouvelle écriture
  /// dans la période courante, jamais par réouverture).
  Future<void> _enregistrerLignesDoublePartie({
    required String compteDebitId,
    required String compteCreditId,
    required int montant,
    required String noeudId,
    required String periodeId,
    String? pieceJustificativeId,
    String? libelle,
  }) async {
    final periodeRow = await (_db.select(_db.periodesComptables)..where((t) => t.id.equals(periodeId))).getSingle();
    final erreur = ComptabiliteRules.raisonBlocageEcritureSurPeriode(
      statutPeriode: StatutPeriodeComptable.fromCode(periodeRow.statut),
    );
    if (erreur != null) {
      throw erreur;
    }

    final maintenant = DateTime.now();
    await _db.batch((b) {
      b.insertAll(_db.ecrituresComptables, [
        EcrituresComptablesCompanion.insert(
          id: IdGenerator.newId(),
          date: maintenant,
          compteId: compteDebitId,
          debit: Value(montant),
          noeudId: noeudId,
          pieceJustificativeId: Value(pieceJustificativeId),
          periodeId: periodeId,
          libelle: Value(libelle),
        ),
        EcrituresComptablesCompanion.insert(
          id: IdGenerator.newId(),
          date: maintenant,
          compteId: compteCreditId,
          credit: Value(montant),
          noeudId: noeudId,
          pieceJustificativeId: Value(pieceJustificativeId),
          periodeId: periodeId,
          libelle: Value(libelle),
        ),
      ]);
    });
  }

  /// RG-XXI-02 — appelé par `FinancesRepository.validerContribution` (et par
  /// `contrePasserContribution`, RG-XI-05, dont le montant peut être négatif
  /// — la contre-passation inverse alors débit et crédit) : génère
  /// automatiquement l'écriture miroir d'une contribution validée, sans
  /// ressaisie manuelle (débit caisse / crédit produits des contributions).
  Future<void> genererEcecturesContributionValidee({
    required String contributionId,
    required int montant,
    required String noeudId,
  }) async {
    final compteCaisse = await _trouverCompteOuThrow('530000');
    final compteProduits = await _trouverCompteOuThrow('706000');
    final periode = await periodeCouranteOuverte();
    final estContrePassation = montant < 0;
    await _enregistrerLignesDoublePartie(
      compteDebitId: estContrePassation ? compteProduits.id : compteCaisse.id,
      compteCreditId: estContrePassation ? compteCaisse.id : compteProduits.id,
      montant: montant.abs(),
      noeudId: noeudId,
      periodeId: periode.id,
      pieceJustificativeId: contributionId,
      libelle: estContrePassation ? 'Contre-passation de contribution' : 'Contribution validée',
    );
  }

  /// RG-XXI-02 — appelé par `PatrimoineRepository.sortirBien` : génère
  /// automatiquement l'écriture miroir de la sortie définitive d'un bien du
  /// patrimoine (débit charges de sortie / crédit immobilisations), sans
  /// ressaisie manuelle. Les mouvements de stock (RG-XX-05) ne portent aucun
  /// champ monétaire dans le modèle du Cahier et ne génèrent donc aucune
  /// écriture — simplification délibérée, documentée dans AGENTS.md.
  Future<void> genererEcecturesSortieBien({
    required String bienId,
    required int valeurVenale,
    required String noeudId,
  }) async {
    final compteDebit = await _trouverCompteOuThrow('675000');
    final compteCredit = await _trouverCompteOuThrow('211000');
    final periode = await periodeCouranteOuverte();
    await _enregistrerLignesDoublePartie(
      compteDebitId: compteDebit.id,
      compteCreditId: compteCredit.id,
      montant: valeurVenale,
      noeudId: noeudId,
      periodeId: periode.id,
      pieceJustificativeId: bienId,
      libelle: 'Sortie de bien du patrimoine',
    );
  }

  // --- Soldes et consolidation (RG-XXI-01/06) ---------------------------------

  /// RG-XXI-06 — solde consolidé d'un compte pour un nœud : quand
  /// `inclureDescendants` est vrai, agrège le nœud et tous ses descendants
  /// (chemin matérialisé `path`, même motif que
  /// `OrganisationNodeRepository.deplacerNoeud`), jamais un double comptage
  /// puisque chaque écriture n'est imputée qu'à un seul nœud.
  Future<int> soldeCompte({
    required String noeudId,
    required String compteId,
    bool inclureDescendants = false,
  }) async {
    List<String> noeudIds;
    if (inclureDescendants) {
      final noeud = await (_db.select(_db.organisationNodes)..where((t) => t.id.equals(noeudId))).getSingle();
      final descendants = await (_db.select(_db.organisationNodes)..where((t) => t.path.like('${noeud.path}%'))).get();
      noeudIds = descendants.map((d) => d.id).toList();
    } else {
      noeudIds = [noeudId];
    }

    final compteRow = await (_db.select(_db.comptesComptables)..where((t) => t.id.equals(compteId))).getSingle();
    final lignes = await (_db.select(_db.ecrituresComptables)
          ..where((t) => t.compteId.equals(compteId) & t.noeudId.isIn(noeudIds)))
        .get();
    final totalDebit = lignes.fold<int>(0, (somme, l) => somme + l.debit);
    final totalCredit = lignes.fold<int>(0, (somme, l) => somme + l.credit);
    return ComptabiliteRules.calculerSoldeCompte(
      type: TypeCompte.fromCode(compteRow.type),
      totalDebit: totalDebit,
      totalCredit: totalCredit,
    );
  }

  /// Écran mobile 1 du Cahier — solde du jour du compte caisse d'un nœud.
  Future<int> soldeCaisseDuJour(String noeudId) async {
    final compteCaisse = await _trouverCompteOuThrow('530000');
    return soldeCompte(noeudId: noeudId, compteId: compteCaisse.id);
  }

  /// Écran mobile 3 du Cahier — rapport financier rapide : total des
  /// produits (crédit) et des charges (débit) d'un nœud pour la période
  /// donnée.
  Future<({int recettes, int depenses})> rapportFinancierRapide({
    required String noeudId,
    required String periodeId,
  }) async {
    final comptes = await (_db.select(_db.comptesComptables)).get();
    final comptesParId = {for (final c in comptes) c.id: c};
    final lignes = await (_db.select(_db.ecrituresComptables)
          ..where((t) => t.noeudId.equals(noeudId) & t.periodeId.equals(periodeId)))
        .get();

    var recettes = 0;
    var depenses = 0;
    for (final ligne in lignes) {
      final type = TypeCompte.fromCode(comptesParId[ligne.compteId]!.type);
      if (type == TypeCompte.produit) recettes += ligne.credit;
      if (type == TypeCompte.charge) depenses += ligne.debit;
    }
    return (recettes: recettes, depenses: depenses);
  }

  // --- Budgets (RG-XXI-04) ------------------------------------------------------

  Stream<List<Budget>> watchBudgets({required String noeudId, required String periodeId}) {
    final query = _db.select(_db.budgets)
      ..where((t) => t.noeudId.equals(noeudId) & t.periodeId.equals(periodeId));
    return query.watch().map((rows) => rows.map(_budgetToDomain).toList(growable: false));
  }

  Future<Budget> definirBudget({
    required String noeudId,
    required String periodeId,
    required String compteId,
    required int montantPrevu,
    int? seuilAlertePourcentage,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.budgets).insert(
          BudgetsCompanion.insert(
            id: id,
            noeudId: noeudId,
            periodeId: periodeId,
            compteId: compteId,
            montantPrevu: montantPrevu,
            seuilAlertePourcentage: Value(seuilAlertePourcentage),
          ),
        );
    final row = await (_db.select(_db.budgets)..where((t) => t.id.equals(id))).getSingle();
    return _budgetToDomain(row);
  }

  /// RG-XXI-04 — dépassement du seuil d'alerte budgétaire : le montant déjà
  /// engagé (charges débitées sur le compte) atteint le pourcentage
  /// paramétrable (`Budget.seuilAlertePourcentage`, ou la valeur par défaut)
  /// du montant prévu.
  Future<bool> budgetDepasse(Budget budget) async {
    final montantEngage = await soldeCompte(noeudId: budget.noeudId, compteId: budget.compteId);
    return ComptabiliteRules.depassementSeuilBudget(
      montantEngage: montantEngage,
      montantPrevu: budget.montantPrevu,
      seuilAlertePourcentage:
          budget.seuilAlertePourcentage ?? AppDefaults.comptabiliteSeuilAlerteDepassementPourcentageParDefaut,
    );
  }

  // --- Rapprochement bancaire (RG-XXI-05) ---------------------------------------

  Future<void> marquerRapprochees(List<String> ecritureIds) async {
    await (_db.update(_db.ecrituresComptables)..where((t) => t.id.isIn(ecritureIds)))
        .write(const EcrituresComptablesCompanion(rapproche: Value(true)));
  }

  /// RG-XXI-05 — écart de rapprochement bancaire entre le solde système et
  /// le solde du relevé bancaire saisi manuellement, signalé s'il subsiste
  /// après rapprochement automatique.
  Future<int> ecartRapprochement({required String noeudId, required String compteId, required int soldeReleve}) async {
    final soldeSysteme = await soldeCompte(noeudId: noeudId, compteId: compteId);
    return ComptabiliteRules.ecartRapprochement(soldeSysteme: soldeSysteme, soldeReleve: soldeReleve);
  }

  // --- Conversions ---------------------------------------------------------------

  CompteComptable _compteToDomain(CompteComptableRow row) => CompteComptable(
        id: row.id,
        codeCompte: row.codeCompte,
        libelle: row.libelle,
        type: TypeCompte.fromCode(row.type),
        statut: row.statut,
      );

  PeriodeComptable _periodeToDomain(PeriodeComptableRow row) => PeriodeComptable(
        id: row.id,
        exercice: row.exercice,
        dateDebut: row.dateDebut,
        dateFin: row.dateFin,
        statut: StatutPeriodeComptable.fromCode(row.statut),
      );

  EcritureComptable _ecritureToDomain(EcritureComptableRow row) => EcritureComptable(
        id: row.id,
        date: row.date,
        compteId: row.compteId,
        debit: row.debit,
        credit: row.credit,
        noeudId: row.noeudId,
        pieceJustificativeId: row.pieceJustificativeId,
        periodeId: row.periodeId,
        libelle: row.libelle,
        rapproche: row.rapproche,
      );

  Budget _budgetToDomain(BudgetRow row) => Budget(
        id: row.id,
        noeudId: row.noeudId,
        periodeId: row.periodeId,
        compteId: row.compteId,
        montantPrevu: row.montantPrevu,
        seuilAlertePourcentage: row.seuilAlertePourcentage,
      );
}
