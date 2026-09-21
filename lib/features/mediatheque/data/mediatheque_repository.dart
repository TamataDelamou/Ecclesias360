import 'package:drift/drift.dart';

import '../../../core/theme/app_defaults.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../domain/models/commentaire.dart';
import '../domain/models/contenu_mediatheque.dart';
import '../domain/models/favori.dart';
import '../domain/models/statut_moderation_commentaire.dart';
import '../domain/models/statut_publication_contenu.dart';
import '../domain/models/type_contenu_mediatheque.dart';
import '../domain/rules/mediatheque_rules.dart';

/// Dépôt Module XIII — Médiathèque chrétienne (RG-XIII-01 à 05). Consommé
/// aussi en producteur, par injection optionnelle dans `CulteRepository`
/// (RG-XII-03, publication post-culte) — même motif d'injection optionnelle
/// qu'`ArchivageRepository`/`ComptabiliteRepository` dans les modules
/// précédents. Décision explicite (« métadonnées seulement ») : `fichier`
/// n'est qu'une référence (URL ou texte) ; aucun téléversement, lecture ou
/// téléchargement de fichier réel n'est construit dans cette itération.
/// Synchronisation distante différée, même précédent documenté que les
/// modules précédents.
class MediathequeRepository {
  MediathequeRepository(this._db);

  final AppDatabase _db;

  // --- Catalogue (RG-XIII-01/02) ----------------------------------------------

  /// Écran mobile « Catalogue » du Cahier — uniquement les contenus publiés.
  Stream<List<ContenuMediatheque>> watchCatalogue() {
    final query = _db.select(_db.contenusMediatheque)
      ..where((t) => t.statut.equals(StatutPublicationContenu.publie.code))
      ..orderBy([(t) => OrderingTerm.desc(t.dateContenu)]);
    return query.watch().map((rows) => rows.map(_contenuToDomain).toList(growable: false));
  }

