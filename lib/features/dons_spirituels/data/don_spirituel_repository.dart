import 'package:drift/drift.dart';

import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/don_fidele.dart';
import '../domain/models/don_ministere_compatible.dart';
import '../domain/models/don_spirituel.dart';
import '../domain/models/niveau_maturite.dart';

/// Dépôt Module IV — référentiel fixe des dons (RG-IV-04), évaluations
/// append-only (RG-IV-01/02) et correspondances de suggestion (RG-IV-03).
/// Pas de synchronisation distante pour cette première itération, même
/// précédent documenté que ZonesGeographiques et Ministere-lié (Module III).
class DonSpirituelRepository {
  DonSpirituelRepository(this._db);

  final AppDatabase _db;

  // --- Référentiel des dons (RG-IV-04) -----------------------------------

  Stream<List<DonSpirituel>> watchDons() {
    return _db.select(_db.donsSpirituels).watch().map(
          (rows) => rows.map(_donToDomain).toList(growable: false),
        );
  }

  Future<DonSpirituel?> findDonById(String id) async {
    final row = await (_db.select(_db.donsSpirituels)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _donToDomain(row);
  }

  // --- Évaluations (RG-IV-01/02) ------------------------------------------

  /// Toutes les évaluations d'un fidèle (tous dons confondus), les plus
  /// récentes en premier — l'appelant filtre par don si besoin.
  Stream<List<DonFidele>> watchEvaluations(String fideleId) {
    final query = _db.select(_db.donsFideles)
      ..where((t) => t.fideleId.equals(fideleId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateEvaluation)]);
    return query.watch().map((rows) => rows.map(_evaluationToDomain).toList(growable: false));
  }

  /// RG-IV-02 — ajoute une nouvelle évaluation, ne modifie jamais une ligne
  /// existante.
  Future<DonFidele> evaluer({
    required String fideleId,
    required String donId,
    required NiveauMaturite niveauMaturite,
    required String responsableSuiviId,
    String? observations,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.donsFideles).insert(
          DonsFidelesCompanion.insert(
            id: id,
            fideleId: fideleId,
            donId: donId,
            niveauMaturite: niveauMaturite.code,
            responsableSuiviId: responsableSuiviId,
            dateEvaluation: DateTime.now(),
            observations: Value(observations),
          ),
        );
    final row = await (_db.select(_db.donsFideles)..where((t) => t.id.equals(id))).getSingle();
    return _evaluationToDomain(row);
  }

  // --- Correspondances de suggestion (RG-IV-03) ----------------------------

  Stream<List<DonMinistereCompatible>> watchCorrespondances(String donId) {
    final query = _db.select(_db.donsMinisteresCompatibles)..where((t) => t.donId.equals(donId));
    return query.watch().map((rows) => rows.map(_correspondanceToDomain).toList(growable: false));
  }

  /// Alimente la table de correspondance. Aucune paire n'est pré-remplie ;
  /// non exposée depuis l'UI actuelle (administration future, Module
  /// XXIII), mais fonctionnelle dès cette itération.
  Future<DonMinistereCompatible> ajouterCorrespondance({
    required String donId,
    required String typeMinistereId,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.donsMinisteresCompatibles).insert(
          DonsMinisteresCompatiblesCompanion.insert(
            id: id,
            donId: donId,
            typeMinistereId: typeMinistereId,
          ),
        );
    final row =
        await (_db.select(_db.donsMinisteresCompatibles)..where((t) => t.id.equals(id))).getSingle();
    return _correspondanceToDomain(row);
  }

  DonSpirituel _donToDomain(DonSpirituelRow row) {
    return DonSpirituel(
      id: row.id,
      code: row.code,
      libelle: row.libelle,
      descriptionBiblique: row.descriptionBiblique,
    );
  }

  DonFidele _evaluationToDomain(DonFideleRow row) {
    return DonFidele(
      id: row.id,
      fideleId: row.fideleId,
      donId: row.donId,
      niveauMaturite: NiveauMaturite.fromCode(row.niveauMaturite),
      responsableSuiviId: row.responsableSuiviId,
      dateEvaluation: row.dateEvaluation,
      observations: row.observations,
    );
  }

  DonMinistereCompatible _correspondanceToDomain(DonMinistereCompatibleRow row) {
    return DonMinistereCompatible(id: row.id, donId: row.donId, typeMinistereId: row.typeMinistereId);
  }
}
