import 'package:drift/drift.dart';

import '../../../core/utils/id_generator.dart';
import '../../fideles/domain/models/fidele.dart';
import '../../fideles/domain/models/sexe.dart';
import '../../fideles/domain/models/statut_civil.dart';
import '../../fideles/domain/models/statut_fidele.dart';
import '../../fideles/domain/models/statut_spirituel.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/appartenance_groupe.dart';
import '../domain/models/criteres_groupe.dart';
import '../domain/models/groupe_eglise.dart';
import '../domain/models/origine_appartenance.dart';
import '../domain/models/type_regle_groupe.dart';
import '../domain/rules/groupe_rules.dart';

/// Dépôt Module VI — groupes de l'Église (RG-VI-01/02/03). Pas de
/// synchronisation distante pour cette première itération, même précédent
/// documenté que ZonesGeographiques/Ministere/DonSpirituel/Profession.
class GroupeRepository {
  GroupeRepository(this._db);

  final AppDatabase _db;

  Stream<List<GroupeEglise>> watchGroupes() {
    return _db.select(_db.groupesEglise).watch().map(
          (rows) => rows.map(_groupeToDomain).toList(growable: false),
        );
  }

  Future<GroupeEglise?> findGroupeById(String id) async {
    final row = await (_db.select(_db.groupesEglise)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _groupeToDomain(row);
  }

  /// RG-VI-03 — expose l'appartenance par identifiant de fidèle uniquement,
  /// jamais les champs personnels du fidèle lui-même.
  Stream<List<AppartenanceGroupe>> watchAppartenances(String fideleId) {
    final query = _db.select(_db.appartenancesGroupe)..where((t) => t.fideleId.equals(fideleId));
    return query.watch().map((rows) => rows.map(_appartenanceToDomain).toList(growable: false));
  }

  Stream<List<AppartenanceGroupe>> watchMembres(String groupeId) {
    final query = _db.select(_db.appartenancesGroupe)..where((t) => t.groupeId.equals(groupeId));
    return query.watch().map((rows) => rows.map(_appartenanceToDomain).toList(growable: false));
  }

  /// RG-VI-01 — recalcule les appartenances automatiques d'un groupe :
  /// ajoute les fidèles nouvellement éligibles, retire les lignes
  /// d'origine `auto` qui ne correspondent plus, ne touche jamais aux
  /// lignes `manuel` (dérogations tracées).
  Future<void> recalculerAppartenancesAuto(String groupeId) async {
    final groupe = await (_db.select(_db.groupesEglise)..where((t) => t.id.equals(groupeId))).getSingle();
    if (TypeRegleGroupe.fromCode(groupe.typeRegle) != TypeRegleGroupe.auto || groupe.criteresJson == null) {
      return;
    }
    final criteres = CriteresGroupe.fromJson(groupe.criteresJson!);
    final maintenant = DateTime.now();

    final tousLesFideles = await _db.select(_db.fideles).get();
    final appartenancesExistantes = await (_db.select(_db.appartenancesGroupe)
          ..where((t) => t.groupeId.equals(groupeId)))
        .get();
    final parFidele = {for (final a in appartenancesExistantes) a.fideleId: a};

    for (final row in tousLesFideles) {
      final fidele = _fideleRowToDomain(row);
      final correspond = GroupeRules.correspond(fidele, criteres, maintenant: maintenant);
      final existante = parFidele[fidele.id];

      if (correspond && existante == null) {
        await _db.into(_db.appartenancesGroupe).insert(
              AppartenancesGroupeCompanion.insert(
                id: IdGenerator.newId(),
                fideleId: fidele.id,
                groupeId: groupeId,
                dateAffectation: maintenant,
                origine: OrigineAppartenance.auto.code,
              ),
            );
      } else if (!correspond &&
          existante != null &&
          existante.origine == OrigineAppartenance.auto.code) {
        await (_db.delete(_db.appartenancesGroupe)..where((t) => t.id.equals(existante.id))).go();
      }
    }
  }

  /// RG-VI-01 — affectation manuelle ; exige un motif de dérogation si le
  /// groupe est automatique et que le fidèle ne correspond pas à ses
  /// critères (priorité à la règle automatique, sauf dérogation tracée).
  Future<AppartenanceGroupe> affecterManuellement({
    required String fideleId,
    required String groupeId,
    String? motifDerogation,
  }) async {
    final groupe = await (_db.select(_db.groupesEglise)..where((t) => t.id.equals(groupeId))).getSingle();
    final typeRegle = TypeRegleGroupe.fromCode(groupe.typeRegle);

    bool correspondAuxCriteres = true;
    if (typeRegle == TypeRegleGroupe.auto && groupe.criteresJson != null) {
      final fideleRow = await (_db.select(_db.fideles)..where((t) => t.id.equals(fideleId))).getSingle();
      correspondAuxCriteres = GroupeRules.correspond(
        _fideleRowToDomain(fideleRow),
        CriteresGroupe.fromJson(groupe.criteresJson!),
        maintenant: DateTime.now(),
      );
    }

    final erreur = GroupeRules.raisonBlocageAffectationManuelle(
      typeRegle: typeRegle,
      correspondAuxCriteres: correspondAuxCriteres,
      aMotifDerogation: motifDerogation != null && motifDerogation.trim().isNotEmpty,
    );
    if (erreur != null) {
      throw erreur;
    }

    final existante = await (_db.select(_db.appartenancesGroupe)
          ..where((t) => t.fideleId.equals(fideleId) & t.groupeId.equals(groupeId)))
        .getSingleOrNull();
    if (existante != null) {
      return _appartenanceToDomain(existante);
    }

    final id = IdGenerator.newId();
    await _db.into(_db.appartenancesGroupe).insert(
          AppartenancesGroupeCompanion.insert(
            id: id,
            fideleId: fideleId,
            groupeId: groupeId,
            dateAffectation: DateTime.now(),
            origine: OrigineAppartenance.manuel.code,
            motifDerogation: Value(motifDerogation),
          ),
        );
    final row = await (_db.select(_db.appartenancesGroupe)..where((t) => t.id.equals(id))).getSingle();
    return _appartenanceToDomain(row);
  }

  Future<void> retirerAppartenance(String id) async {
    await (_db.delete(_db.appartenancesGroupe)..where((t) => t.id.equals(id))).go();
  }

  GroupeEglise _groupeToDomain(GroupeEgliseRow row) {
    return GroupeEglise(
      id: row.id,
      code: row.code,
      libelle: row.libelle,
      typeRegle: TypeRegleGroupe.fromCode(row.typeRegle),
      criteres: row.criteresJson == null ? null : CriteresGroupe.fromJson(row.criteresJson!),
    );
  }

  AppartenanceGroupe _appartenanceToDomain(AppartenanceGroupeRow row) {
    return AppartenanceGroupe(
      id: row.id,
      fideleId: row.fideleId,
      groupeId: row.groupeId,
      dateAffectation: row.dateAffectation,
      origine: OrigineAppartenance.fromCode(row.origine),
      motifDerogation: row.motifDerogation,
    );
  }

  Fidele _fideleRowToDomain(FideleRow row) {
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
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
