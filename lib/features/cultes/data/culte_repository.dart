import 'package:drift/drift.dart';

import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/culte.dart';
import '../domain/models/mode_presence.dart';
import '../domain/models/presence_culte.dart';
import '../domain/models/proposition_theme.dart';
import '../domain/models/publication_culte.dart';
import '../domain/models/sequence_liturgique.dart';
import '../domain/models/statut_culte.dart';
import '../domain/models/statut_proposition.dart';
import '../domain/models/valeur_vote.dart';
import '../domain/models/vote_proposition.dart';
import '../domain/rules/culte_rules.dart';
import '../../mediatheque/data/mediatheque_repository.dart';

/// Dépôt Module XII — cultes (RG-XII-01 à 06). Pas de synchronisation
/// distante pour cette première itération, même précédent documenté que
/// les modules précédents. `mediathequeRepository` est un producteur
/// consommé par injection optionnelle (RG-XIII-02) : quand fourni,
/// `publier` archive automatiquement les médias de la publication dans
/// la médiathèque — même motif d'injection optionnelle qu'`Archivage
/// Repository`/`ComptabiliteRepository` dans les modules précédents.
class CulteRepository {
  CulteRepository(this._db, {MediathequeRepository? mediathequeRepository})
      : _mediatheque = mediathequeRepository;

  final AppDatabase _db;
  final MediathequeRepository? _mediatheque;

  // --- Cultes (RG-XII-01/02/05) --------------------------------------------

