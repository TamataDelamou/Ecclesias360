import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/theme/app_defaults.dart';
import '../../../core/utils/id_generator.dart';
import '../../archivage/data/archivage_repository.dart';
import '../../fideles/data/fidele_repository.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/cote.dart';
import '../domain/models/lettre_recommandation.dart';
import '../domain/models/mutation.dart';
import '../domain/models/statut_mutation.dart';
import '../domain/rules/deplacement_rules.dart';

/// Dépôt Module IX — Déplacements (RG-IX-01 à 04). Le changement de
/// rattachement effectif du fidèle passe par `FideleRepository.changerNoeud`
/// (dépendance requise, cœur de la règle RG-IX-01), tandis que l'archivage
/// de la lettre de recommandation (RG-IX-02) est une greffe transversale
/// optionnelle — même pattern d'injection que `ComiteRepository` vers le
/// Module VIII (voir AGENTS.md §11/§7).
class DeplacementRepository {
  DeplacementRepository(
    this._db,
    this._fideleRepository, {
    ArchivageRepository? archivageRepository,
  }) : _archivage = archivageRepository;

  final AppDatabase _db;
  final FideleRepository _fideleRepository;
  final ArchivageRepository? _archivage;

  /// RG-IX-01/04 — la mutation démarre `enAttente` : aucune statistique de
  /// consolidation n'est affectée tant qu'elle n'est pas validée.
  Future<Mutation> demanderMutation({
    required String fideleId,
    required String noeudOrigineId,
    required String noeudDestinationId,
    required String motif,
  }) async {
    if (noeudOrigineId == noeudDestinationId) {
      throw AppError.noeudOrigineEtDestinationIdentiques();
    }

    final id = IdGenerator.newId();
    final maintenant = DateTime.now();

    await _db.into(_db.mutations).insert(
          MutationsCompanion.insert(
            id: id,
            fideleId: fideleId,
            noeudOrigineId: noeudOrigineId,
            noeudDestinationId: noeudDestinationId,
            motif: motif,
            dateDemande: maintenant,
          ),
        );

    return _findByIdOrThrow(id);
  }

  /// RG-IX-01 — enregistre la validation pastorale d'un des deux côtés ; si
  /// la mutation devient validée (`DeplacementRules.estValidee`), le
  /// rattachement effectif du fidèle change (RG-IX-03, historisé) et la
  /// lettre de recommandation est archivée (RG-IX-02, si `archivageRepository`
  /// est fourni — échec d'archivage non bloquant, même précédent que le
  /// procès-verbal de comité).
  Future<Mutation> validerCote({
    required String mutationId,
    required Cote cote,
    bool validationUnilateraleAutorisee = AppDefaults.deplacementValidationUnilateraleAutorisee,
  }) async {
    final mutation = await _findByIdOrThrow(mutationId);
    if (mutation.statut != StatutMutation.enAttente) {
      throw AppError.mutationNonEnAttente();
    }

    final valideeParOrigine = cote == Cote.origine ? true : mutation.valideeParOrigine;
    final valideeParDestination = cote == Cote.destination ? true : mutation.valideeParDestination;

    final estValidee = DeplacementRules.estValidee(
      valideeParOrigine: valideeParOrigine,
      valideeParDestination: valideeParDestination,
      validationUnilateraleAutorisee: validationUnilateraleAutorisee,
    );

    final maintenant = DateTime.now();
    await (_db.update(_db.mutations)..where((t) => t.id.equals(mutationId))).write(
      MutationsCompanion(
        valideeParOrigine: Value(valideeParOrigine),
        valideeParDestination: Value(valideeParDestination),
        statut: Value(estValidee ? StatutMutation.validee.code : StatutMutation.enAttente.code),
        dateValidation: estValidee ? Value(maintenant) : const Value.absent(),
      ),
    );

    if (estValidee) {
      await _fideleRepository.changerNoeud(
        fideleId: mutation.fideleId,
        nouveauNoeudId: mutation.noeudDestinationId,
      );

      if (_archivage != null) {
        try {
          final document = await _archivage.archiver(
            typeDocument: 'lettre_recommandation',
            moduleOrigine: 'deplacements',
            objetIdOrigine: mutationId,
            noeudId: mutation.noeudDestinationId,
            fichier: 'Lettre de recommandation — mutation $mutationId (${mutation.motif})',
          );
          await _db.into(_db.lettresRecommandation).insert(
                LettresRecommandationCompanion.insert(
                  id: IdGenerator.newId(),
                  mutationId: mutationId,
                  documentArchiveId: document.id,
                ),
              );
        } on AppError {
          // Archivage non bloquant : la mutation reste validée même si la
          // nomenclature de la lettre de recommandation n'est pas configurée.
        }
      }
      // Point d'extension réservé pour l'émission automatique d'un CV
      // (RG-CV-*, extension CV Ecclésiastique — nom `validerCote` et
      // paramètre `annexerCvAuTitulaire` déjà tranchés dans
      // RECONSTRUCTION_ecclesias360.md §2) : non câblé ici, l'extension CV
      // n'existe pas encore (aucun consommateur réel, voir AGENTS.md §11).
    }

    return _findByIdOrThrow(mutationId);
  }

