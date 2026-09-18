import 'package:drift/native.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late OrganisationNodeRepository organisationRepository;
  late FideleRepository fideleRepository;
  late String siegeId;
  late String fideleId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final syncCoordinator = SyncCoordinator(db);
    organisationRepository = OrganisationNodeRepository(db, syncCoordinator);
    fideleRepository = FideleRepository(db, syncCoordinator);

    final siege = await organisationRepository.creerNoeud(
      typeNoeud: TypeNoeud.siege,
      noeudParentId: null,
      nom: 'Siège',
      codeInterne: 'SIEGE',
    );
    siegeId = siege.id;

    final fidele = await fideleRepository.creerFidele(
      noeudId: siegeId,
      nom: 'Doe',
      prenoms: 'Jean',
      dateNaissance: DateTime(1980, 1, 1),
      sexe: Sexe.masculin,
      statutCivil: StatutCivil.celibataire,
    );
    fideleId = fidele.id;
  });

  tearDown(() => db.close());

  group('affecterResponsable / retirerResponsable (RG-I-05)', () {
    test('affecte un responsable avec mandat actif (dateFin nulle)', () async {
      await organisationRepository.affecterResponsable(
        noeudId: siegeId,
        fideleId: fideleId,
        fonction: 'Administrateur GSG',
      );

      final responsables = await organisationRepository.watchResponsables(siegeId).first;
      expect(responsables, hasLength(1));
      expect(responsables.single.fonction, 'Administrateur GSG');
      expect(responsables.single.dateFin, isNull);
    });

    test('retirer un responsable termine le mandat sans supprimer la ligne (historique conservé)', () async {
      await organisationRepository.affecterResponsable(
        noeudId: siegeId,
        fideleId: fideleId,
        fonction: 'Administrateur GSG',
      );
      final avant = await organisationRepository.watchResponsables(siegeId).first;

      await organisationRepository.retirerResponsable(avant.single.id);

      final apres = await organisationRepository.watchResponsables(siegeId).first;
      expect(apres, hasLength(1));
      expect(apres.single.dateFin, isNotNull);
    });

    test('refuse un fidele_id inexistant (FK réellement appliquée)', () async {
      expect(
        () => organisationRepository.affecterResponsable(
          noeudId: siegeId,
          fideleId: 'fidele-inexistant',
          fonction: 'X',
        ),
        throwsA(anything),
      );
    });
  });
}