  Stream<List<Culte>> watchCultes(String noeudId) {
    final query = _db.select(_db.cultes)
      ..where((t) => t.noeudId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateHeure)]);
    return query.watch().map((rows) => rows.map(_culteToDomain).toList(growable: false));
  }

  Future<Culte?> findCulteById(String id) async {
    final row = await (_db.select(_db.cultes)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _culteToDomain(row);
  }

  Future<Culte> creerCulte({
    required String noeudId,
    required DateTime dateHeure,
    required String typeCulte,
    String? theme,
    String? predicateurId,
    ModePresence modePresence = ModePresence.nominal,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.cultes).insert(
          CultesCompanion.insert(
            id: id,
            noeudId: noeudId,
            dateHeure: dateHeure,
            typeCulte: typeCulte,
            theme: Value(theme),
            predicateurId: Value(predicateurId),
            modePresence: Value(modePresence.code),
          ),
        );
    return (await findCulteById(id))!;
  }

  /// RG-XII-05 — crée une série de cultes récurrents (occurrences
  /// hebdomadaires), regroupées par un identifiant de série commun.
  Future<List<Culte>> creerSerieRecurrente({
    required String noeudId,
    required DateTime premiereDateHeure,
    required String typeCulte,
    String? theme,
    String? predicateurId,
    ModePresence modePresence = ModePresence.nominal,
    required int nombreOccurrences,
  }) async {
    final dates = CulteRules.genererDatesRecurrentes(
      premiereDateHeure: premiereDateHeure,
      nombreOccurrences: nombreOccurrences,
    );
    final serieId = IdGenerator.newId();
    final ids = <String>[];
    await _db.batch((b) {
      for (final date in dates) {
        final id = IdGenerator.newId();
        ids.add(id);
        b.insert(
          _db.cultes,
          CultesCompanion.insert(
            id: id,
            noeudId: noeudId,
            dateHeure: date,
            typeCulte: typeCulte,
            theme: Value(theme),
            predicateurId: Value(predicateurId),
            modePresence: Value(modePresence.code),
            serieRecurrenteId: Value(serieId),
          ),
        );
      }
    });
    final rows = await (_db.select(_db.cultes)..where((t) => t.id.isIn(ids))).get();
    return rows.map(_culteToDomain).toList(growable: false);
  }

  Future<void> changerStatutCulte({required String id, required StatutCulte statut}) async {
    await (_db.update(_db.cultes)..where((t) => t.id.equals(id)))
        .write(CultesCompanion(statut: Value(statut.code)));
  }

  // --- Présences (RG-XII-02) ------------------------------------------------

  Stream<List<PresenceCulte>> watchPresences(String culteId) {
    final query = _db.select(_db.presencesCulte)..where((t) => t.culteId.equals(culteId));
    return query.watch().map((rows) => rows.map(_presenceToDomain).toList(growable: false));
  }

  Future<void> ajouterPresenceNominale({required String culteId, required String fideleId}) async {
    final culte = await (_db.select(_db.cultes)..where((t) => t.id.equals(culteId))).getSingle();
    final erreur = CulteRules.raisonBlocagePresence(
      modeDuCulte: ModePresence.fromCode(culte.modePresence),
      modeDemande: ModePresence.nominal,
    );
    if (erreur != null) {
      throw erreur;
    }
    await _db.into(_db.presencesCulte).insert(
          PresencesCulteCompanion.insert(id: IdGenerator.newId(), culteId: culteId, fideleId: fideleId),
        );
  }

  Future<void> retirerPresenceNominale(String id) async {
    await (_db.delete(_db.presencesCulte)..where((t) => t.id.equals(id))).go();
  }

  Future<void> definirCompteGlobalPresence({required String culteId, required int compte}) async {
    final culte = await (_db.select(_db.cultes)..where((t) => t.id.equals(culteId))).getSingle();
    final erreur = CulteRules.raisonBlocagePresence(
      modeDuCulte: ModePresence.fromCode(culte.modePresence),
      modeDemande: ModePresence.global,
    );
    if (erreur != null) {
      throw erreur;
    }
    await (_db.update(_db.cultes)..where((t) => t.id.equals(culteId)))
        .write(CultesCompanion(compteGlobalPresence: Value(compte)));
  }

  // --- Liturgie (RG-XII-01) -------------------------------------------------

  Stream<List<SequenceLiturgique>> watchSequences(String culteId) {
    final query = _db.select(_db.sequencesLiturgiques)
      ..where((t) => t.culteId.equals(culteId))
      ..orderBy([(t) => OrderingTerm.asc(t.ordre)]);
    return query.watch().map((rows) => rows.map(_sequenceToDomain).toList(growable: false));
  }

  Future<void> ajouterSequence({
    required String culteId,
    required int ordre,
    required String libelle,
    String? responsableId,
    int? dureePrevueMinutes,
  }) {
    return _db.into(_db.sequencesLiturgiques).insert(
          SequencesLiturgiquesCompanion.insert(
            id: IdGenerator.newId(),
            culteId: culteId,
            ordre: ordre,
            libelle: libelle,
            responsableId: Value(responsableId),
            dureePrevueMinutes: Value(dureePrevueMinutes),
          ),
        );
  }

  Future<void> retirerSequence(String id) async {
    await (_db.delete(_db.sequencesLiturgiques)..where((t) => t.id.equals(id))).go();
  }

  // --- Publication post-culte (RG-XII-03) -----------------------------------

  Stream<PublicationCulte?> watchPublication(String culteId) {
    final query = _db.select(_db.publicationsCulte)..where((t) => t.culteId.equals(culteId));
    return query.watchSingleOrNull().map((row) => row == null ? null : _publicationToDomain(row));
  }

  Future<PublicationCulte> publier({
    required String culteId,
    String? texteBiblique,
    String? audioUrl,
    String? videoUrl,
    String? pdfUrl,
  }) async {
    final existante =
        await (_db.select(_db.publicationsCulte)..where((t) => t.culteId.equals(culteId))).getSingleOrNull();

    if (existante != null) {
      await (_db.update(_db.publicationsCulte)..where((t) => t.id.equals(existante.id))).write(
        PublicationsCulteCompanion(
          texteBiblique: Value(texteBiblique),
          audioUrl: Value(audioUrl),
          videoUrl: Value(videoUrl),
          pdfUrl: Value(pdfUrl),
          datePublication: Value(DateTime.now()),
        ),
      );
      final row = await (_db.select(_db.publicationsCulte)..where((t) => t.id.equals(existante.id))).getSingle();
      await _archiverDansMediathequeSiInjecte(
        culteId: culteId,
        audioUrl: audioUrl,
        videoUrl: videoUrl,
        pdfUrl: pdfUrl,
      );
      return _publicationToDomain(row);
    }

    final id = IdGenerator.newId();
    await _db.into(_db.publicationsCulte).insert(
          PublicationsCulteCompanion.insert(
            id: id,
            culteId: culteId,
            datePublication: DateTime.now(),
            texteBiblique: Value(texteBiblique),
            audioUrl: Value(audioUrl),
            videoUrl: Value(videoUrl),
            pdfUrl: Value(pdfUrl),
          ),
        );
    final row = await (_db.select(_db.publicationsCulte)..where((t) => t.id.equals(id))).getSingle();
    await _archiverDansMediathequeSiInjecte(
      culteId: culteId,
      audioUrl: audioUrl,
      videoUrl: videoUrl,
      pdfUrl: pdfUrl,
    );
    return _publicationToDomain(row);
  }

  /// RG-XIII-02 — archive automatiquement, sans ressaisie manuelle, les
  /// médias non-nuls d'une publication post-culte dans la médiathèque
  /// (Module XIII), quand `MediathequeRepository` est injecté. Aucune
  /// opération si aucun média n'est renseigné ou si le producteur n'est pas
  /// injecté (même précédent que les autres producteurs optionnels).
  Future<void> _archiverDansMediathequeSiInjecte({
    required String culteId,
    String? audioUrl,
    String? videoUrl,
    String? pdfUrl,
  }) async {
    final mediathequeRepository = _mediatheque;
    if (mediathequeRepository == null) return;
    if (audioUrl == null && videoUrl == null && pdfUrl == null) return;

    final culte = await (_db.select(_db.cultes)..where((t) => t.id.equals(culteId))).getSingle();
    final dateLabel = '${culte.dateHeure.year.toString().padLeft(4, '0')}-'
        '${culte.dateHeure.month.toString().padLeft(2, '0')}-'
        '${culte.dateHeure.day.toString().padLeft(2, '0')}';
    final theme = (culte.theme != null && culte.theme!.isNotEmpty) ? culte.theme! : culte.typeCulte;
    final titre = (culte.theme != null && culte.theme!.isNotEmpty) ? culte.theme! : 'Culte du $dateLabel';

    await mediathequeRepository.archiverDepuisCulte(
      culteId: culteId,
      noeudEditeurId: culte.noeudId,
      titre: titre,
      theme: theme,
      dateContenu: culte.dateHeure,
      audioUrl: audioUrl,
      videoUrl: videoUrl,
      pdfUrl: pdfUrl,
    );
  }

  // --- Propositions de thème (RG-XII-06) --------------------------------------

  /// [nbLikes]/[nbDislikes] sont calculés en base à partir des votes réels
  /// (`votes_proposition`), réactifs aux deux tables.
  Stream<List<PropositionTheme>> watchPropositions() {
    final query = _db.customSelect(
      'SELECT p.*, '
      "(SELECT COUNT(*) FROM votes_proposition v WHERE v.proposition_id = p.id AND v.valeur = 'jaime') AS nb_likes, "
      "(SELECT COUNT(*) FROM votes_proposition v WHERE v.proposition_id = p.id AND v.valeur = 'jenaimepas') AS nb_dislikes "
      'FROM propositions_theme p ORDER BY p.date_soumission DESC',
      readsFrom: {_db.propositionsTheme, _db.votesProposition},
    );
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => PropositionTheme(
                  id: row.read<String>('id'),
                  fideleId: row.read<String>('fidele_id'),
                  titre: row.read<String>('titre'),
                  explication: row.readNullable<String>('explication'),
                  categorie: row.readNullable<String>('categorie'),
                  statut: StatutProposition.fromCode(row.read<String>('statut')),
                  dateSoumission: row.read<DateTime>('date_soumission'),
                  nbLikes: row.read<int>('nb_likes'),
                  nbDislikes: row.read<int>('nb_dislikes'),
                ),
              )
              .toList(growable: false),
        );
  }

  Future<void> soumettreProposition({
    required String fideleId,
    required String titre,
    String? explication,
  }) {
    return _db.into(_db.propositionsTheme).insert(
          PropositionsThemeCompanion.insert(
            id: IdGenerator.newId(),
            fideleId: fideleId,
            titre: titre,
            explication: Value(explication),
            dateSoumission: DateTime.now(),
          ),
        );
  }

  Future<void> changerStatutProposition({required String id, required StatutProposition statut}) async {
    await (_db.update(_db.propositionsTheme)..where((t) => t.id.equals(id)))
        .write(PropositionsThemeCompanion(statut: Value(statut.code)));
  }

  Stream<List<VoteProposition>> watchVotes(String propositionId) {
    final query = _db.select(_db.votesProposition)..where((t) => t.propositionId.equals(propositionId));
    return query.watch().map((rows) => rows.map(_voteToDomain).toList(growable: false));
  }

  /// RG-XII-06 — un vote par fidèle et par proposition ; voter à nouveau
  /// change simplement le sens du vote (jamais un second vote compté).
  Future<void> voter({required String propositionId, required String fideleId, required ValeurVote valeur}) async {
    final proposition =
        await (_db.select(_db.propositionsTheme)..where((t) => t.id.equals(propositionId))).getSingle();
    final erreur = CulteRules.raisonBlocageVote(auteurPropositionId: proposition.fideleId, votantId: fideleId);
    if (erreur != null) throw erreur;
    final existant = await (_db.select(_db.votesProposition)
          ..where((t) => t.propositionId.equals(propositionId) & t.fideleId.equals(fideleId)))
        .getSingleOrNull();
    if (existant != null) {
      await (_db.update(_db.votesProposition)..where((t) => t.id.equals(existant.id)))
          .write(VotesPropositionCompanion(valeur: Value(valeur.code)));
      return;
    }
    await _db.into(_db.votesProposition).insert(
          VotesPropositionCompanion.insert(
            id: IdGenerator.newId(),
            propositionId: propositionId,
            fideleId: fideleId,
            valeur: valeur.code,
          ),
        );
  }

  Culte _culteToDomain(CulteRow row) {
    return Culte(
      id: row.id,
      noeudId: row.noeudId,
      dateHeure: row.dateHeure,
      typeCulte: row.typeCulte,
      theme: row.theme,
      predicateurId: row.predicateurId,
      statut: StatutCulte.fromCode(row.statut),
      modePresence: ModePresence.fromCode(row.modePresence),
      compteGlobalPresence: row.compteGlobalPresence,
      serieRecurrenteId: row.serieRecurrenteId,
      estException: row.estException,
    );
  }

  SequenceLiturgique _sequenceToDomain(SequenceLiturgiqueRow row) {
    return SequenceLiturgique(
      id: row.id,
      culteId: row.culteId,
      ordre: row.ordre,
      libelle: row.libelle,
      responsableId: row.responsableId,
      dureePrevueMinutes: row.dureePrevueMinutes,
    );
  }

  PresenceCulte _presenceToDomain(PresenceCulteRow row) {
    return PresenceCulte(id: row.id, culteId: row.culteId, fideleId: row.fideleId);
  }

  PublicationCulte _publicationToDomain(PublicationCulteRow row) {
    return PublicationCulte(
      id: row.id,
      culteId: row.culteId,
      datePublication: row.datePublication,
      texteBiblique: row.texteBiblique,
      audioUrl: row.audioUrl,
      videoUrl: row.videoUrl,
      pdfUrl: row.pdfUrl,
    );
  }

  VoteProposition _voteToDomain(VotePropositionRow row) {
    return VoteProposition(
      id: row.id,
      propositionId: row.propositionId,
      fideleId: row.fideleId,
      valeur: ValeurVote.fromCode(row.valeur),
    );
  }
}
