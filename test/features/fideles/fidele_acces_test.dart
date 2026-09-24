import 'package:drift/native.dart';
import 'package:ecclesias_360/core/audit/acteur.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/fideles/application/fidele_controller.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/fideles/domain/rules/fidele_acces_rules.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

/// Module II — miroir local de la policy `fideles` (0019) et traçabilité de
/// l'auteur (RG-II-05).
void main() {
  group('FideleAccesRules (RG-SEC-04/05)', () {
    test('sa propre fiche reste lisible à un membre, pas celle d\'autrui', () {
      expect(FideleAccesRules.peutConsulterFiche(role: Role.membre, fideleId: 'f1', fideleIdConsultant: 'f1'), isTrue);
      expect(FideleAccesRules.peutConsulterFiche(role: Role.membre, fideleId: 'f2', fideleIdConsultant: 'f1'), isFalse);
    });

    test('un responsable lit toutes les fiches ; un utilisateur simple aucune', () {
      expect(
        FideleAccesRules.peutConsulterFiche(role: Role.responsable, fideleId: 'f2', fideleIdConsultant: null),
        isTrue,
      );
      expect(
        FideleAccesRules.peutConsulterFiche(role: Role.utilisateurSimple, fideleId: 'f1', fideleIdConsultant: null),
        isFalse,
      );
    });

    test('la gestion est réservée au rang responsable', () {
      expect(FideleAccesRules.raisonBlocageGestion(roleActeur: Role.responsable), isNull);
      expect(FideleAccesRules.raisonBlocageGestion(roleActeur: Role.membre)?.code, 'gestion_fideles_reservee');
    });
  });

  group('FideleController — habilitation et auteur (RG-II-05)', () {
    late AppDatabase db;
    late FideleController controller;
    late String fideleId;
    late String responsableId;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      final repository = FideleRepository(db, SyncCoordinator(db));
      controller = FideleController(repository);
      await db
          .into(db.organisationNodes)
          .insert(
            OrganisationNodesCompanion.insert(
              id: 'noeud-1',
              typeNoeud: 'siege',
              nom: 'GSG',
              codeInterne: 'GSG',
              path: '/noeud-1/',
              depth: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
      Future<String> fiche(String prenoms) async => (await repository.creerFidele(
        noeudId: 'noeud-1',
        nom: 'Doe',
        prenoms: prenoms,
        dateNaissance: DateTime(1980, 1, 1),
        sexe: Sexe.feminin,
        statutCivil: StatutCivil.celibataire,
      )).id;
      fideleId = await fiche('Paul');
      responsableId = await fiche('Rita');
    });

    tearDown(() async {
      controller.dispose();
      await db.close();
    });

    test('un membre ne modifie pas une fiche : rien n\'est écrit ni historisé', () async {
      final ok = await controller.modifierCoordonnees(
        fideleId: fideleId,
        telephone: '+22890000000',
        acteur: Acteur(authUserId: 'compte-m', fideleId: fideleId, role: Role.membre),
      );

      expect(ok, isFalse);
      expect(controller.erreur, contains('responsable'));
      expect(await db.select(db.historiqueFideles).get(), isEmpty);
    });

    test('un responsable modifie : l\'historique trace sa fiche comme auteur', () async {
      final ok = await controller.modifierCoordonnees(
        fideleId: fideleId,
        telephone: '+22890000000',
        acteur: Acteur(authUserId: 'compte-r', fideleId: responsableId, role: Role.responsable),
      );

      expect(ok, isTrue);
      final historique = await controller.watchHistorique(fideleId).first;
      expect(historique, isNotEmpty);
      expect(historique.every((h) => h.auteurFideleId == responsableId), isTrue);
    });
  });
}