  /// Vue de gestion pour un nœud éditeur : tous les statuts (brouillon,
  /// publié, retiré).
  Stream<List<ContenuMediatheque>> watchTousLesContenus(String noeudId) {
    final query = _db.select(_db.contenusMediatheque)
      ..where((t) => t.noeudEditeurId.equals(noeudId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateContenu)]);
    return query.watch().map((rows) => rows.map(_contenuToDomain).toList(growable: false));
  }

  /// RG-XIII-01 — recherche par thème (recherche partielle, insensible à la
  /// casse via `LIKE`), restreinte aux contenus publiés.
  Future<List<ContenuMediatheque>> rechercherParTheme(String motCle) async {
    final rows = await (_db.select(_db.contenusMediatheque)
          ..where((t) => t.statut.equals(StatutPublicationContenu.publie.code) & t.theme.like('%$motCle%')))
        .get();
    return rows.map(_contenuToDomain).toList(growable: false);
  }

  Future<ContenuMediatheque> ajouterContenu({
    required TypeContenuMediatheque typeContenu,
    required String titre,
    required String noeudEditeurId,
    String? fichier,
    required String theme,
    List<String> motsCles = const [],
    String? intervenant,
    required DateTime dateContenu,
    bool droitsTelechargement = false,
    bool moderationAPriori = false,
  }) async {
    final id = IdGenerator.newId();
    await _db.into(_db.contenusMediatheque).insert(
          ContenusMediathequeCompanion.insert(
            id: id,
            typeContenu: typeContenu.code,
            titre: titre,
            noeudEditeurId: noeudEditeurId,
            fichier: Value(fichier),
            theme: theme,
            motsCles: Value(motsCles.join(',')),
            intervenant: Value(intervenant),
            dateContenu: dateContenu,
            droitsTelechargement: Value(droitsTelechargement),
            moderationAPriori: Value(moderationAPriori),
          ),
        );
    return _trouverContenuOuThrow(id);
  }

  Future<void> publierContenu(String id) async {
    await (_db.update(_db.contenusMediatheque)..where((t) => t.id.equals(id)))
        .write(ContenusMediathequeCompanion(statut: Value(StatutPublicationContenu.publie.code)));
  }

  Future<void> retirerContenu(String id) async {
    await (_db.update(_db.contenusMediatheque)..where((t) => t.id.equals(id)))
        .write(ContenusMediathequeCompanion(statut: Value(StatutPublicationContenu.retire.code)));
  }

  Future<void> enregistrerConsultation(String contenuId) async {
    final row = await (_db.select(_db.contenusMediatheque)..where((t) => t.id.equals(contenuId))).getSingle();
    await (_db.update(_db.contenusMediatheque)..where((t) => t.id.equals(contenuId)))
        .write(ContenusMediathequeCompanion(compteurConsultations: Value(row.compteurConsultations + 1)));
  }

  // --- Archivage automatique depuis un module producteur (RG-XIII-02) --------

  /// Appelé par `CulteRepository.publier` : archive automatiquement, sans
  /// ressaisie manuelle, chaque média non-nul d'une publication post-culte
  /// (audio, vidéo, document/PDF) comme un contenu de la médiathèque publié
  /// d'emblée. Idempotent grâce à la contrainte `UNIQUE (source_module,
  /// source_id, type_contenu)` : republier un culte déjà archivé met à jour
  /// la référence de fichier plutôt que d'en dupliquer une nouvelle entrée.
  Future<void> archiverDepuisCulte({
    required String culteId,
    required String noeudEditeurId,
    required String titre,
    required String theme,
    required DateTime dateContenu,
    String? intervenant,
    String? audioUrl,
    String? videoUrl,
    String? pdfUrl,
  }) async {
    final medias = <(TypeContenuMediatheque, String?)>[
      (TypeContenuMediatheque.audio, audioUrl),
      (TypeContenuMediatheque.video, videoUrl),
      (TypeContenuMediatheque.document, pdfUrl),
    ];
    for (final (type, fichier) in medias) {
      if (fichier == null) continue;
      await _upsertContenuSource(
        sourceModule: 'XII',
        sourceId: culteId,
        typeContenu: type,
        titre: titre,
        noeudEditeurId: noeudEditeurId,
        fichier: fichier,
        theme: theme,
        intervenant: intervenant,
        dateContenu: dateContenu,
      );
    }
  }

  Future<void> _upsertContenuSource({
    required String sourceModule,
    required String sourceId,
    required TypeContenuMediatheque typeContenu,
    required String titre,
    required String noeudEditeurId,
    required String fichier,
    required String theme,
    String? intervenant,
    required DateTime dateContenu,
  }) async {
    final existant = await (_db.select(_db.contenusMediatheque)
          ..where((t) =>
              t.sourceModule.equals(sourceModule) & t.sourceId.equals(sourceId) & t.typeContenu.equals(typeContenu.code)))
        .getSingleOrNull();

    if (existant != null) {
      await (_db.update(_db.contenusMediatheque)..where((t) => t.id.equals(existant.id))).write(
        ContenusMediathequeCompanion(
          titre: Value(titre),
          fichier: Value(fichier),
          theme: Value(theme),
          intervenant: Value(intervenant),
          dateContenu: Value(dateContenu),
        ),
      );
      return;
    }

    await _db.into(_db.contenusMediatheque).insert(
          ContenusMediathequeCompanion.insert(
            id: IdGenerator.newId(),
            typeContenu: typeContenu.code,
            titre: titre,
            sourceModule: Value(sourceModule),
            sourceId: Value(sourceId),
            noeudEditeurId: noeudEditeurId,
            fichier: Value(fichier),
            theme: theme,
            intervenant: Value(intervenant),
            dateContenu: dateContenu,
            statut: Value(StatutPublicationContenu.publie.code),
          ),
        );
  }

  // --- Favoris (RG-XIII-04) ---------------------------------------------------

  Stream<List<Favori>> watchFavoris(String fideleId) {
    final query = _db.select(_db.favoris)..where((t) => t.fideleId.equals(fideleId));
    return query.watch().map((rows) => rows.map(_favoriToDomain).toList(growable: false));
  }

  /// Bascule l'état favori d'un contenu pour un fidèle : ajoute s'il n'existe
  /// pas encore, retire sinon.
  Future<void> toggleFavori({required String fideleId, required String contenuId}) async {
    final existant = await (_db.select(_db.favoris)
          ..where((t) => t.fideleId.equals(fideleId) & t.contenuId.equals(contenuId)))
        .getSingleOrNull();
    if (existant != null) {
      await (_db.delete(_db.favoris)..where((t) => t.id.equals(existant.id))).go();
      return;
    }
    await _db.into(_db.favoris).insert(
          FavorisCompanion.insert(id: IdGenerator.newId(), fideleId: fideleId, contenuId: contenuId),
        );
  }

  // --- Commentaires (RG-XIII-03) ----------------------------------------------

  Stream<List<Commentaire>> watchCommentaires(String contenuId) {
    final query = _db.select(_db.commentaires)
      ..where((t) => t.contenuId.equals(contenuId))
      ..orderBy([(t) => OrderingTerm.asc(t.date)]);
    return query.watch().map((rows) => rows.map(_commentaireToDomain).toList(growable: false));
  }

  /// RG-XIII-03 — dépose un commentaire ; son statut de départ dépend de la
  /// modération a priori ou a posteriori configurée sur le contenu.
  Future<Commentaire> ajouterCommentaire({
    required String contenuId,
    required String fideleId,
    required String texte,
  }) async {
    final contenu = await (_db.select(_db.contenusMediatheque)..where((t) => t.id.equals(contenuId))).getSingle();
    final statutInitial =
        MediathequeRules.statutInitialCommentaire(moderationAPriori: contenu.moderationAPriori);
    final id = IdGenerator.newId();
    await _db.into(_db.commentaires).insert(
          CommentairesCompanion.insert(
            id: id,
            contenuId: contenuId,
            fideleId: fideleId,
            texte: texte,
            statutModeration: Value(statutInitial.code),
            date: DateTime.now(),
          ),
        );
    final row = await (_db.select(_db.commentaires)..where((t) => t.id.equals(id))).getSingle();
    return _commentaireToDomain(row);
  }

  /// RG-XIII-03 — un signalement de plus sur un commentaire publié ; masque
  /// automatiquement au-delà du seuil paramétrable, en attendant une
  /// décision de modération.
  Future<void> signalerCommentaire(String id) async {
    final row = await (_db.select(_db.commentaires)..where((t) => t.id.equals(id))).getSingle();
    final nouveauNombre = row.nombreSignalements + 1;
    final doitMasquer = StatutModerationCommentaire.fromCode(row.statutModeration) ==
            StatutModerationCommentaire.publie &&
        MediathequeRules.doitMasquerAutomatiquement(
          nombreSignalements: nouveauNombre,
          seuil: AppDefaults.mediathequeSeuilSignalementsAvantMasquage,
        );
    await (_db.update(_db.commentaires)..where((t) => t.id.equals(id))).write(
      CommentairesCompanion(
        nombreSignalements: Value(nouveauNombre),
        statutModeration:
            doitMasquer ? Value(StatutModerationCommentaire.masque.code) : const Value.absent(),
      ),
    );
  }

  Future<void> modererCommentaire({required String id, required StatutModerationCommentaire nouveauStatut}) async {
    await (_db.update(_db.commentaires)..where((t) => t.id.equals(id)))
        .write(CommentairesCompanion(statutModeration: Value(nouveauStatut.code)));
  }

  // --- Conversions -------------------------------------------------------------

  Future<ContenuMediatheque> _trouverContenuOuThrow(String id) async {
    final row = await (_db.select(_db.contenusMediatheque)..where((t) => t.id.equals(id))).getSingle();
    return _contenuToDomain(row);
  }

  ContenuMediatheque _contenuToDomain(ContenuMediathequeRow row) => ContenuMediatheque(
        id: row.id,
        typeContenu: TypeContenuMediatheque.fromCode(row.typeContenu),
        titre: row.titre,
        sourceModule: row.sourceModule,
        sourceId: row.sourceId,
        noeudEditeurId: row.noeudEditeurId,
        fichier: row.fichier,
        theme: row.theme,
        motsCles: row.motsCles.isEmpty ? const [] : row.motsCles.split(','),
        intervenant: row.intervenant,
        dateContenu: row.dateContenu,
        statut: StatutPublicationContenu.fromCode(row.statut),
        droitsTelechargement: row.droitsTelechargement,
        moderationAPriori: row.moderationAPriori,
        compteurConsultations: row.compteurConsultations,
      );

  Favori _favoriToDomain(FavoriRow row) => Favori(id: row.id, fideleId: row.fideleId, contenuId: row.contenuId);

  Commentaire _commentaireToDomain(CommentaireRow row) => Commentaire(
        id: row.id,
        contenuId: row.contenuId,
        fideleId: row.fideleId,
        texte: row.texte,
        statutModeration: StatutModerationCommentaire.fromCode(row.statutModeration),
        date: row.date,
        nombreSignalements: row.nombreSignalements,
      );
}
