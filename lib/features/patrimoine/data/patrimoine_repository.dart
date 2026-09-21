import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/role.dart';
import '../domain/models/bien.dart';
import '../domain/models/campagne_inventaire.dart';
import '../domain/models/categorie_bien.dart';
import '../domain/models/etat_bien.dart';
import '../domain/models/mouvement_stock.dart';
import '../domain/models/objet_reservation.dart';
import '../domain/models/pointage_inventaire.dart';
import '../domain/models/reservation_bien.dart';
import '../domain/models/statut_campagne_inventaire.dart';
import '../domain/models/type_mouvement_stock.dart';
import '../domain/models/type_sortie_bien.dart';
import '../../comptabilite/data/comptabilite_repository.dart';
import '../domain/rules/patrimoine_rules.dart';

/// Dépôt Module XX — Biens / patrimoine (RG-XX-01 à 05). Synchronisation
/// distante différée pour ce module (même précédent documenté que les
/// modules précédents).
class PatrimoineRepository {
  PatrimoineRepository(this._db, {ComptabiliteRepository? comptabiliteRepository}) : _comptabilite = comptabiliteRepository;

  final AppDatabase _db;
  final ComptabiliteRepository? _comptabilite;

  // --- Catégories de biens (référentiel, RG-XX-01) ---------------------------

  Stream<List<CategorieBien>> watchCategoriesBien() {
    final query = _db.select(_db.categoriesBien)..orderBy([(t) => OrderingTerm.asc(t.libelle)]);
    return query.watch().map((rows) => rows.map(_categorieBienToDomain).toList(growable: false));
  }

