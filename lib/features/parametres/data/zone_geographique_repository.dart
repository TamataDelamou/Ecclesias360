import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/entree_journal_parametres.dart';
import '../domain/models/statut_referentiel.dart';
import '../domain/models/zone_geographique.dart';
import '../domain/rules/parametres_rules.dart';
import '../domain/rules/zone_geographique_rules.dart';

/// Dépôt Module XXIII — référentiel ZoneGeographique (RG-XXIII-01/03/06).
/// Pas de synchronisation distante pour cette première itération : les
/// référentiels de base sont créés localement, la propagation multi-nœuds
/// (RG-XXIII-01) suivra avec la synchronisation Supabase des autres
/// référentiels du module.
///
/// RG-XXIII-06 — toute modification est réservée à un administrateur
/// (vérifié ici, pas seulement par l'écran) et historisée dans
/// `journal_parametres`, dans la même transaction : une modification sans
/// trace n'existe pas.
class ZoneGeographiqueRepository {
  ZoneGeographiqueRepository(this._db);

  static const referentiel = 'zones_geographiques';

  final AppDatabase _db;

  Stream<List<ZoneGeographique>> watchAll() {
    return _db.select(_db.zonesGeographiques).watch().map((rows) => rows.map(_toDomain).toList(growable: false));
  }

  Future<ZoneGeographique?> findById(String id) async {
    final row = await (_db.select(_db.zonesGeographiques)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<ZoneGeographique> creer({required String libelle, String? parentId, required Acteur acteur}) async {
    _verifierHabilitation(acteur);
    int? niveauParent;
    if (parentId != null) {
      final parent = await findById(parentId);
      if (parent == null) {
        throw ArgumentError('Zone géographique parente introuvable : $parentId');
      }
      niveauParent = parent.niveau;
    }

    final id = IdGenerator.newId();
    await _db.transaction(() async {
      await _db
          .into(_db.zonesGeographiques)
          .insert(
            ZonesGeographiquesCompanion.insert(
              id: id,
              libelle: libelle,
              niveau: ZoneGeographiqueRules.calculerNiveau(niveauParent: niveauParent),
              parentId: Value(parentId),
              statut: Value(StatutReferentiel.actif.code),
            ),
          );
      await _journaliser(id: id, action: ActionJournalParametres.creation, avant: null, acteur: acteur);
    });
    return (await findById(id))!;
  }

  /// RG-XXIII-03 — alternative non destructive à la suppression.
  Future<void> desactiver(String id, {required Acteur acteur}) async {
    _verifierHabilitation(acteur);
    await _db.transaction(() async {
      final avant = await _instantane(id);
      await (_db.update(_db.zonesGeographiques)..where((t) => t.id.equals(id))).write(
        ZonesGeographiquesCompanion(statut: Value(StatutReferentiel.desactive.code)),
      );
      await _journaliser(id: id, action: ActionJournalParametres.modification, avant: avant, acteur: acteur);
    });
  }

  /// RG-XXIII-03 — refuse la suppression si la zone est référencée par un
  /// nœud organisationnel (Module I) ou une autre zone (sous-zone).
  Future<void> supprimer(String id, {required Acteur acteur}) async {
    _verifierHabilitation(acteur);
    final noeudUtilisateur =
        await (_db.select(_db.organisationNodes)
              ..where((t) => t.zoneGeoId.equals(id))
              ..limit(1))
            .getSingleOrNull();
    final sousZone =
        await (_db.select(_db.zonesGeographiques)
              ..where((t) => t.parentId.equals(id))
              ..limit(1))
            .getSingleOrNull();

    final erreur = ZoneGeographiqueRules.raisonBlocageSuppression(
      estUtilisee: noeudUtilisateur != null || sousZone != null,
    );
    if (erreur != null) {
      throw erreur;
    }

    await _db.transaction(() async {
      final avant = await _instantane(id);
      await (_db.delete(_db.zonesGeographiques)..where((t) => t.id.equals(id))).go();
      await _journaliser(id: id, action: ActionJournalParametres.suppression, avant: avant, acteur: acteur);
    });
  }

  void _verifierHabilitation(Acteur acteur) {
    final refus = ParametresRules.raisonBlocageAdministration(roleActeur: acteur.role);
    if (refus != null) throw refus;
  }

  /// Instantané JSON de la zone, mêmes clés que les colonnes serveur
  /// (`to_jsonb` du déclencheur de 0024).
  Future<String?> _instantane(String id) async {
    final row = await (_db.select(_db.zonesGeographiques)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return jsonEncode({
      'id': row.id,
      'libelle': row.libelle,
      'niveau': row.niveau,
      'parent_id': row.parentId,
      'statut': row.statut,
    });
  }

  Future<void> _journaliser({
    required String id,
    required ActionJournalParametres action,
    required String? avant,
    required Acteur acteur,
  }) async {
    final apres = action == ActionJournalParametres.suppression ? null : await _instantane(id);
    await _db
        .into(_db.journalParametres)
        .insert(
          JournalParametresCompanion.insert(
            id: IdGenerator.newId(),
            referentiel: referentiel,
            objetId: id,
            action: action.code,
            ancienneValeur: Value(avant),
            nouvelleValeur: Value(apres),
            auteurAuthUserId: acteur.authUserId,
            auteurFideleId: Value(acteur.fideleId),
            date: DateTime.now(),
          ),
        );
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
