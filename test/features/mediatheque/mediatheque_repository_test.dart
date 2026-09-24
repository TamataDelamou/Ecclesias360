import 'package:drift/native.dart';
import 'package:ecclesias_360/core/audit/acteur.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/cultes/data/culte_repository.dart';
import 'package:ecclesias_360/features/cultes/domain/models/mode_presence.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/mediatheque/data/mediatheque_repository.dart';
import 'package:ecclesias_360/features/mediatheque/domain/models/statut_moderation_commentaire.dart';
import 'package:ecclesias_360/features/mediatheque/domain/models/statut_publication_contenu.dart';
import 'package:ecclesias_360/features/mediatheque/domain/models/type_contenu_mediatheque.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late MediathequeRepository repository;
  late String noeudId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = MediathequeRepository(db);

    noeudId = 'noeud-1';
    await db.into(db.organisationNodes).insert(
          OrganisationNodesCompanion.insert(
            id: noeudId,
            typeNoeud: 'siege',
            nom: 'GSG',
            codeInterne: 'GSG',
            path: '/$noeudId/',
            depth: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
  });

  tearDown(() => db.close());

  group('catalogue (RG-XIII-01/02)', () {
    test('seul un contenu publié apparaît dans le catalogue', () async {
      final brouillon = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'Prédication en brouillon',
        noeudEditeurId: noeudId,
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
      );
      final publie = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.video,
        titre: 'Prédication publiée',
        noeudEditeurId: noeudId,
        theme: 'Espérance',
        dateContenu: DateTime(2026, 1, 2),
      );
      await repository.publierContenu(publie.id);

      final catalogue = await repository.watchCatalogue().first;
      expect(catalogue, hasLength(1));
      expect(catalogue.single.id, publie.id);
      expect(catalogue.single.statut, StatutPublicationContenu.publie);

      final tous = await repository.watchTousLesContenus(noeudId).first;
      expect(tous, hasLength(2));
      expect(tous.map((c) => c.id), containsAll([brouillon.id, publie.id]));
    });

    test('rechercherParTheme ne retourne que les contenus publiés correspondants', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.ebook,
        titre: 'Livre sur la prière',
        noeudEditeurId: noeudId,
        theme: 'Prière et jeûne',
        dateContenu: DateTime(2026, 1, 3),
      );
      await repository.publierContenu(contenu.id);

      final resultats = await repository.rechercherParTheme('prière');
      expect(resultats, hasLength(1));
      expect(resultats.single.id, contenu.id);

      expect(await repository.rechercherParTheme('inexistant'), isEmpty);
    });

    test('motsCles est conservé (round-trip texte séparé par des virgules)', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.podcast,
        titre: 'Podcast',
        noeudEditeurId: noeudId,
        theme: 'Jeunesse',
        motsCles: const ['jeunesse', 'louange', 'témoignage'],
        dateContenu: DateTime(2026, 1, 4),
      );
      final tous = await repository.watchTousLesContenus(noeudId).first;
      expect(tous.single.motsCles, ['jeunesse', 'louange', 'témoignage']);
      expect(contenu.motsCles, ['jeunesse', 'louange', 'témoignage']);
    });

    test('retirerContenu retire le contenu du catalogue', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.magazine,
        titre: 'Magazine',
        noeudEditeurId: noeudId,
        theme: 'Vie de l\'église',
        dateContenu: DateTime(2026, 1, 5),
      );
      await repository.publierContenu(contenu.id);
      expect(await repository.watchCatalogue().first, hasLength(1));

      await repository.retirerContenu(contenu.id);
      expect(await repository.watchCatalogue().first, isEmpty);
    });

    test('enregistrerConsultation incrémente le compteur', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.document,
        titre: 'Document',
        noeudEditeurId: noeudId,
        theme: 'Enseignement',
        dateContenu: DateTime(2026, 1, 6),
      );
      expect(contenu.compteurConsultations, 0);

      await repository.enregistrerConsultation(contenu.id);
      await repository.enregistrerConsultation(contenu.id);

      final tous = await repository.watchTousLesContenus(noeudId).first;
      expect(tous.single.compteurConsultations, 2);
    });
  });

  group('archivage automatique depuis CulteRepository.publier (RG-XIII-02)', () {
    late CulteRepository culteRepository;
    late String culteId;

    setUp(() async {
      culteRepository = CulteRepository(db, mediathequeRepository: repository);
      final culte = await culteRepository.creerCulte(
        noeudId: noeudId,
        dateHeure: DateTime(2026, 2, 1, 10),
        typeCulte: 'culte_dominical',
        modePresence: ModePresence.nominal,
        theme: 'La grâce suffit',
      );
      culteId = culte.id;
    });

    test('publier un culte avec médias archive automatiquement dans la médiathèque', () async {
      await culteRepository.publier(
        culteId: culteId,
        audioUrl: 'https://exemple.org/culte.mp3',
        videoUrl: 'https://exemple.org/culte.mp4',
      );

      final catalogue = await repository.watchCatalogue().first;
      expect(catalogue, hasLength(2));
      expect(catalogue.map((c) => c.typeContenu), containsAll([TypeContenuMediatheque.audio, TypeContenuMediatheque.video]));
      expect(catalogue.every((c) => c.sourceModule == 'XII' && c.sourceId == culteId), isTrue);
      expect(catalogue.every((c) => c.titre == 'La grâce suffit'), isTrue);
    });

    test('publier un culte sans média n\'archive rien', () async {
      await culteRepository.publier(culteId: culteId, texteBiblique: 'Jean 3:16');
      expect(await repository.watchCatalogue().first, isEmpty);
    });

    test('republier le même culte met à jour l\'entrée existante plutôt que d\'en créer une nouvelle (idempotence)', () async {
      await culteRepository.publier(culteId: culteId, audioUrl: 'https://exemple.org/v1.mp3');
      await culteRepository.publier(culteId: culteId, audioUrl: 'https://exemple.org/v2.mp3');

      final catalogue = await repository.watchCatalogue().first;
      expect(catalogue, hasLength(1));
      expect(catalogue.single.fichier, 'https://exemple.org/v2.mp3');
    });

    test('sans injection de MediathequeRepository, publier fonctionne sans archiver', () async {
      final culteRepositorySansMediatheque = CulteRepository(db);
      await culteRepositorySansMediatheque.publier(
        culteId: culteId,
        audioUrl: 'https://exemple.org/culte.mp3',
      );
      expect(await repository.watchCatalogue().first, isEmpty);
    });
  });

  group('favoris (RG-XIII-04)', () {
    late FideleRepository fideleRepository;
    late String fideleId;
    late String contenuId;

    setUp(() async {
      fideleRepository = FideleRepository(db, SyncCoordinator(db));
      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      fideleId = fidele.id;

      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'Prédication',
        noeudEditeurId: noeudId,
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
      );
      contenuId = contenu.id;
    });

    test('toggleFavori ajoute puis retire le favori', () async {
      expect(await repository.watchFavoris(fideleId).first, isEmpty);

      await repository.toggleFavori(fideleId: fideleId, contenuId: contenuId);
      final apresAjout = await repository.watchFavoris(fideleId).first;
      expect(apresAjout, hasLength(1));
      expect(apresAjout.single.contenuId, contenuId);

      await repository.toggleFavori(fideleId: fideleId, contenuId: contenuId);
      expect(await repository.watchFavoris(fideleId).first, isEmpty);
    });
  });

  group('commentaires (RG-XIII-03)', () {
    late FideleRepository fideleRepository;
    late String fideleId;

    setUp(() async {
      fideleRepository = FideleRepository(db, SyncCoordinator(db));
      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      fideleId = fidele.id;
    });

    test('modération a posteriori : le commentaire est publié immédiatement', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'Prédication',
        noeudEditeurId: noeudId,
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
      );

      final commentaire = await repository.ajouterCommentaire(
        contenuId: contenu.id,
        fideleId: fideleId,
        texte: 'Merci pour ce message !',
      );
      expect(commentaire.statutModeration, StatutModerationCommentaire.publie);
    });

    test('modération a priori : le commentaire reste en attente', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'Prédication',
        noeudEditeurId: noeudId,
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
        moderationAPriori: true,
      );

      final commentaire = await repository.ajouterCommentaire(
        contenuId: contenu.id,
        fideleId: fideleId,
        texte: 'Merci pour ce message !',
      );
      expect(commentaire.statutModeration, StatutModerationCommentaire.enAttente);
    });

    Future<String> autreFidele(String prenoms) async => (await fideleRepository.creerFidele(
          noeudId: noeudId,
          nom: 'Doe',
          prenoms: prenoms,
          dateNaissance: DateTime(1985, 1, 1),
          sexe: Sexe.feminin,
          statutCivil: StatutCivil.celibataire,
        ))
            .id;

    Future<String> commentairePublie() async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'Prédication',
        noeudEditeurId: noeudId,
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
      );
      return (await repository.ajouterCommentaire(contenuId: contenu.id, fideleId: fideleId, texte: 'Commentaire'))
          .id;
    }

    Future<StatutModerationCommentaire> statut(String id) async =>
        (await repository.watchCommentairesAModerer().first).where((c) => c.id == id).firstOrNull?.statutModeration ??
        StatutModerationCommentaire.publie;

    test('un même fidèle ne signale qu\'une fois : trois tentatives ne masquent rien', () async {
      final id = await commentairePublie();
      final paul = await autreFidele('Paul');

      await repository.signalerCommentaire(commentaireId: id, fideleId: paul);
      for (var i = 0; i < 2; i++) {
        await expectLater(
          repository.signalerCommentaire(commentaireId: id, fideleId: paul),
          throwsA(isA<AppError>().having((e) => e.code, 'code', 'commentaire_deja_signale')),
        );
      }
      expect(await statut(id), StatutModerationCommentaire.publie);
      expect((await repository.watchSignalements(id).first), hasLength(1));
    });

    test('ni son propre commentaire, ni sans fiche', () async {
      final id = await commentairePublie();
      await expectLater(
        repository.signalerCommentaire(commentaireId: id, fideleId: fideleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'signalement_propre_commentaire')),
      );
      await expectLater(
        repository.signalerCommentaire(commentaireId: id, fideleId: null),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'signalement_sans_fiche')),
      );
    });

    test('masquage automatique au seuil de signaleurs distincts, chacun tracé', () async {
      final id = await commentairePublie();
      final signaleurs = [await autreFidele('Paul'), await autreFidele('Rita'), await autreFidele('Luc')];

      await repository.signalerCommentaire(commentaireId: id, fideleId: signaleurs[0], motif: 'Hors sujet');
      await repository.signalerCommentaire(commentaireId: id, fideleId: signaleurs[1]);
      expect(await statut(id), StatutModerationCommentaire.publie);

      await repository.signalerCommentaire(commentaireId: id, fideleId: signaleurs[2]);
      expect(await statut(id), StatutModerationCommentaire.masque);
      final traces = await repository.watchSignalements(id).first;
      expect(traces.map((s) => s.fideleId), signaleurs);
      expect(traces.first.motif, 'Hors sujet');
    });

    test('modération : réservée au pasteur avec fiche, tracée, et remet le décompte à zéro', () async {
      final id = await commentairePublie();
      final signaleurs = [await autreFidele('Paul'), await autreFidele('Rita'), await autreFidele('Luc')];
      for (final s in signaleurs) {
        await repository.signalerCommentaire(commentaireId: id, fideleId: s);
      }
      final pasteurId = await autreFidele('Pasteur');

      await expectLater(
        repository.modererCommentaire(
          id: id,
          nouveauStatut: StatutModerationCommentaire.publie,
          acteur: Acteur(authUserId: 'r', fideleId: signaleurs[0], role: Role.responsable),
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'moderation_reservee')),
      );
      await expectLater(
        repository.modererCommentaire(
          id: id,
          nouveauStatut: StatutModerationCommentaire.publie,
          acteur: const Acteur(authUserId: 'admin', fideleId: null, role: Role.administrateur),
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'moderation_sans_fiche')),
      );

      await repository.modererCommentaire(
        id: id,
        nouveauStatut: StatutModerationCommentaire.publie,
        acteur: Acteur(authUserId: 'p', fideleId: pasteurId, role: Role.pasteur),
      );
      final commentaire = (await repository.watchCommentaires((await db.select(db.commentaires).getSingle()).contenuId)
              .first)
          .single;
      expect(commentaire.statutModeration, StatutModerationCommentaire.publie);
      expect(commentaire.moderePar, pasteurId);
      expect(commentaire.dateModeration, isNotNull);
      expect(commentaire.nombreSignalements, 0);

      // Un nouveau signaleur après l'approbation ne suffit pas à remasquer :
      // les signalements déjà examinés ne comptent plus.
      await repository.signalerCommentaire(commentaireId: id, fideleId: await autreFidele('Marc'));
      expect(await statut(id), StatutModerationCommentaire.publie);
    });

    test('file de modération : en attente et signalés, pas les commentaires sans histoire', () async {
      final contenu = await repository.ajouterContenu(
        typeContenu: TypeContenuMediatheque.audio,
        titre: 'Prédication',
        noeudEditeurId: noeudId,
        theme: 'Foi',
        dateContenu: DateTime(2026, 1, 1),
        moderationAPriori: true,
      );
      final enAttente =
          await repository.ajouterCommentaire(contenuId: contenu.id, fideleId: fideleId, texte: 'À valider');
      final tranquille = await commentairePublie();
      final signale = await commentairePublie();
      await repository.signalerCommentaire(commentaireId: signale, fideleId: await autreFidele('Paul'));

      final file = (await repository.watchCommentairesAModerer().first).map((c) => c.id).toSet();
      expect(file, {enAttente.id, signale});
      expect(file, isNot(contains(tranquille)));
    });
  });
}
