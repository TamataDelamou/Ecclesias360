import 'package:drift/drift.dart';

import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/statut_referentiel.dart';
import '../domain/models/zone_geographique.dart';
import '../domain/rules/zone_geographique_rules.dart';

/// Dépôt Module XXIII — référentiel ZoneGeographique (RG-XXIII-01/03).
/// Pas de synchronisation distante pour cette première itération : les
/// référentiels de base sont créés localement, la propagation multi-nœuds
/// (RG-XXIII-01) suivra avec la synchronisation Supabase des autres
/// référentiels du module.
class ZoneGeographiqueRepository {
  ZoneGeographiqueRepository(this._db);

  final AppDatabase _db;

  Stream<List<ZoneGeographique>> watchAll() {
    return _db.select(_db.zonesGeographiques).watch().map(
          (rows) => rows.map(_toDomain).toList(growable: false),
        );
  }

  Future<ZoneGeographique?> findById(String id) async {
    final row =
        await (_db.select(_db.zonesGeographiques)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<ZoneGeographique> creer({required String libelle, String? parentId}) async {
    int? niveauParent;
    if (parentId != null) {
      final parent = await findById(parentId);
      if (parent == null) {
        throw ArgumentError('Zone géographique parente introuvable : $parentId');
      }
      niveauParent = parent.niveau;
    }

    final id = IdGenerator.newId();
    await _db.into(_db.zonesGeographiques).insert(
          ZonesGeographiquesCompanion.insert(
            id: id,
            libelle: libelle,
            niveau: ZoneGeographiqueRules.calculerNiveau(niveauParent: niveauParent),
            parentId: Value(parentId),
            statut: Value(StatutReferentiel.actif.code),
          ),
        );
    return (await findById(id))!;
  }

  /// RG-XXIII-03 — alternative non destructive à la suppression.
  Future<void> desactiver(String id) async {
    await (_db.update(_db.zonesGeographiques)..where((t) => t.id.equals(id))).write(
      ZonesGeographiquesCompanion(statut: Value(StatutReferentiel.desactive.code)),
    );
  }

  /// RG-XXIII-03 — refuse la suppression si la zone est référencée par un
  /// nœud organisationnel (Module I) ou une autre zone (sous-zone).
  Future<void> supprimer(String id) async {
    final noeudUtilisateur = await (_db.select(_db.organisationNodes)
          ..where((t) => t.zoneGeoId.equals(id))
          ..limit(1))
        .getSingleOrNull();
    final sousZone = await (_db.select(_db.zonesGeographiques)
          ..where((t) => t.parentId.equals(id))
          ..limit(1))
        .getSingleOrNull();

    final erreur = ZoneGeographiqueRules.raisonBlocageSuppression(
      estUtilisee: noeudUtilisateur != null || sousZone != null,
    );
    if (erreur != null) {
      throw erreur;
    }

    await (_db.delete(_db.zonesGeographiques)..where((t) => t.id.equals(id))).go();
  }

  ZoneGeographique _toDomain(ZoneGeographiqueRow row) {
    return ZoneGeographique(
      id: row.id,
      libelle: row.libelle,
      niveau: row.niveau,
      parentId: row.parentId,
      statut: StatutReferentiel.fromCode(row.statut),
    );
  }
}
