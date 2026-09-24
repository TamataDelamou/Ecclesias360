import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/finances/data/finances_repository.dart';
import 'package:ecclesias_360/features/finances/domain/models/origine_contribution.dart';
import 'package:ecclesias_360/features/finances/domain/models/periodicite_engagement.dart';
import 'package:ecclesias_360/features/finances/domain/models/statut_contribution.dart';
import 'package:ecclesias_360/features/finances/domain/models/statut_echeance.dart';
import 'package:ecclesias_360/features/finances/domain/models/type_engagement.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // RG-XI-02 : auteur de saisie distinct du valideur des scénarios ci-dessous
  // (la séparation des tâches a ses propres tests).
  const saisissant = 'saisissant-distinct';

  late AppDatabase db;
  late FideleRepository fideleRepository;
  late FinancesRepository repository;
  late String noeudId;
  late String fideleId;
  late String typeOffrandeId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    fideleRepository = FideleRepository(db, SyncCoordinator(db));
    repository = FinancesRepository(db, fideleRepository);

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

    final typeOffrandeRow =
        await (db.select(db.typesOffrande)..where((t) => t.code.equals('dime'))).getSingle();
    typeOffrandeId = typeOffrandeRow.id;
  });

  tearDown(() => db.close());

  test('la base seed les types d\'offrande de départ (RG-XI-01)', () async {
    final types = await db.select(db.typesOffrande).get();
    expect(types, hasLength(5));
    expect(types.every((t) => t.standard), isTrue);
  });

  group('saisirContribution / validerContribution (RG-XI-01/02)', () {
    test('une contribution démarre en attente puis peut être validée par un pasteur', () async {
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      expect(contribution.statut, StatutContribution.enAttente);

      final validee = await repository.validerContribution(
        id: contribution.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fideleId,
      );
      expect(validee.statut, StatutContribution.validee);
      expect(validee.valideParFideleId, fideleId);
      expect(validee.dateValidation, isNotNull);
    });

    test('un trésorier désigné du nœud peut valider sans rang suffisant', () async {
      final tresorierFidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Martin',
        prenoms: 'Alice',
        dateNaissance: DateTime(1985, 1, 1),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.celibataire,
      );
      await repository.designerTresorier(fideleId: tresorierFidele.id, noeudId: noeudId);

      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );

      final validee = await repository.validerContribution(
        id: contribution.id,
        roleActeur: Role.membre,
        valideParFideleId: tresorierFidele.id,
      );
      expect(validee.statut, StatutContribution.validee);
    });

    test('un simple membre sans désignation ne peut pas valider', () async {
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );

      expect(
        () => repository.validerContribution(
          id: contribution.id,
          roleActeur: Role.membre,
          valideParFideleId: fideleId,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'role_insuffisant_pour_validation_contribution')),
      );
    });

    test('une contribution déjà validée ne peut pas être revalidée', () async {
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      await repository.validerContribution(id: contribution.id, roleActeur: Role.pasteur, valideParFideleId: fideleId);

      expect(
        () => repository.validerContribution(id: contribution.id, roleActeur: Role.pasteur, valideParFideleId: fideleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'contribution_non_en_attente')),
      );
    });
  });

  Future<String> saisir() async => (await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      ))
          .id;

  group('séparation saisie/validation (RG-XI-02, RG-SEC-06)', () {
    Future<String> saisirPar(String auteur) async => (await repository.saisirContribution(
          fideleId: fideleId,
          typeOffrandeId: typeOffrandeId,
          montant: 5000,
          devise: 'GNF',
          noeudId: noeudId,
          modePaiement: 'especes',
          origine: OrigineContribution.mobile,
          saisieParFideleId: auteur,
        ))
            .id;

    test("la saisie trace son auteur", () async {
      final id = await saisirPar(fideleId);
      expect((await repository.findContributionById(id))!.saisieParFideleId, fideleId);
    });

    test("l'auteur de la saisie ne la valide pas, même administrateur", () async {
      final id = await saisirPar(fideleId);
      for (final role in [Role.pasteur, Role.administrateur]) {
        await expectLater(
          repository.validerContribution(id: id, roleActeur: role, valideParFideleId: fideleId),
          throwsA(isA<AppError>().having((e) => e.code, 'code', 'decision_par_le_saisissant')),
        );
      }
    });

    test("l'auteur de la saisie ne la rejette pas non plus", () async {
      final id = await saisirPar(fideleId);
      await expectLater(
        repository.rejeterContribution(id: id, roleActeur: Role.pasteur, rejeteParFideleId: fideleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'decision_par_le_saisissant')),
      );
    });

    test('la contre-passation a pour auteur son valideur (acte comptable unique)', () async {
      final id = await saisirPar(saisissant);
      await repository.validerContribution(id: id, roleActeur: Role.pasteur, valideParFideleId: fideleId);
      final contrePassation =
          await repository.contrePasserContribution(id: id, roleActeur: Role.pasteur, valideParFideleId: fideleId);
      expect(contrePassation.saisieParFideleId, fideleId);
      expect(contrePassation.valideParFideleId, fideleId);
    });
  });

  group('rejeterContribution (RG-XI-02)', () {
    test('un pasteur peut rejeter une contribution en attente', () async {
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      final rejetee = await repository.rejeterContribution(
        id: contribution.id,
        roleActeur: Role.pasteur,
        rejeteParFideleId: fideleId,
        motifRejet: 'Doublon suspecté',
      );
      expect(rejetee.statut, StatutContribution.rejetee);
      expect(rejetee.motifRejet, 'Doublon suspecté');
      // Auteur de la décision tracé ; la date de validation reste vide.
      expect(rejetee.valideParFideleId, fideleId);
      expect(rejetee.dateValidation, isNull);
    });

    test('un simple membre, non trésorier du nœud, ne peut pas rejeter', () async {
      final id = await saisir();
      await expectLater(
        repository.rejeterContribution(id: id, roleActeur: Role.membre, rejeteParFideleId: fideleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'role_insuffisant_pour_validation_contribution')),
      );
    });

    test('un trésorier désigné du nœud peut rejeter même au rang membre', () async {
      final id = await saisir();
      await repository.designerTresorier(fideleId: fideleId, noeudId: noeudId);
      final rejetee = await repository.rejeterContribution(id: id, roleActeur: Role.membre, rejeteParFideleId: fideleId);
      expect(rejetee.statut, StatutContribution.rejetee);
    });
  });

  group('contrePasserContribution (RG-XI-05)', () {
    test('crée une nouvelle contribution de montant inverse référençant l\'originale', () async {
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      await repository.validerContribution(id: contribution.id, roleActeur: Role.pasteur, valideParFideleId: fideleId);

      final contrePassation = await repository.contrePasserContribution(
        id: contribution.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fideleId,
        motif: 'Erreur de saisie',
      );
      expect(contrePassation.montant, -5000);
      expect(contrePassation.valideParFideleId, fideleId);
      expect(contrePassation.estContrePassation, isTrue);
      expect(contrePassation.contributionOrigineId, contribution.id);
      expect(contrePassation.statut, StatutContribution.validee);
    });

    test('une contribution non validée ne peut pas être contre-passée', () async {
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      expect(
        () => repository.contrePasserContribution(id: contribution.id, roleActeur: Role.pasteur, valideParFideleId: fideleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'contribution_non_validee_pour_contre_passation')),
      );
    });

    test('un simple membre, non trésorier du nœud, ne peut pas contre-passer (RG-XI-02)', () async {
      final id = await saisir();
      await repository.validerContribution(id: id, roleActeur: Role.pasteur, valideParFideleId: fideleId);
      await expectLater(
        repository.contrePasserContribution(id: id, roleActeur: Role.membre, valideParFideleId: fideleId),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'role_insuffisant_pour_validation_contribution')),
      );
    });
  });

  test('watchNoeudsDuTresorier suit les désignations en fonction seulement', () async {
    expect(await repository.watchNoeudsDuTresorier(fideleId).first, isEmpty);
    final designation = await repository.designerTresorier(fideleId: fideleId, noeudId: noeudId);
    expect(await repository.watchNoeudsDuTresorier(fideleId).first, {noeudId});
    await repository.retirerTresorier(designation.id);
    expect(await repository.watchNoeudsDuTresorier(fideleId).first, isEmpty);
  });

  group('detecterDoublonsPotentiels (RG-XI-06)', () {
    test('une contribution isolée ne se détecte pas elle-même comme doublon', () async {
      final premiere = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.horsLigne,
        saisieParFideleId: saisissant,
      );
      final doublonSimule = (await repository.findContributionById(premiere.id))!;
      final candidats = await repository.detecterDoublonsPotentiels(doublonSimule);
      // La contribution ne peut pas être son propre doublon (exclue par id).
      expect(candidats, isEmpty);
    });

    test('détecte une seconde contribution de même fidèle/montant/minute déjà saisie', () async {
      final premiere = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.horsLigne,
        saisieParFideleId: saisissant,
      );
      // La date de saisie réelle est `DateTime.now()` : les deux saisies du
      // test tombent nécessairement dans la même minute.
      final deuxieme = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.horsLigne,
        saisieParFideleId: saisissant,
      );
      final deuxiemeContribution = (await repository.findContributionById(deuxieme.id))!;
      final candidats = await repository.detecterDoublonsPotentiels(deuxiemeContribution);
      expect(candidats, hasLength(1));
      expect(candidats.first.id, premiere.id);
    });
  });

  group('creerProjet / ajouterDepenseProjet / soldeProjet (RG-XI-03)', () {
    test('le solde recalculé reflète les contributions validées moins les dépenses', () async {
      final projet = await repository.creerProjet(
        noeudId: noeudId,
        nom: 'Rénovation toiture',
        budgetPrevisionnel: 100000,
        devise: 'GNF',
      );

      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 20000,
        devise: 'GNF',
        noeudId: noeudId,
        projetId: projet.id,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      await repository.validerContribution(id: contribution.id, roleActeur: Role.pasteur, valideParFideleId: fideleId);

      expect(await repository.soldeProjet(projet.id), 20000);

      await repository.ajouterDepenseProjet(
        projetId: projet.id,
        montant: 15000,
        libelle: 'Tôles',
        valideParFideleId: fideleId,
      );
      expect(await repository.soldeProjet(projet.id), 5000);
    });

    test('une dépense au-delà du solde est bloquée sans dérogation', () async {
      final projet = await repository.creerProjet(
        noeudId: noeudId,
        nom: 'Rénovation toiture',
        budgetPrevisionnel: 100000,
        devise: 'GNF',
      );

      expect(
        () => repository.ajouterDepenseProjet(
          projetId: projet.id,
          montant: 5000,
          libelle: 'Tôles',
          valideParFideleId: fideleId,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'depense_depasse_solde_sans_derogation')),
      );
    });

    test('une dépense au-delà du solde passe avec une dérogation tracée', () async {
      final projet = await repository.creerProjet(
        noeudId: noeudId,
        nom: 'Rénovation toiture',
        budgetPrevisionnel: 100000,
        devise: 'GNF',
      );

      final depense = await repository.ajouterDepenseProjet(
        projetId: projet.id,
        montant: 5000,
        libelle: 'Avance fournisseur',
        valideParFideleId: fideleId,
        derogationTracee: true,
        motifDerogation: 'Urgence toiture',
      );
      expect(depense.derogationTracee, isTrue);
      expect(await repository.soldeProjet(projet.id), -5000);
    });
  });

  group('creerEngagement / echeancesEnRetard (RG-XI-04)', () {
    test('crée un engagement et génère ses échéances mensuelles', () async {
      final engagement = await repository.creerEngagement(
        fideleId: fideleId,
        type: TypeEngagement.dimeEngagement,
        montantPrevu: 10000,
        periodicite: PeriodiciteEngagement.mensuelle,
        dateDebut: DateTime(2020, 1, 1),
        nombreEcheances: 3,
      );

      final echeances = await repository.watchEcheances(engagement.id).first;
      expect(echeances, hasLength(3));
      expect(echeances.every((e) => e.statut == StatutEcheance.enAttente), isTrue);
    });

    test('une échéance passée non honorée ressort comme en retard', () async {
      final engagement = await repository.creerEngagement(
        fideleId: fideleId,
        type: TypeEngagement.promesseDon,
        montantPrevu: 5000,
        periodicite: PeriodiciteEngagement.mensuelle,
        dateDebut: DateTime(2020, 1, 1),
        nombreEcheances: 1,
      );

      final enRetard = await repository.echeancesEnRetard(maintenant: DateTime(2026, 1, 1));
      expect(enRetard, hasLength(1));

      final echeance = enRetard.first;
      final contribution = await repository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
        saisieParFideleId: saisissant,
      );
      await repository.honorerEcheance(id: echeance.id, contributionId: contribution.id);

      final apresHonoree = await repository.watchEcheances(engagement.id).first;
      expect(apresHonoree.single.statut, StatutEcheance.honoree);
      expect(apresHonoree.single.contributionId, contribution.id);
    });
  });
}
