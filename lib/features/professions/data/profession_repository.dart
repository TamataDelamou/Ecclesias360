import 'package:drift/drift.dart';

import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/statut_referentiel.dart';
import '../domain/models/profession.dart';
import '../domain/models/profession_fidele.dart';
import '../domain/models/sollicitation.dart';
import '../domain/models/statut_verification.dart';
import '../domain/rules/profession_rules.dart';

/// Dépôt Module V — référentiel de métiers (RG-V-02), déclarations
/// vérifiables (RG-V-01) et sollicitations de groupe (RG-V-03). Pas de
/// synchronisation distante pour cette première itération, même précédent
/// documenté que ZonesGeographiques/Ministere/DonSpirituel.
class ProfessionRepository {
  ProfessionRepository(this._db);

  final AppDatabase _db;

  // --- Référentiel de métiers (RG-V-02) -----------------------------------

  Stream<List<Profession>> watchProfessions() {
    return _db.select(_db.professions).watch().map(
          (rows) => rows.map(_professionToDomain).toList(growable: false),
        );
  }

  Future<Profession?> findProfessionById(String id) async {
    final row = await (_db.select(_db.professions)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _professionToDomain(row);
  }

  Future<Profession> creerProfession({
    required String code,
    required String categorie,
    required String libelle,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.professions).insert(
          ProfessionsCompanion.insert(id: id, code: code, categorie: categorie, libelle: libelle),
        );
    return (await findProfessionById(id))!;
  }

  Future<void> desactiverProfession(String id) async {
    await (_db.update(_db.professions)..where((t) => t.id.equals(id))).write(
      ProfessionsCompanion(statut: Value(StatutReferentiel.desactive.code)),
    );
  }

  /// RG-V-02 — refuse la suppression si des déclarations existent.
  Future<void> supprimerProfession(String id) async {
    final declaration = await (_db.select(_db.professionsFideles)
          ..where((t) => t.professionId.equals(id))
          ..limit(1))
        .getSingleOrNull();

    final erreur = ProfessionRules.raisonBlocageSuppression(estUtilisee: declaration != null);
    if (erreur != null) {
      throw erreur;
    }

    await (_db.delete(_db.professions)..where((t) => t.id.equals(id))).go();
  }

  // --- Déclarations (RG-V-01) ---------------------------------------------

  Stream<List<ProfessionFidele>> watchDeclarations(String fideleId) {
    final query = _db.select(_db.professionsFideles)..where((t) => t.fideleId.equals(fideleId));
    return query.watch().map((rows) => rows.map(_declarationToDomain).toList(growable: false));
  }

  Stream<List<ProfessionFidele>> watchDeclarationsParProfession(String professionId) {
    final query = _db.select(_db.professionsFideles)..where((t) => t.professionId.equals(professionId));
    return query.watch().map((rows) => rows.map(_declarationToDomain).toList(growable: false));
  }

  Future<ProfessionFidele> declarerProfession({
    required String fideleId,
    required String professionId,
    int? anneesExperience,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.professionsFideles).insert(
          ProfessionsFidelesCompanion.insert(
            id: id,
            fideleId: fideleId,
            professionId: professionId,
            statutVerification: Value(StatutVerification.declare.code),
            anneesExperience: Value(anneesExperience),
          ),
        );
    final row = await (_db.select(_db.professionsFideles)..where((t) => t.id.equals(id))).getSingle();
    return _declarationToDomain(row);
  }

  /// RG-V-01 — vérification par un responsable, jamais l'inverse.
  Future<void> verifierDeclaration(String id) async {
    final declaration =
        await (_db.select(_db.professionsFideles)..where((t) => t.id.equals(id))).getSingle();
    if (!ProfessionRules.peutVerifier(StatutVerification.fromCode(declaration.statutVerification))) {
      return;
    }
    await (_db.update(_db.professionsFideles)..where((t) => t.id.equals(id))).write(
      ProfessionsFidelesCompanion(statutVerification: Value(StatutVerification.verifie.code)),
    );
  }

  // --- Sollicitations (RG-V-03) -------------------------------------------

  Stream<List<Sollicitation>> watchSollicitations(String fideleId) {
    final query = _db.select(_db.sollicitations)
      ..where((t) => t.fideleId.equals(fideleId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map((rows) => rows.map(_sollicitationToDomain).toList(growable: false));
  }

  /// RG-V-03 — sollicite nommément chaque fidèle ayant une déclaration
  /// vérifiée du métier [professionId] ; une ligne par fidèle sollicité.
  Future<int> solliciterGroupe({required String professionId, required String objet}) async {
    final declarations = await (_db.select(_db.professionsFideles)
          ..where(
            (t) =>
                t.professionId.equals(professionId) &
                t.statutVerification.equals(StatutVerification.verifie.code),
          ))
        .get();

    final maintenant = DateTime.now();
    await _db.batch((b) {
      b.insertAll(
        _db.sollicitations,
        [
          for (final declaration in declarations)
            SollicitationsCompanion.insert(
              id: IdGenerator.newId(),
              fideleId: declaration.fideleId,
              objet: objet,
              date: maintenant,
            ),
        ],
      );
    });
    return declarations.length;
  }

  Future<void> repondreSollicitation(String id, String reponse) async {
    await (_db.update(_db.sollicitations)..where((t) => t.id.equals(id))).write(
      SollicitationsCompanion(reponse: Value(reponse)),
    );
  }

  Profession _professionToDomain(ProfessionRow row) {
    return Profession(
      id: row.id,
      code: row.code,
      categorie: row.categorie,
      libelle: row.libelle,
      statut: StatutReferentiel.fromCode(row.statut),
    );
  }

  ProfessionFidele _declarationToDomain(ProfessionFideleRow row) {
    return ProfessionFidele(
      id: row.id,
      fideleId: row.fideleId,
      professionId: row.professionId,
      statutVerification: StatutVerification.fromCode(row.statutVerification),
      anneesExperience: row.anneesExperience,
    );
  }

  Sollicitation _sollicitationToDomain(SollicitationRow row) {
    return Sollicitation(
      id: row.id,
      fideleId: row.fideleId,
      objet: row.objet,
      date: row.date,
      reponse: row.reponse,
    );
  }
}