  Future<CategorieBien> ajouterCategorieBien({required String code, required String libelle}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.categoriesBien).insert(CategoriesBienCompanion.insert(id: id, code: code, libelle: libelle));
    final row = await (_db.select(_db.categoriesBien)..where((t) => t.id.equals(id))).getSingle();
    return _categorieBienToDomain(row);
  }

  // --- Biens (RG-XX-01/02/05) --------------------------------------------------

  Stream<List<Bien>> watchBiens(String noeudId) {
    final query = _db.select(_db.biens)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.asc(t.designation)]);
    return query.watch().map((rows) => rows.map(_bienToDomain).toList(growable: false));
  }

  Future<Bien?> findBienById(String id) async {
    final row = await (_db.select(_db.biens)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _bienToDomain(row);
  }

  /// RG-XX-01 — chaque bien possède un identifiant d'inventaire unique.
  Future<Bien> ajouterBien({
    required String idInventaire,
    required String categorieId,
    required String noeudId,
    required String designation,
    required int valeurAcquisition,
    required int valeurVenale,
    required String devise,
    required DateTime dateAcquisition,
    int? seuilAlerteStock,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.biens).insert(
          BiensCompanion.insert(
            id: id,
            idInventaire: idInventaire,
            categorieId: categorieId,
            noeudId: noeudId,
            designation: designation,
            valeurAcquisition: valeurAcquisition,
            valeurVenale: valeurVenale,
            devise: devise,
            dateAcquisition: dateAcquisition,
            seuilAlerteStock: Value(seuilAlerteStock),
          ),
        );
    return (await findBienById(id))!;
  }

  /// Signalement d'état ou de panne (écran mobile 4) — ne crée pas de ligne
  /// d'historique dédiée, le Cahier ne définissant aucune entité porteuse
  /// pour ce signalement (seul le champ `etat` du bien est mis à jour).
  Future<Bien> signalerEtat({required String id, required EtatBien nouvelEtat}) async {
    await (_db.update(_db.biens)..where((t) => t.id.equals(id))).write(
      BiensCompanion(etat: Value(nouvelEtat.code)),
    );
    return (await findBienById(id))!;
  }

  /// RG-XX-02 — la sortie d'un bien (cession, don, mise au rebut) exige un
  /// rôle habilité. Si un `ComptabiliteRepository` est fourni (Module XXI),
  /// génère automatiquement l'écriture comptable miroir de la sortie
  /// (RG-XXI-02), même motif d'injection optionnelle qu'`ArchivageRepository`
  /// dans `ComiteRepository`/`DisciplineRepository`.
  Future<Bien> sortirBien({
    required String id,
    required Role roleActeur,
    required TypeSortieBien typeSortie,
    required String valideParFideleId,
    String? motif,
  }) async {
    final bien = await _findBienOrThrow(id);
    final erreur = PatrimoineRules.raisonBlocageSortieBien(
      roleActeur: roleActeur,
      dejaSorti: bien.etat == EtatBien.cede,
    );
    if (erreur != null) {
      throw erreur;
    }
    await (_db.update(_db.biens)..where((t) => t.id.equals(id))).write(
      BiensCompanion(
        etat: Value(EtatBien.cede.code),
        typeSortie: Value(typeSortie.code),
        dateSortie: Value(DateTime.now()),
        valideParFideleIdSortie: Value(valideParFideleId),
        motifSortie: Value(motif),
      ),
    );

    final comptabilite = _comptabilite;
    if (comptabilite != null) {
      await comptabilite.genererEcecturesSortieBien(
        bienId: id,
        valeurVenale: bien.valeurVenale,
        noeudId: bien.noeudId,
      );
    }
    return (await findBienById(id))!;
  }

  Future<Bien> _findBienOrThrow(String id) async {
    final bien = await findBienById(id);
    if (bien == null) {
      throw ArgumentError('Bien introuvable : $id');
    }
    return bien;
  }

  // --- Réservations (RG-XX-03) -------------------------------------------------

  Stream<List<ReservationBien>> watchReservations(String bienId) {
    final query = _db.select(_db.reservationsBien)
      ..where((t) => t.bienId.equals(bienId))
      ..orderBy([(t) => OrderingTerm.asc(t.dateDebut)]);
    return query.watch().map((rows) => rows.map(_reservationToDomain).toList(growable: false));
  }

  /// RG-XX-03 — empêche tout conflit de double réservation sur la même
  /// plage horaire pour ce bien.
  Future<ReservationBien> reserverBien({
    required String bienId,
    required ObjetReservation objetReservation,
    String? culteId,
    String? objetLibre,
    required DateTime dateDebut,
    required DateTime dateFin,
  }) async {
    final existantes = await (_db.select(_db.reservationsBien)..where((t) => t.bienId.equals(bienId))).get();
    final erreur = PatrimoineRules.raisonBlocageReservation(
      dateDebut: dateDebut,
      dateFin: dateFin,
      reservationsExistantes: [for (final r in existantes) (r.dateDebut, r.dateFin)],
    );
    if (erreur != null) {
      throw erreur;
    }

    final id = IdGenerator.newId();
    await _db.into(_db.reservationsBien).insert(
          ReservationsBienCompanion.insert(
            id: id,
            bienId: bienId,
            objetReservation: objetReservation.code,
            culteId: Value(culteId),
            objetLibre: Value(objetLibre),
            dateDebut: dateDebut,
            dateFin: dateFin,
          ),
        );
    final row = await (_db.select(_db.reservationsBien)..where((t) => t.id.equals(id))).getSingle();
    return _reservationToDomain(row);
  }

  // --- Mouvements de stock (RG-XX-05) -------------------------------------------

  Stream<List<MouvementStock>> watchMouvementsStock(String bienId) {
    final query = _db.select(_db.mouvementsStock)
      ..where((t) => t.bienId.equals(bienId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_mouvementStockToDomain).toList(growable: false));
  }

  Future<MouvementStock> enregistrerMouvementStock({
    required String bienId,
    required TypeMouvementStock type,
    required int quantite,
    String? motif,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.mouvementsStock).insert(
          MouvementsStockCompanion.insert(
            id: id,
            bienId: bienId,
            type: type.code,
            quantite: quantite,
            date: DateTime.now(),
            motif: Value(motif),
          ),
        );
    final row = await (_db.select(_db.mouvementsStock)..where((t) => t.id.equals(id))).getSingle();
    return _mouvementStockToDomain(row);
  }

  /// RG-XX-05 — quantité en stock recalculée à la lecture, jamais stockée.
  Future<int> quantiteStock(String bienId) async {
    final mouvements = await (_db.select(_db.mouvementsStock)..where((t) => t.bienId.equals(bienId))).get();
    final totalEntrees = mouvements
        .where((m) => m.type == TypeMouvementStock.entree.code)
        .fold<int>(0, (s, m) => s + m.quantite);
    final totalSorties = mouvements
        .where((m) => m.type == TypeMouvementStock.sortie.code)
        .fold<int>(0, (s, m) => s + m.quantite);
    return PatrimoineRules.calculerQuantiteStock(totalEntrees: totalEntrees, totalSorties: totalSorties);
  }

  /// RG-XX-05 — biens à gestion de stock actuellement sous leur seuil
  /// d'alerte de réapprovisionnement.
  Future<List<Bien>> biensSousSeuilAlerte(String noeudId) async {
    final rows = await (_db.select(_db.biens)
          ..where((t) => t.noeudId.equals(noeudId) & t.seuilAlerteStock.isNotNull()))
        .get();
    final resultat = <Bien>[];
    for (final row in rows) {
      final bien = _bienToDomain(row);
      final quantite = await quantiteStock(bien.id);
      if (PatrimoineRules.estSousSeuilAlerte(quantiteActuelle: quantite, seuilAlerte: bien.seuilAlerteStock)) {
        resultat.add(bien);
      }
    }
    return resultat;
  }

  // --- Campagnes d'inventaire et pointages (RG-XX-04) ---------------------------

  Stream<List<CampagneInventaire>> watchCampagnesInventaire(String noeudId) {
    final query = _db.select(_db.campagnesInventaire)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateDebut)]);
    return query.watch().map((rows) => rows.map(_campagneToDomain).toList(growable: false));
  }

  Future<CampagneInventaire?> findCampagneById(String id) async {
    final row = await (_db.select(_db.campagnesInventaire)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _campagneToDomain(row);
  }

  Future<CampagneInventaire> demarrerCampagne({required String noeudId, required String libelle}) async {
    final id = IdGenerator.newId();
    await _db.into(_db.campagnesInventaire).insert(
          CampagnesInventaireCompanion.insert(id: id, noeudId: noeudId, libelle: libelle, dateDebut: DateTime.now()),
        );
    return (await findCampagneById(id))!;
  }

  Stream<List<PointageInventaire>> watchPointages(String campagneId) {
    final query = _db.select(_db.pointagesInventaire)..where((t) => t.campagneId.equals(campagneId));
    return query.watch().map((rows) => rows.map(_pointageToDomain).toList(growable: false));
  }

  /// RG-XX-04 — compare l'état (et, pour un bien à gestion de stock, la
  /// quantité) déclaré au système avec le constat terrain, et signale
  /// l'écart pour investigation.
  Future<PointageInventaire> enregistrerPointage({
    required String campagneId,
    required String bienId,
    required EtatBien etatConstate,
    int? quantiteConstatee,
    String? commentaire,
  }) async {
    final campagne = await findCampagneById(campagneId);
    if (campagne == null) {
      throw ArgumentError('Campagne d\'inventaire introuvable : $campagneId');
    }
    if (campagne.statut == StatutCampagneInventaire.cloturee) {
      throw AppError.campagneInventaireDejaCloturee();
    }
    final bien = await _findBienOrThrow(bienId);
    final quantiteDeclaree = bien.seuilAlerteStock != null ? await quantiteStock(bienId) : null;
    final ecart = PatrimoineRules.detecterEcart(
      etatDeclare: bien.etat,
      etatConstate: etatConstate,
      quantiteDeclaree: quantiteDeclaree,
      quantiteConstatee: quantiteConstatee,
    );

    final id = IdGenerator.newId();
    await _db.into(_db.pointagesInventaire).insert(
          PointagesInventaireCompanion.insert(
            id: id,
            campagneId: campagneId,
            bienId: bienId,
            etatConstate: etatConstate.code,
            quantiteConstatee: Value(quantiteConstatee),
            ecartDetecte: Value(ecart),
            commentaire: Value(commentaire),
            dateDuPointage: DateTime.now(),
          ),
        );
    final row = await (_db.select(_db.pointagesInventaire)..where((t) => t.id.equals(id))).getSingle();
    return _pointageToDomain(row);
  }

  Future<void> cloturerCampagne(String id) async {
    await (_db.update(_db.campagnesInventaire)..where((t) => t.id.equals(id))).write(
      CampagnesInventaireCompanion(
        statut: Value(StatutCampagneInventaire.cloturee.code),
        dateCloture: Value(DateTime.now()),
      ),
    );
  }

  // --- Conversions --------------------------------------------------------------

  CategorieBien _categorieBienToDomain(CategorieBienRow row) {
    return CategorieBien(id: row.id, code: row.code, libelle: row.libelle, standard: row.standard, statut: row.statut);
  }

  Bien _bienToDomain(BienRow row) {
    return Bien(
      id: row.id,
      idInventaire: row.idInventaire,
      categorieId: row.categorieId,
      noeudId: row.noeudId,
      designation: row.designation,
      etat: EtatBien.fromCode(row.etat),
      valeurAcquisition: row.valeurAcquisition,
      valeurVenale: row.valeurVenale,
      devise: row.devise,
      dateAcquisition: row.dateAcquisition,
      seuilAlerteStock: row.seuilAlerteStock,
      typeSortie: row.typeSortie == null ? null : TypeSortieBien.fromCode(row.typeSortie!),
      dateSortie: row.dateSortie,
      valideParFideleIdSortie: row.valideParFideleIdSortie,
      motifSortie: row.motifSortie,
    );
  }

  ReservationBien _reservationToDomain(ReservationBienRow row) {
    return ReservationBien(
      id: row.id,
      bienId: row.bienId,
      objetReservation: ObjetReservation.fromCode(row.objetReservation),
      culteId: row.culteId,
      objetLibre: row.objetLibre,
      dateDebut: row.dateDebut,
      dateFin: row.dateFin,
    );
  }

  MouvementStock _mouvementStockToDomain(MouvementStockRow row) {
    return MouvementStock(
      id: row.id,
      bienId: row.bienId,
      type: TypeMouvementStock.fromCode(row.type),
      quantite: row.quantite,
      date: row.date,
      motif: row.motif,
    );
  }

  CampagneInventaire _campagneToDomain(CampagneInventaireRow row) {
    return CampagneInventaire(
      id: row.id,
      noeudId: row.noeudId,
      libelle: row.libelle,
      dateDebut: row.dateDebut,
      dateCloture: row.dateCloture,
      statut: StatutCampagneInventaire.fromCode(row.statut),
    );
  }

  PointageInventaire _pointageToDomain(PointageInventaireRow row) {
    return PointageInventaire(
      id: row.id,
      campagneId: row.campagneId,
      bienId: row.bienId,
      etatConstate: EtatBien.fromCode(row.etatConstate),
      quantiteConstatee: row.quantiteConstatee,
      ecartDetecte: row.ecartDetecte,
      commentaire: row.commentaire,
      dateDuPointage: row.dateDuPointage,
    );
  }
}
