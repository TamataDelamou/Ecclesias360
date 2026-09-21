import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/comptabilite/data/comptabilite_repository.dart';
import 'package:ecclesias_360/features/comptabilite/domain/models/statut_periode_comptable.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/finances/data/finances_repository.dart';
import 'package:ecclesias_360/features/finances/domain/models/origine_contribution.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/features/patrimoine/data/patrimoine_repository.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/type_sortie_bien.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ComptabiliteRepository repository;
  late String noeudId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = ComptabiliteRepository(db);

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

  test('la base seed le plan comptable et la période courante de départ (RG-XXI-01/03)', () async {
    final comptes = await db.select(db.comptesComptables).get();
    expect(comptes, hasLength(7));

    final periodes = await db.select(db.periodesComptables).get();
    expect(periodes, hasLength(1));
    expect(periodes.single.exercice, DateTime.now().year);
    expect(periodes.single.statut, StatutPeriodeComptable.ouverte.code);
  });

  group('genererEcecturesContributionValidee (RG-XXI-02), via FinancesRepository', () {
    late FideleRepository fideleRepository;
    late FinancesRepository financesRepository;
    late String fideleId;
    late String typeOffrandeId;

    setUp(() async {
      fideleRepository = FideleRepository(db, SyncCoordinator(db));
      financesRepository = FinancesRepository(db, fideleRepository, comptabiliteRepository: repository);

      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      fideleId = fidele.id;

      final typeOffrandeRow = await (db.select(db.typesOffrande)..where((t) => t.code.equals('dime'))).getSingle();
      typeOffrandeId = typeOffrandeRow.id;
    });

    test('la validation d\'une contribution génère deux lignes équilibrées (débit caisse / crédit produits)', () async {
      final contribution = await financesRepository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
      );

      await financesRepository.validerContribution(
        id: contribution.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fideleId,
      );

      final ecritures = await repository.watchEcritures(noeudId).first;
      expect(ecritures, hasLength(2));
      expect(ecritures.every((e) => e.pieceJustificativeId == contribution.id), isTrue);

      final compteCaisse = (await repository.trouverCompteParCode('530000'))!;
      final compteProduits = (await repository.trouverCompteParCode('706000'))!;

      final ligneCaisse = ecritures.firstWhere((e) => e.compteId == compteCaisse.id);
      final ligneProduits = ecritures.firstWhere((e) => e.compteId == compteProduits.id);
      expect(ligneCaisse.debit, 5000);
      expect(ligneCaisse.credit, 0);
      expect(ligneProduits.credit, 5000);
      expect(ligneProduits.debit, 0);

      final soldeCaisse = await repository.soldeCompte(noeudId: noeudId, compteId: compteCaisse.id);
      expect(soldeCaisse, 5000);
    });

    test('la contre-passation d\'une contribution génère une écriture inversée (comptes échangés)', () async {
      final contribution = await financesRepository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
      );
      await financesRepository.validerContribution(
        id: contribution.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fideleId,
      );
      final contrePassee = await financesRepository.contrePasserContribution(id: contribution.id, motif: 'Erreur de saisie');

      final ecritures = await repository.watchEcritures(noeudId).first;
      // 2 lignes pour la contribution d'origine + 2 pour la contre-passation.
      expect(ecritures, hasLength(4));

      final compteCaisse = (await repository.trouverCompteParCode('530000'))!;
      final compteProduits = (await repository.trouverCompteParCode('706000'))!;

      final lignesContrePassation = ecritures.where((e) => e.pieceJustificativeId == contrePassee.id).toList();
      expect(lignesContrePassation, hasLength(2));
      final ligneCaisse = lignesContrePassation.firstWhere((e) => e.compteId == compteCaisse.id);
      final ligneProduits = lignesContrePassation.firstWhere((e) => e.compteId == compteProduits.id);
      // Comptes échangés par rapport à la validation initiale.
      expect(ligneCaisse.credit, 5000);
      expect(ligneCaisse.debit, 0);
      expect(ligneProduits.debit, 5000);
      expect(ligneProduits.credit, 0);

      // Le solde de caisse net redevient nul.
      final soldeCaisse = await repository.soldeCompte(noeudId: noeudId, compteId: compteCaisse.id);
      expect(soldeCaisse, 0);
    });
  });

  group('genererEcecturesSortieBien (RG-XXI-02), via PatrimoineRepository', () {
    late FideleRepository fideleRepository;
    late PatrimoineRepository patrimoineRepository;
    late String fideleId;
    late String categorieMobilierId;

    setUp(() async {
      fideleRepository = FideleRepository(db, SyncCoordinator(db));
      patrimoineRepository = PatrimoineRepository(db, comptabiliteRepository: repository);

      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      fideleId = fidele.id;

      categorieMobilierId =
          (await (db.select(db.categoriesBien)..where((t) => t.code.equals('mobilier'))).getSingle()).id;
    });

    test('la sortie d\'un bien génère la mirroir (débit charges / crédit immobilisations)', () async {
      final bien = await patrimoineRepository.ajouterBien(
        idInventaire: 'INV-0001',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Chaises',
        valeurAcquisition: 500000,
        valeurVenale: 300000,
        devise: 'GNF',
        dateAcquisition: DateTime(2026, 1, 1),
      );

      await patrimoineRepository.sortirBien(
        id: bien.id,
        roleActeur: Role.pasteur,
        typeSortie: TypeSortieBien.miseAuRebut,
        valideParFideleId: fideleId,
        motif: 'Bien obsolète',
      );

      final ecritures = await repository.watchEcritures(noeudId).first;
      expect(ecritures, hasLength(2));
      expect(ecritures.every((e) => e.pieceJustificativeId == bien.id), isTrue);

      final compteCharges = (await repository.trouverCompteParCode('675000'))!;
      final compteImmobilisations = (await repository.trouverCompteParCode('211000'))!;

      final ligneCharges = ecritures.firstWhere((e) => e.compteId == compteCharges.id);
      final ligneImmobilisations = ecritures.firstWhere((e) => e.compteId == compteImmobilisations.id);
      expect(ligneCharges.debit, 300000);
      expect(ligneImmobilisations.credit, 300000);
    });
  });

  group('soldeCompte avec inclureDescendants (RG-XXI-06)', () {
    late FideleRepository fideleRepository;
    late FinancesRepository financesRepository;
    late String fideleId;
    late String typeOffrandeId;
    late String noeudEnfantId;

    setUp(() async {
      noeudEnfantId = 'noeud-enfant-1';
      await db.into(db.organisationNodes).insert(
            OrganisationNodesCompanion.insert(
              id: noeudEnfantId,
              typeNoeud: 'paroisse',
              nom: 'Paroisse A',
              codeInterne: 'PAR-A',
              noeudParentId: Value(noeudId),
              path: '/$noeudId/$noeudEnfantId/',
              depth: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      fideleRepository = FideleRepository(db, SyncCoordinator(db));
      financesRepository = FinancesRepository(db, fideleRepository, comptabiliteRepository: repository);

      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      fideleId = fidele.id;

      final typeOffrandeRow = await (db.select(db.typesOffrande)..where((t) => t.code.equals('dime'))).getSingle();
      typeOffrandeId = typeOffrandeRow.id;
    });

    test('sans inclureDescendants, seul le nœud demandé est agrégé', () async {
      final contributionParent = await financesRepository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
      );
      await financesRepository.validerContribution(
        id: contributionParent.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fideleId,
      );

      final contributionEnfant = await financesRepository.saisirContribution(
        fideleId: fideleId,
        typeOffrandeId: typeOffrandeId,
        montant: 2000,
        devise: 'GNF',
        noeudId: noeudEnfantId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
      );
      await financesRepository.validerContribution(
        id: contributionEnfant.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fideleId,
      );

      final compteCaisse = (await repository.trouverCompteParCode('530000'))!;

      final soldeParentSeul = await repository.soldeCompte(noeudId: noeudId, compteId: compteCaisse.id);
      expect(soldeParentSeul, 5000);

      final soldeConsolide =
          await repository.soldeCompte(noeudId: noeudId, compteId: compteCaisse.id, inclureDescendants: true);
      expect(soldeConsolide, 7000);
    });
  });

  group('cloturerPeriode (RG-XXI-03)', () {
    test('un responsable ne peut pas clôturer une période', () async {
      final periode = (await db.select(db.periodesComptables).get()).single;
      await expectLater(
        () => repository.cloturerPeriode(id: periode.id, roleActeur: Role.responsable),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'role_insuffisant_pour_cloture_comptable')),
      );
    });

    test('un pasteur peut clôturer, et plus aucune écriture n\'est possible sans période ouverte', () async {
      final fideleRepository = FideleRepository(db, SyncCoordinator(db));
      final financesRepository = FinancesRepository(db, fideleRepository, comptabiliteRepository: repository);
      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      final typeOffrandeRow = await (db.select(db.typesOffrande)..where((t) => t.code.equals('dime'))).getSingle();

      final periode = (await db.select(db.periodesComptables).get()).single;
      await repository.cloturerPeriode(id: periode.id, roleActeur: Role.pasteur);

      final periodes = await repository.watchPeriodes().first;
      expect(periodes.single.statut, StatutPeriodeComptable.cloturee);

      final contribution = await financesRepository.saisirContribution(
        fideleId: fidele.id,
        typeOffrandeId: typeOffrandeRow.id,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
      );

      // `genererEcecturesContributionValidee` cible toujours la période
      // ouverte la plus récente (`periodeCouranteOuverte`) : une fois
      // l'unique période clôturée, plus aucune n'est ouverte — le blocage
      // d'écriture sur une période close (`ComptabiliteRules.raisonBlocageEcritureSurPeriode`,
      // vérifié en isolation dans `comptabilite_rules_test.dart`) ne peut
      // être atteint depuis les producteurs qu'en présence d'une période
      // ouverte différente de celle visée par l'écriture — ici, l'absence
      // totale de période ouverte est elle-même bloquante.
      await expectLater(
        () => financesRepository.validerContribution(
          id: contribution.id,
          roleActeur: Role.pasteur,
          valideParFideleId: fidele.id,
        ),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('budgets (RG-XXI-04)', () {
    test('budgetDepasse détecte le dépassement du seuil paramétré', () async {
      final periode = (await db.select(db.periodesComptables).get()).single;
      final compteCharges = (await repository.trouverCompteParCode('651000'))!;

      final budget = await repository.definirBudget(
        noeudId: noeudId,
        periodeId: periode.id,
        compteId: compteCharges.id,
        montantPrevu: 100000,
        seuilAlertePourcentage: 50,
      );

      expect(await repository.budgetDepasse(budget), isFalse);

      // Engage manuellement 60% du budget (compte charge : le débit
      // augmente le solde, donc l'engagement).
      await db.into(db.ecrituresComptables).insert(
            EcrituresComptablesCompanion.insert(
              id: 'ecriture-manuelle-1',
              date: DateTime.now(),
              compteId: compteCharges.id,
              debit: const Value(60000),
              noeudId: noeudId,
              periodeId: periode.id,
            ),
          );

      expect(await repository.budgetDepasse(budget), isTrue);
    });

    test('budgetDepasse retombe sur le seuil par défaut quand aucun n\'est fourni', () async {
      final periode = (await db.select(db.periodesComptables).get()).single;
      final compteCharges = (await repository.trouverCompteParCode('651000'))!;

      final budget = await repository.definirBudget(
        noeudId: noeudId,
        periodeId: periode.id,
        compteId: compteCharges.id,
        montantPrevu: 100000,
      );

      expect(budget.seuilAlertePourcentage, isNull);
      expect(await repository.budgetDepasse(budget), isFalse);
    });
  });

  group('rapprochement bancaire (RG-XXI-05)', () {
    test('ecartRapprochement et marquerRapprochees', () async {
      final fideleRepository = FideleRepository(db, SyncCoordinator(db));
      final financesRepository = FinancesRepository(db, fideleRepository, comptabiliteRepository: repository);
      final fidele = await fideleRepository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Jean',
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.masculin,
        statutCivil: StatutCivil.celibataire,
      );
      final typeOffrandeRow = await (db.select(db.typesOffrande)..where((t) => t.code.equals('dime'))).getSingle();

      final contribution = await financesRepository.saisirContribution(
        fideleId: fidele.id,
        typeOffrandeId: typeOffrandeRow.id,
        montant: 5000,
        devise: 'GNF',
        noeudId: noeudId,
        modePaiement: 'especes',
        origine: OrigineContribution.mobile,
      );
      await financesRepository.validerContribution(
        id: contribution.id,
        roleActeur: Role.pasteur,
        valideParFideleId: fidele.id,
      );

      final compteCaisse = (await repository.trouverCompteParCode('530000'))!;

      final ecart = await repository.ecartRapprochement(noeudId: noeudId, compteId: compteCaisse.id, soldeReleve: 4800);
      expect(ecart, 200);

      final ecritures = await repository.watchEcritures(noeudId).first;
      expect(ecritures.every((e) => e.rapproche == false), isTrue);

      await repository.marquerRapprochees(ecritures.map((e) => e.id).toList());
      final apresRapprochement = await repository.watchEcritures(noeudId).first;
      expect(apresRapprochement.every((e) => e.rapproche == true), isTrue);
    });
  });
}
