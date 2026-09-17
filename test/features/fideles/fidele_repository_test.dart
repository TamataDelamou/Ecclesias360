import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_fidele.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_spirituel.dart';
import 'package:ecclesias_360/features/fideles/domain/models/type_lien.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FideleRepository repository;
  late String noeudId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final syncCoordinator = SyncCoordinator(db);
    repository = FideleRepository(db, syncCoordinator);

    final organisationRepository = OrganisationNodeRepository(db, syncCoordinator);
    final siege = await organisationRepository.creerNoeud(
      typeNoeud: TypeNoeud.siege,
      noeudParentId: null,
      nom: 'Siège',
      codeInterne: 'SIEGE',
    );
    noeudId = siege.id;
  });

  tearDown(() => db.close());

  Future<String> creerFideleMajeur({DateTime? dateNaissance}) async {
    final fidele = await repository.creerFidele(
      noeudId: noeudId,
      nom: 'Doe',
      prenoms: 'Jean',
      dateNaissance: dateNaissance ?? DateTime(1990, 1, 1),
      sexe: Sexe.masculin,
      statutCivil: StatutCivil.celibataire,
    );
    return fidele.id;
  }

  group('creerFidele (RG-II-01)', () {
    test('crée un fidèle avec statut spirituel visiteur et statut actif par défaut', () async {
      final id = await creerFideleMajeur();
      final fidele = await repository.findById(id);

      expect(fidele, isNotNull);
      expect(fidele!.statutSpirituel, StatutSpirituel.visiteur);
      expect(fidele.statut, StatutFidele.actif);
    });

    test('refuse un noeud_id inexistant (contrainte FK réellement appliquée)', () async {
      expect(
        () => repository.creerFidele(
          noeudId: 'noeud-inexistant',
          nom: 'Doe',
          prenoms: 'Jean',
          dateNaissance: DateTime(1990, 1, 1),
          sexe: Sexe.masculin,
          statutCivil: StatutCivil.celibataire,
        ),
        throwsA(anything),
      );
    });
  });

  group('modifierStatutSpirituel (RG-II-02/03/05/06)', () {
    test('progression valide et historisée', () async {
      final id = await creerFideleMajeur();
      await repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.nouveauConverti);

      final fidele = await repository.findById(id);
      expect(fidele!.statutSpirituel, StatutSpirituel.nouveauConverti);

      final historique = await db.select(db.historiqueFideles).get();
      expect(historique, hasLength(1));
      expect(historique.single.champModifie, 'statut_spirituel');
      expect(historique.single.ancienneValeur, 'visiteur');
      expect(historique.single.nouvelleValeur, 'nouveau_converti');
    });

    test('saut de cran est rejeté', () async {
      final id = await creerFideleMajeur();
      expect(
        () => repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.membreActif),
        throwsArgumentError,
      );
    });

    test('baptême d\'un mineur sans tuteur est rejeté (RG-II-06)', () async {
      final id = await creerFideleMajeur(dateNaissance: DateTime.now().subtract(const Duration(days: 365 * 10)));
      await repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.nouveauConverti);

      expect(
        () => repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.baptise),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'mineur_sans_tuteur')),
      );
    });

    test('baptême d\'un mineur avec tuteur enregistré est autorisé', () async {
      final id = await creerFideleMajeur(dateNaissance: DateTime.now().subtract(const Duration(days: 365 * 10)));
      await repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.nouveauConverti);
      await repository.ajouterTuteur(mineurId: id, lien: 'père', tuteurTiersNom: 'Jean Tiers');

      await repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.baptise);
      final fidele = await repository.findById(id);
      expect(fidele!.statutSpirituel, StatutSpirituel.baptise);
      expect(fidele.dateBapteme, isNotNull);
    });

    test('passage direct à membre en discipline hors module X est rejeté', () async {
      final id = await creerFideleMajeur();
      expect(
        () => repository.modifierStatutSpirituel(fideleId: id, cible: StatutSpirituel.membreEnDiscipline),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'statut_discipline_reserve_au_module_x')),
      );
    });
  });

  group('modifierCoordonnees (RG-II-05)', () {
    test('historise chaque champ modifié séparément', () async {
      final id = await creerFideleMajeur();
      await repository.modifierCoordonnees(fideleId: id, telephone: '+22890000000', email: 'jean@example.com');

      final fidele = await repository.findById(id);
      expect(fidele!.telephone, '+22890000000');
      expect(fidele.email, 'jean@example.com');

      final historique = await db.select(db.historiqueFideles).get();
      expect(historique, hasLength(2));
      expect(historique.map((h) => h.champModifie).toSet(), {'telephone', 'email'});
    });
  });

  group('ajouterTuteur (RG-II-06)', () {
    test('refuse si ni fidèle enregistré ni tiers renseigné', () async {
      final id = await creerFideleMajeur();
      expect(
        () => repository.ajouterTuteur(mineurId: id, lien: 'père'),
        throwsArgumentError,
      );
    });
  });

  group('liens familiaux (RG-II-04)', () {
    test('retirer un lien familial ne supprime pas les fidèles liés', () async {
      final id1 = await creerFideleMajeur();
      final id2 = await repository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Marie',
        dateNaissance: DateTime(1992, 3, 3),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.marie,
      ).then((f) => f.id);

      await repository.ajouterLienFamilial(fideleId1: id1, fideleId2: id2, typeLien: TypeLien.conjoint);
      final liens = await db.select(db.liensFamiliaux).get();
      expect(liens, hasLength(1));

      await repository.retirerLienFamilial(liens.single.id);

      expect(await repository.findById(id1), isNotNull);
      expect(await repository.findById(id2), isNotNull);
      expect(await db.select(db.liensFamiliaux).get(), isEmpty);
    });
  });

  group('supprimerFidele (RG-II-08)', () {
    test('refuse la suppression si un lien familial existe', () async {
      final id1 = await creerFideleMajeur();
      final id2 = await repository.creerFidele(
        noeudId: noeudId,
        nom: 'Doe',
        prenoms: 'Marie',
        dateNaissance: DateTime(1992, 3, 3),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.marie,
      ).then((f) => f.id);
      await repository.ajouterLienFamilial(fideleId1: id1, fideleId2: id2, typeLien: TypeLien.conjoint);

      expect(
        () => repository.supprimerFidele(id1),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'fidele_has_blocking_references')),
      );
    });

    test('autorise la suppression sans rattachement', () async {
      final id = await creerFideleMajeur();
      await repository.supprimerFidele(id);
      expect(await repository.findById(id), isNull);
    });
  });

  group('archiverFidele (RG-II-08)', () {
    test('passe le statut à inactif sans supprimer la fiche', () async {
      final id = await creerFideleMajeur();
      await repository.archiverFidele(id);
      final fidele = await repository.findById(id);
      expect(fidele!.statut, StatutFidele.inactif);
    });
  });
}