  Future<Mutation> refuserMutation({
    required String mutationId,
    String? motifRefus,
  }) async {
    final mutation = await _findByIdOrThrow(mutationId);
    if (mutation.statut != StatutMutation.enAttente) {
      throw AppError.mutationNonEnAttente();
    }

    await (_db.update(_db.mutations)..where((t) => t.id.equals(mutationId))).write(
      MutationsCompanion(
        statut: const Value('refusee'),
        motifRefus: Value(motifRefus),
      ),
    );

    return _findByIdOrThrow(mutationId);
  }

  Stream<List<Mutation>> watchMutations({String? noeudId, StatutMutation? statut}) {
    final query = _db.select(_db.mutations);
    if (noeudId != null) {
      query.where((t) => t.noeudOrigineId.equals(noeudId) | t.noeudDestinationId.equals(noeudId));
    }
    if (statut != null) {
      query.where((t) => t.statut.equals(statut.code));
    }
    query.orderBy([(t) => OrderingTerm.desc(t.dateDemande)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList(growable: false));
  }

  /// RG-IX-03 — historique complet des mutations d'un fidèle.
  Future<List<Mutation>> mutationsDe(String fideleId) async {
    final rows = await (_db.select(_db.mutations)
          ..where((t) => t.fideleId.equals(fideleId))
          ..orderBy([(t) => OrderingTerm.desc(t.dateDemande)]))
        .get();
    return rows.map(_toDomain).toList(growable: false);
  }

  Future<Mutation?> findById(String id) async {
    final row = await (_db.select(_db.mutations)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<LettreRecommandation?> lettreDe(String mutationId) async {
    final row = await (_db.select(_db.lettresRecommandation)..where((t) => t.mutationId.equals(mutationId)))
        .getSingleOrNull();
    return row == null
        ? null
        : LettreRecommandation(id: row.id, mutationId: row.mutationId, documentArchiveId: row.documentArchiveId);
  }

  Future<Mutation> _findByIdOrThrow(String id) async {
    final mutation = await findById(id);
    if (mutation == null) {
      throw ArgumentError('Mutation introuvable : $id');
    }
    return mutation;
  }

  Mutation _toDomain(MutationRow row) {
    return Mutation(
      id: row.id,
      fideleId: row.fideleId,
      noeudOrigineId: row.noeudOrigineId,
      noeudDestinationId: row.noeudDestinationId,
      motif: row.motif,
      statut: StatutMutation.fromCode(row.statut),
      dateDemande: row.dateDemande,
      valideeParOrigine: row.valideeParOrigine,
      valideeParDestination: row.valideeParDestination,
      dateValidation: row.dateValidation,
      motifRefus: row.motifRefus,
    );
  }
}
