import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/archivage/data/archivage_repository.dart';
import 'package:ecclesias_360/features/discipline/data/discipline_repository.dart';
import 'package:ecclesias_360/features/discipline/domain/models/nature_piece_dossier.dart';
import 'package:ecclesias_360/features/discipline/domain/models/statut_dossier_disciplinaire.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_spirituel.dart';
import 'package:ecclesias_360/features/ministeres/data/ministere_repository.dart';
import 'package:ecclesias_360/features/ministeres/domain/models/role_affectation.dart';
import 'package:ecclesias_360/features/ministeres/domain/models/statut_affectation.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FideleRepository fideleRepository;
  late MinistereRepository ministereRepository;
  late DisciplineRepository repository;
  late String noeudId;
  late String fideleId;
  late String natureFauteId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    fideleRepository = FideleRepository(db, SyncCoordinator(db));
    ministereRepository = MinistereRepository(db, SyncCoordinator(db));
    repository = DisciplineRepository(db, fideleRepository, ministereRepository);

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

    final fidele = await fideleRepository.creerFidele(
      noeudId: noeudId,
      nom: 'Doe',
      prenoms: 'Jean',
      dateNaissance: DateTime(1980, 1, 1),
      sexe: Sexe.masculin,
      statutCivil: StatutCivil.celibataire,
    );
    fideleId = fidele.id;
    // Fait avancer le fidèle jusqu'à membre actif : `creerFidele` démarre à
    // `visiteur` (RG-II-02), hors du périmètre testé ici.
    await fideleRepository.modifierStatutSpirituel(
      fideleId: fideleId,
      cible: StatutSpirituel.membreActif,
      sautHistorique: true,
    );

    final natureFauteRow =
        await (db.select(db.naturesFaute)..where((t) => t.code.equals('absenteisme_prolonge'))).getSingle();
    natureFauteId = natureFauteRow.id;
  });

  tearDown(() => db.close());

  test('la base seed les natures de faute de départ (RG-X-02)', () async {
    final natures = await db.select(db.naturesFaute).get();
    expect(natures, hasLength(4));
    expect(natures.every((n) => n.standard), isTrue);
  });

  test('watchCommissionsDuFidele ne renvoie que les commissions dont le fidèle est membre (RG-X-05)', () async {
    final sienne = await repository.creerCommission(noeudId: noeudId, nom: 'Commission A');
    await repository.creerCommission(noeudId: noeudId, nom: 'Commission B');
    await repository.ajouterMembreCommission(commissionId: sienne.id, fideleId: fideleId);

    final commissions = await repository.watchCommissionsDuFidele(fideleId).first;
    expect(commissions.map((c) => c.id), [sienne.id]);
    expect(await repository.watchCommissionsDuFidele('inconnu').first, isEmpty);
  });

  group('ouvrirDossier (RG-X-01)', () {
    test('un pasteur peut ouvrir un dossier, le fidèle bascule en discipline', () async {
      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );

      expect(dossier.statut, StatutDossierDisciplinaire.enInstruction);
      expect(dossier.statutSpirituelAnterieur, 'membre_actif');

      final fidele = await fideleRepository.findById(fideleId);
      expect(fidele!.statutSpirituel, StatutSpirituel.membreEnDiscipline);
    });

    test('un simple membre hors commission ne peut pas ouvrir de dossier', () async {
      await expectLater(
        repository.ouvrirDossier(
          fideleId: fideleId,
          noeudId: noeudId,
          natureFauteId: natureFauteId,
          roleActeur: Role.membre,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'role_insuffisant_pour_ouverture_dossier')),
      );
    });

    test('un membre de commission désigné peut ouvrir un dossier', () async {
      final acteur = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Martin',
        prenoms: 'Paul',
        dateNaissance: DateTime(1975, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      final commission = await repository.creerCommission(noeudId: noeudId, nom: 'Commission ordinaire');
      await repository.ajouterMembreCommission(commissionId: commission.id, fideleId: acteur.id);

      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.membre,
        ouvertParFideleId: acteur.id,
      );

      expect(dossier.statut, StatutDossierDisciplinaire.enInstruction);
    });
  });

  group('prononcerDecision / cloturer (RG-X-02/03/04)', () {
    test('exige une commission assignée avant de prononcer une décision', () async {
      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );

      await expectLater(
        repository.prononcerDecision(dossierId: dossier.id, decision: 'Avertissement'),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'commission_requise_pour_decision')),
      );
    });

    test('sanction à durée déterminée : calcule la date de réintégration et suspend les ministères', () async {
      final typeMinistereRow =
          await (db.select(db.typesMinisteres)..where((t) => t.code.equals('chorale'))).getSingle();
      final ministere = await ministereRepository.creerMinistere(
        noeudId: noeudId,
        typeMinistereId: typeMinistereRow.id,
        nom: 'Chorale principale',
      );
      await ministereRepository.affecter(ministereId: ministere.id, fideleId: fideleId, role: RoleAffectation.membre);

      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );
      final commission = await repository.creerCommission(noeudId: noeudId, nom: 'Commission ordinaire');
      await repository.assignerCommission(dossierId: dossier.id, commissionId: commission.id);

      await repository.prononcerDecision(
        dossierId: dossier.id,
        decision: 'Suspension de 30 jours',
        dureeSanctionJours: 30,
        suspendreMinisteres: true,
      );

      final apresDecision = await repository.findDossierById(dossier.id);
      expect(apresDecision!.statut, StatutDossierDisciplinaire.sanctionne);
      expect(apresDecision.dateReintegrationPrevue, isNotNull);
      expect(
        apresDecision.dateReintegrationPrevue!.difference(apresDecision.dateDecision!).inDays,
        30,
      );

      final affectations = await (db.select(db.affectationsMinisteres)
            ..where((t) => t.fideleId.equals(fideleId)))
          .get();
      expect(affectations.single.statut, StatutAffectation.suspendue.code);

      // Clôture : restaure le statut spirituel et réintègre les ministères.
      await repository.cloturer(dossier.id);

      final fideleReintegre = await fideleRepository.findById(fideleId);
      expect(fideleReintegre!.statutSpirituel, StatutSpirituel.membreActif);

      final affectationsApresCloture = await (db.select(db.affectationsMinisteres)
            ..where((t) => t.fideleId.equals(fideleId)))
          .get();
      expect(affectationsApresCloture.single.statut, StatutAffectation.active.code);

      final dossierClos = await repository.findDossierById(dossier.id);
      expect(dossierClos!.statut, StatutDossierDisciplinaire.clos);
    });

    test('clôture impossible sans décision préalable', () async {
      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );

      await expectLater(
        repository.cloturer(dossier.id),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'dossier_disciplinaire_non_sanctionne')),
      );
    });
  });

  group('pièces (RG-X-02/06)', () {
    test('sans dépôt d\'archivage injecté, documentArchiveId reste null (même précédent que le PV du Comité)', () async {
      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );

      final piece = await repository.ajouterPiece(
        dossierId: dossier.id,
        nature: NaturePieceDossier.temoignage,
        contenu: 'Témoignage écrit du responsable de nœud.',
        noeudId: noeudId,
      );

      expect(piece.documentArchiveId, isNull);
      final pieces = await repository.watchPieces(dossier.id).first;
      expect(pieces, hasLength(1));
    });
  });

  group('dossiersEnAlerteFinDePeriode / dossiersEnRevuePeriodique (RG-X-04)', () {
    test('un dossier à durée déterminée arrivée à échéance est signalé', () async {
      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );
      final commission = await repository.creerCommission(noeudId: noeudId, nom: 'Commission ordinaire');
      await repository.assignerCommission(dossierId: dossier.id, commissionId: commission.id);
      await repository.prononcerDecision(dossierId: dossier.id, decision: 'Suspension', dureeSanctionJours: 1);

      final enAlerte = await repository.dossiersEnAlerteFinDePeriode(
        maintenant: DateTime.now().add(const Duration(days: 2)),
      );
      expect(enAlerte.map((d) => d.id), contains(dossier.id));

      final pasEncore = await repository.dossiersEnAlerteFinDePeriode(maintenant: DateTime.now());
      expect(pasEncore.map((d) => d.id), isNot(contains(dossier.id)));
    });

    test('un dossier à durée indéterminée nécessite une revue passé le seuil', () async {
      final dossier = await repository.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );
      final commission = await repository.creerCommission(noeudId: noeudId, nom: 'Commission ordinaire');
      await repository.assignerCommission(dossierId: dossier.id, commissionId: commission.id);
      await repository.prononcerDecision(dossierId: dossier.id, decision: 'Suspension indéterminée');

      final enRevue = await repository.dossiersEnRevuePeriodique(
        seuilJours: 90,
        maintenant: DateTime.now().add(const Duration(days: 91)),
      );
      expect(enRevue.map((d) => d.id), contains(dossier.id));

      final pasEncore = await repository.dossiersEnRevuePeriodique(seuilJours: 90, maintenant: DateTime.now());
      expect(pasEncore.map((d) => d.id), isNot(contains(dossier.id)));
    });
  });

  group('consultation et journal (RG-X-05, RG-VIII-03, RG-SEC-06)', () {
    late ArchivageRepository archivage;
    late DisciplineRepository disciplineAvecArchives;
    late String dossierId;
    late String documentId;
    late String membreCommissionId;

    setUp(() async {
      archivage = ArchivageRepository(db);
      disciplineAvecArchives =
          DisciplineRepository(db, fideleRepository, ministereRepository, archivageRepository: archivage);
      final membre = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Commission',
        prenoms: 'Claire',
        dateNaissance: DateTime(1985, 1, 1),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.celibataire,
      );
      membreCommissionId = membre.id;
      final commission = await disciplineAvecArchives.creerCommission(noeudId: noeudId, nom: 'Commission K');
      await disciplineAvecArchives.ajouterMembreCommission(commissionId: commission.id, fideleId: membreCommissionId);
      final dossier = await disciplineAvecArchives.ouvrirDossier(
        fideleId: fideleId,
        noeudId: noeudId,
        natureFauteId: natureFauteId,
        roleActeur: Role.pasteur,
      );
      dossierId = dossier.id;
      await disciplineAvecArchives.assignerCommission(dossierId: dossierId, commissionId: commission.id);
      final piece = await disciplineAvecArchives.ajouterPiece(
        dossierId: dossierId,
        nature: NaturePieceDossier.temoignage,
        contenu: 'Témoignage écrit',
        noeudId: noeudId,
      );
      documentId = piece.documentArchiveId!;
    });

    Future<int> lignesDuJournal() async => (await db.select(db.consultationsDisciplinaires).get()).length;

    test('la pièce archivée connaît son dossier et sa commission', () async {
      final documents = await archivage.watchBibliotheque(noeudId: noeudId).first;
      final rattaches = documents.single.dossiersRattaches;
      expect(rattaches.map((d) => d.dossierId), [dossierId]);
      expect(rattaches.single.commissionId, isNotNull);
    });

    test('un responsable hors commission ne lit ni le dossier ni la pièce, et rien n\'est journalisé', () async {
      await expectLater(
        disciplineAvecArchives.consulterDossier(
          dossierId: dossierId,
          authUserId: 'compte-r',
          fideleId: fideleId,
          role: Role.responsable,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'dossier_disciplinaire_acces_refuse')),
      );
      await expectLater(
        archivage.consulter(documentId: documentId, authUserId: 'compte-r', fideleId: fideleId, role: Role.responsable),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'document_archive_acces_refuse')),
      );
      expect(await lignesDuJournal(), 0);
    });

    test('la commission lit le dossier puis la pièce : deux consultations journalisées', () async {
      await disciplineAvecArchives.consulterDossier(
        dossierId: dossierId,
        authUserId: 'compte-c',
        fideleId: membreCommissionId,
        role: Role.membre,
      );
      await archivage.consulter(
        documentId: documentId,
        authUserId: 'compte-c',
        fideleId: membreCommissionId,
        role: Role.membre,
      );

      final journal = await disciplineAvecArchives.watchConsultations(dossierId).first;
      expect(journal, hasLength(2));
      expect(journal.every((c) => c.authUserId == 'compte-c' && c.fideleId == membreCommissionId), isTrue);
      expect(journal.where((c) => c.documentArchiveId == documentId), hasLength(1));
      expect(journal.where((c) => c.documentArchiveId == null), hasLength(1));
    });

    test('un document ordinaire n\'est pas journalisé', () async {
      await db.into(db.nomenclaturesArchivage).insertOnConflictUpdate(
            NomenclaturesArchivageCompanion.insert(id: 'nom-pv', typeDocument: 'pv_test', modeleNumerotation: 'PV-{sequence}'),
          );
      final pv = await archivage.archiver(
        typeDocument: 'pv_test',
        moduleOrigine: 'comite',
        objetIdOrigine: 'seance-1',
        noeudId: noeudId,
        fichier: 'pv.pdf',
      );
      await archivage.consulter(documentId: pv.id, authUserId: 'compte-r', fideleId: null, role: Role.responsable);
      expect(await lignesDuJournal(), 0);
    });
  });
}
