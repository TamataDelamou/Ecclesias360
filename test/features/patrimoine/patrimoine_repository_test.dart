import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/features/patrimoine/data/patrimoine_repository.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/etat_bien.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/objet_reservation.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/type_mouvement_stock.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/type_sortie_bien.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FideleRepository fideleRepository;
  late PatrimoineRepository repository;
  late String noeudId;
  late String fideleId;
  late String categorieMobilierId;
  late String categorieStocksId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    fideleRepository = FideleRepository(db, SyncCoordinator(db));
    repository = PatrimoineRepository(db);

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

    categorieMobilierId =
        (await (db.select(db.categoriesBien)..where((t) => t.code.equals('mobilier'))).getSingle()).id;
    categorieStocksId =
        (await (db.select(db.categoriesBien)..where((t) => t.code.equals('stocks'))).getSingle()).id;
  });

  tearDown(() => db.close());

  test('la base seed les neuf catégories de biens de départ (RG-XX-01)', () async {
    final categories = await db.select(db.categoriesBien).get();
    expect(categories, hasLength(9));
    expect(categories.every((c) => c.standard), isTrue);
  });

  group('ajouterBien / signalerEtat / sortirBien (RG-XX-01/02)', () {
    test('un bien est créé avec l\'état neuf par défaut', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-0001',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Chaises de la grande salle',
        valeurAcquisition: 500000,
        valeurVenale: 300000,
        devise: 'GNF',
        dateAcquisition: DateTime(2024, 1, 1),
      );
      expect(bien.etat, EtatBien.neuf);
      expect(bien.idInventaire, 'INV-0001');
    });

    test('signalerEtat met à jour l\'état sans créer de ligne d\'historique dédiée', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-0002',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Sonorisation portable',
        valeurAcquisition: 800000,
        valeurVenale: 400000,
        devise: 'GNF',
        dateAcquisition: DateTime(2024, 1, 1),
      );
      final signale = await repository.signalerEtat(id: bien.id, nouvelEtat: EtatBien.aReparer);
      expect(signale.etat, EtatBien.aReparer);
    });

    test('un pasteur peut sortir un bien (cession) qui devient l\'état cédé', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-0003',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Ancien véhicule de service',
        valeurAcquisition: 10000000,
        valeurVenale: 2000000,
        devise: 'GNF',
        dateAcquisition: DateTime(2020, 1, 1),
      );
      final sorti = await repository.sortirBien(
        id: bien.id,
        roleActeur: Role.pasteur,
        typeSortie: TypeSortieBien.cession,
        valideParFideleId: fideleId,
        motif: 'Renouvellement du parc automobile',
      );
      expect(sorti.etat, EtatBien.cede);
      expect(sorti.typeSortie, TypeSortieBien.cession);
      expect(sorti.valideParFideleIdSortie, fideleId);
    });

    test('un rôle insuffisant ne peut pas sortir un bien (RG-XX-02)', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-0004',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Ordinateur portable',
        valeurAcquisition: 3000000,
        valeurVenale: 1000000,
        devise: 'GNF',
        dateAcquisition: DateTime(2023, 1, 1),
      );
      expect(
        () => repository.sortirBien(
          id: bien.id,
          roleActeur: Role.responsable,
          typeSortie: TypeSortieBien.miseAuRebut,
          valideParFideleId: fideleId,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'role_insuffisant_pour_sortie_bien')),
      );
    });

    test('un bien déjà sorti ne peut pas être sorti à nouveau', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-0005',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Photocopieuse hors service',
        valeurAcquisition: 1500000,
        valeurVenale: 100000,
        devise: 'GNF',
        dateAcquisition: DateTime(2018, 1, 1),
      );
      await repository.sortirBien(
        id: bien.id,
        roleActeur: Role.pasteur,
        typeSortie: TypeSortieBien.miseAuRebut,
        valideParFideleId: fideleId,
      );
      expect(
        () => repository.sortirBien(
          id: bien.id,
          roleActeur: Role.administrateur,
          typeSortie: TypeSortieBien.don,
          valideParFideleId: fideleId,
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'bien_deja_sorti')),
      );
    });
  });

  group('reserverBien (RG-XX-03)', () {
    late String bienId;

    setUp(() async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-1000',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Instrument de musique',
        valeurAcquisition: 2000000,
        valeurVenale: 1500000,
        devise: 'GNF',
        dateAcquisition: DateTime(2022, 1, 1),
      );
      bienId = bien.id;
    });

    test('une réservation sans conflit est acceptée', () async {
      final reservation = await repository.reserverBien(
        bienId: bienId,
        objetReservation: ObjetReservation.culte,
        dateDebut: DateTime(2026, 3, 1, 9),
        dateFin: DateTime(2026, 3, 1, 12),
      );
      expect(reservation.bienId, bienId);
    });

    test('une seconde réservation qui chevauche la première est bloquée', () async {
      await repository.reserverBien(
        bienId: bienId,
        objetReservation: ObjetReservation.culte,
        dateDebut: DateTime(2026, 3, 1, 9),
        dateFin: DateTime(2026, 3, 1, 12),
      );
      expect(
        () => repository.reserverBien(
          bienId: bienId,
          objetReservation: ObjetReservation.evenement,
          objetLibre: 'Concert de louange',
          dateDebut: DateTime(2026, 3, 1, 11),
          dateFin: DateTime(2026, 3, 1, 15),
        ),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'reservation_conflit_detecte')),
      );
    });

    test('une réservation sur une plage disjointe n\'est pas bloquée', () async {
      await repository.reserverBien(
        bienId: bienId,
        objetReservation: ObjetReservation.culte,
        dateDebut: DateTime(2026, 3, 1, 9),
        dateFin: DateTime(2026, 3, 1, 12),
      );
      final seconde = await repository.reserverBien(
        bienId: bienId,
        objetReservation: ObjetReservation.autre,
        objetLibre: 'Répétition de chorale',
        dateDebut: DateTime(2026, 3, 1, 14),
        dateFin: DateTime(2026, 3, 1, 16),
      );
      expect(seconde.bienId, bienId);
    });
  });

  group('mouvements de stock / seuil d\'alerte (RG-XX-05)', () {
    test('la quantité en stock se recalcule à partir des mouvements', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-2000',
        categorieId: categorieStocksId,
        noeudId: noeudId,
        designation: 'Cahiers de chants',
        valeurAcquisition: 500000,
        valeurVenale: 500000,
        devise: 'GNF',
        dateAcquisition: DateTime(2026, 1, 1),
        seuilAlerteStock: 10,
      );
      await repository.enregistrerMouvementStock(bienId: bien.id, type: TypeMouvementStock.entree, quantite: 50);
      await repository.enregistrerMouvementStock(bienId: bien.id, type: TypeMouvementStock.sortie, quantite: 45);

      final quantite = await repository.quantiteStock(bien.id);
      expect(quantite, 5);

      final sousAlerte = await repository.biensSousSeuilAlerte(noeudId);
      expect(sousAlerte.map((b) => b.id), contains(bien.id));
    });

    test('un bien au-dessus de son seuil n\'apparaît pas dans les alertes', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-2001',
        categorieId: categorieStocksId,
        noeudId: noeudId,
        designation: 'Bibles',
        valeurAcquisition: 1000000,
        valeurVenale: 1000000,
        devise: 'GNF',
        dateAcquisition: DateTime(2026, 1, 1),
        seuilAlerteStock: 10,
      );
      await repository.enregistrerMouvementStock(bienId: bien.id, type: TypeMouvementStock.entree, quantite: 50);

      final sousAlerte = await repository.biensSousSeuilAlerte(noeudId);
      expect(sousAlerte.map((b) => b.id), isNot(contains(bien.id)));
    });
  });

  group('campagnes d\'inventaire et pointages (RG-XX-04)', () {
    test('un pointage sans écart ne signale rien', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-3000',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Bureau du pasteur',
        valeurAcquisition: 700000,
        valeurVenale: 500000,
        devise: 'GNF',
        dateAcquisition: DateTime(2021, 1, 1),
      );
      final campagne = await repository.demarrerCampagne(noeudId: noeudId, libelle: 'Recensement 2026');
      final pointage = await repository.enregistrerPointage(
        campagneId: campagne.id,
        bienId: bien.id,
        etatConstate: EtatBien.neuf,
      );
      expect(pointage.ecartDetecte, isFalse);
    });

    test('un état constaté différent de l\'état déclaré signale un écart', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-3001',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Vidéoprojecteur',
        valeurAcquisition: 2000000,
        valeurVenale: 800000,
        devise: 'GNF',
        dateAcquisition: DateTime(2021, 1, 1),
      );
      final campagne = await repository.demarrerCampagne(noeudId: noeudId, libelle: 'Recensement 2026');
      final pointage = await repository.enregistrerPointage(
        campagneId: campagne.id,
        bienId: bien.id,
        etatConstate: EtatBien.horsService,
        commentaire: 'Appareil retrouvé hors service',
      );
      expect(pointage.ecartDetecte, isTrue);
    });

    test('aucun nouveau pointage n\'est possible sur une campagne clôturée', () async {
      final bien = await repository.ajouterBien(
        idInventaire: 'INV-3002',
        categorieId: categorieMobilierId,
        noeudId: noeudId,
        designation: 'Piano',
        valeurAcquisition: 5000000,
        valeurVenale: 3000000,
        devise: 'GNF',
        dateAcquisition: DateTime(2019, 1, 1),
      );
      final campagne = await repository.demarrerCampagne(noeudId: noeudId, libelle: 'Recensement clos');
      await repository.cloturerCampagne(campagne.id);

      expect(
        () => repository.enregistrerPointage(campagneId: campagne.id, bienId: bien.id, etatConstate: EtatBien.bon),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'campagne_inventaire_deja_cloturee')),
      );
    });
  });
}
