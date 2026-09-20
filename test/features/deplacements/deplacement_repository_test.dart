import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/archivage/data/archivage_repository.dart';
import 'package:ecclesias_360/features/deplacements/data/deplacement_repository.dart';
import 'package:ecclesias_360/features/deplacements/domain/models/cote.dart';
import 'package:ecclesias_360/features/deplacements/domain/models/statut_mutation.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/categorie_confessionnelle.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FideleRepository fideleRepository;
  late ArchivageRepository archivageRepository;
  late DeplacementRepository repository;
  late String noeudOrigineId;
  late String noeudDestinationId;
  late String fideleId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final syncCoordinator = SyncCoordinator(db);
    final organisationRepository = OrganisationNodeRepository(db, syncCoordinator);
    fideleRepository = FideleRepository(db, syncCoordinator);
    archivageRepository = ArchivageRepository(db);
    repository = DeplacementRepository(db, fideleRepository, archivageRepository: archivageRepository);

    final siege = await organisationRepository.creerNoeud(
      typeNoeud: TypeNoeud.siege,
      noeudParentId: null,
      nom: 'Siège',
      codeInterne: 'SIEGE',
    );
    final origine = await organisationRepository.creerNoeud(
      typeNoeud: TypeNoeud.egliseLocale,
      noeudParentId: siege.id,
      nom: 'Église Origine',
      codeInterne: 'ORIGINE',
      categorieConfessionnelle: CategorieConfessionnelle.autres,
    );
    final destination = await organisationRepository.creerNoeud(
      typeNoeud: TypeNoeud.egliseLocale,
      noeudParentId: siege.id,
      nom: 'Église Destination',
      codeInterne: 'DESTINATION',
      categorieConfessionnelle: CategorieConfessionnelle.autres,
    );
    noeudOrigineId = origine.id;
    noeudDestinationId = destination.id;

    final fidele = await fideleRepository.creerFidele(
      noeudId: noeudOrigineId,
      nom: 'Doe',
      prenoms: 'Jean',
      dateNaissance: DateTime(1990, 1, 1),
      sexe: Sexe.masculin,
      statutCivil: StatutCivil.celibataire,
    );
    fideleId = fidele.id;
  });

  tearDown(() => db.close());

  group('demanderMutation (RG-IX-01/04)', () {
    test('refuse un nœud d\'origine et de destination identiques', () {
      expect(
        () => repository.demanderMutation(
          fideleId: fideleId,
          noeudOrigineId: noeudOrigineId,
          noeudDestinationId: noeudOrigineId,
          motif: 'Déménagement',
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'noeud_origine_et_destination_identiques')),
      );
    });

    test('crée une mutation en attente, sans côté validé', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );

      expect(mutation.statut, StatutMutation.enAttente);
      expect(mutation.valideeParOrigine, isFalse);
      expect(mutation.valideeParDestination, isFalse);

      // RG-IX-04 : aucune statistique de consolidation touchée avant
      // validation -> le fidèle reste rattaché au nœud d'origine.
      final fidele = await fideleRepository.findById(fideleId);
      expect(fidele!.noeudId, noeudOrigineId);
    });
  });

  group('validerCote (RG-IX-01/02/03)', () {
    test('politique bilatérale (défaut) : un seul côté ne suffit pas', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );

      final apresOrigine = await repository.validerCote(mutationId: mutation.id, cote: Cote.origine);
      expect(apresOrigine.statut, StatutMutation.enAttente);
      expect(apresOrigine.valideeParOrigine, isTrue);
      expect(apresOrigine.valideeParDestination, isFalse);

      final fidele = await fideleRepository.findById(fideleId);
      expect(fidele!.noeudId, noeudOrigineId, reason: 'pas encore validée des deux côtés');
    });

    test('les deux côtés validés -> mutation validée, rattachement changé et historisé (RG-IX-03)', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );

      await repository.validerCote(mutationId: mutation.id, cote: Cote.origine);
      final validee = await repository.validerCote(mutationId: mutation.id, cote: Cote.destination);

      expect(validee.statut, StatutMutation.validee);
      expect(validee.dateValidation, isNotNull);

      final fidele = await fideleRepository.findById(fideleId);
      expect(fidele!.noeudId, noeudDestinationId);

      final historique = await fideleRepository.watchHistorique(fideleId).first;
      expect(historique.any((h) => h.champModifie == 'noeud_id'), isTrue);
    });

    test('validation unilatérale autorisée : un seul côté suffit', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );

      final validee = await repository.validerCote(
        mutationId: mutation.id,
        cote: Cote.destination,
        validationUnilateraleAutorisee: true,
      );

      expect(validee.statut, StatutMutation.validee);
      final fidele = await fideleRepository.findById(fideleId);
      expect(fidele!.noeudId, noeudDestinationId);
    });

    test('RG-IX-02 : archive automatiquement la lettre de recommandation quand la mutation est validée', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );
      await repository.validerCote(mutationId: mutation.id, cote: Cote.origine);
      await repository.validerCote(mutationId: mutation.id, cote: Cote.destination);

      final lettre = await repository.lettreDe(mutation.id);
      expect(lettre, isNotNull);

      final document = await archivageRepository.findById(lettre!.documentArchiveId);
      expect(document, isNotNull);
      expect(document!.typeDocument, 'lettre_recommandation');
      expect(document.numeroArchive, startsWith('LR-DESTINATION-'));
    });

    test('sans ArchivageRepository : la mutation se valide quand même, sans lettre (non bloquant)', () async {
      final repositorySansArchivage = DeplacementRepository(db, fideleRepository);
      final mutation = await repositorySansArchivage.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );
      await repositorySansArchivage.validerCote(mutationId: mutation.id, cote: Cote.origine);
      final validee =
          await repositorySansArchivage.validerCote(mutationId: mutation.id, cote: Cote.destination);

      expect(validee.statut, StatutMutation.validee);
      expect(await repositorySansArchivage.lettreDe(mutation.id), isNull);
    });

    test('refuse de traiter une mutation déjà validée', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );
      await repository.validerCote(mutationId: mutation.id, cote: Cote.origine);
      await repository.validerCote(mutationId: mutation.id, cote: Cote.destination);

      expect(
        () => repository.validerCote(mutationId: mutation.id, cote: Cote.origine),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'mutation_non_en_attente')),
      );
    });
  });

  group('refuserMutation', () {
    test('bascule le statut à refusee sans toucher au rattachement du fidèle', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );
      final refusee = await repository.refuserMutation(mutationId: mutation.id, motifRefus: 'Dossier incomplet');

      expect(refusee.statut, StatutMutation.refusee);
      expect(refusee.motifRefus, 'Dossier incomplet');

      final fidele = await fideleRepository.findById(fideleId);
      expect(fidele!.noeudId, noeudOrigineId);
    });

    test('refuse de traiter une mutation déjà refusée', () async {
      final mutation = await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );
      await repository.refuserMutation(mutationId: mutation.id);

      expect(
        () => repository.refuserMutation(mutationId: mutation.id),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'mutation_non_en_attente')),
      );
    });
  });

  group('mutationsDe / watchMutations (RG-IX-03)', () {
    test('mutationsDe retourne l\'historique des mutations du fidèle', () async {
      await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement 1',
      );

      final mutations = await repository.mutationsDe(fideleId);
      expect(mutations, hasLength(1));
      expect(mutations.first.motif, 'Déménagement 1');
    });

    test('watchMutations filtre par nœud (origine ou destination)', () async {
      await repository.demanderMutation(
        fideleId: fideleId,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId,
        motif: 'Déménagement',
      );

      final parOrigine = await repository.watchMutations(noeudId: noeudOrigineId).first;
      final parDestination = await repository.watchMutations(noeudId: noeudDestinationId).first;
      expect(parOrigine, hasLength(1));
      expect(parDestination, hasLength(1));
    });
  });
}
