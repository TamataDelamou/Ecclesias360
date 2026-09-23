import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/core/sync/sync_coordinator.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/data/compte_repository.dart';
import 'package:ecclesias_360/features/auth/domain/models/entree_journal_liaison.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/auth/domain/models/issue_liaison.dart';
import 'package:ecclesias_360/features/auth/domain/models/session_utilisateur.dart';
import 'package:ecclesias_360/features/fideles/data/fidele_repository.dart';
import 'package:ecclesias_360/features/fideles/domain/models/sexe.dart';
import 'package:ecclesias_360/features/fideles/domain/models/statut_civil.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:ecclesias_360/features/organization/data/organisation_node_repository.dart';
import 'package:ecclesias_360/features/organization/domain/models/type_noeud.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CompteRepository comptes;
  late FideleRepository fideles;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    comptes = CompteRepository(db);
    fideles = FideleRepository(db, SyncCoordinator(db));
  });

  tearDown(() => db.close());

  UtilisateurAuthentifie compte(String id, String telephone) =>
      UtilisateurAuthentifie(id: id, identifiant: IdentifiantTelephone(telephone));

  Future<String> creerSiege() async {
    final siege = await OrganisationNodeRepository(db, SyncCoordinator(db)).creerNoeud(
      typeNoeud: TypeNoeud.siege,
      noeudParentId: null,
      nom: 'Siège',
      codeInterne: 'SIEGE',
    );
    return siege.id;
  }

  Future<String> creerFiche(String noeudId, {String? telephone, String nom = 'Camara'}) async {
    final fidele = await fideles.creerFidele(
      noeudId: noeudId,
      nom: nom,
      prenoms: 'Aïssata',
      dateNaissance: DateTime(1990, 1, 1),
      sexe: Sexe.feminin,
      statutCivil: StatutCivil.celibataire,
      telephone: telephone,
    );
    return fidele.id;
  }

  Future<List<EntreeJournalLiaison>> journal() => comptes.watchJournal().first;

  test('base vide : le premier compte devient administrateur d\'amorçage, sans fiche', () async {
    final session = await comptes.etablirSession(compte('a1', '+224620000001'));

    expect(session.role, Role.administrateur);
    expect(session.fideleId, isNull);
    expect((await journal()).single.issue, IssueLiaison.administrateurAmorcage);
  });

  test('liaison automatique : la fiche reçoit le compte, le rôle vient de la fiche, liaison journalisée', () async {
    final noeudId = await creerSiege();
    final ficheId = await creerFiche(noeudId, telephone: '+224 620 00 00 01');

    final session = await comptes.etablirSession(compte('a1', '+224620000001'));

    expect(session.fideleId, ficheId);
    expect(session.role, Role.membre);
    final ligne = await (db.select(db.fideles)..where((t) => t.id.equals(ficheId))).getSingle();
    expect(ligne.authUserId, 'a1');
    final entree = (await journal()).single;
    expect(entree.issue, IssueLiaison.lieAutomatiquement);
    expect(entree.fideleId, ficheId);
    expect(entree.authUserId, 'a1');
    expect(entree.identifiant, '+224620000001');
  });

  test('aucune correspondance sur une base non vide : utilisateur simple', () async {
    await creerSiege();
    final session = await comptes.etablirSession(compte('a1', '+224620000001'));

    expect(session.role, Role.utilisateurSimple);
    expect(session.fideleId, isNull);
  });

  test('garde-fou SIM churn : fiche déjà liée → nouveau titulaire utilisateur simple, lien existant intact, conflit en attente',
      () async {
    final noeudId = await creerSiege();
    final ficheId = await creerFiche(noeudId, telephone: '+224620000001');
    await comptes.etablirSession(compte('ancien', '+224620000001'));

    final nouveau = await comptes.etablirSession(compte('nouveau', '+224620000001'));

    expect(nouveau.role, Role.utilisateurSimple);
    final ligne = await (db.select(db.fideles)..where((t) => t.id.equals(ficheId))).getSingle();
    expect(ligne.authUserId, 'ancien');
    final conflit = (await journal()).firstWhere((e) => e.authUserId == 'nouveau');
    expect(conflit.issue, IssueLiaison.ficheDejaLiee);
    expect(conflit.statut, StatutEntreeJournal.enAttente);
    expect(conflit.fideleId, ficheId);
  });

  test('garde-fou SIM churn : une fiche dont le lien a été vidé reste protégée par le journal', () async {
    final noeudId = await creerSiege();
    final ficheId = await creerFiche(noeudId, telephone: '+224620000001');
    await comptes.etablirSession(compte('ancien', '+224620000001'));
    // Compte supprimé côté serveur : le lien est vidé (on delete set null).
    await (db.update(db.fideles)..where((t) => t.id.equals(ficheId)))
        .write(const FidelesCompanion(authUserId: Value(null)));

    final nouveau = await comptes.etablirSession(compte('nouveau', '+224620000001'));

    expect(nouveau.role, Role.utilisateurSimple);
    expect((await journal()).firstWhere((e) => e.authUserId == 'nouveau').issue, IssueLiaison.ficheDejaLiee);
  });

  test('une reconnexion ne répète pas une issue déjà journalisée', () async {
    await creerSiege();
    await comptes.etablirSession(compte('a1', '+224620000001'));
    await comptes.etablirSession(compte('a1', '+224620000001'));

    expect(await journal(), hasLength(1));
  });

  test('une fiche créée après coup est liée à la connexion suivante', () async {
    final noeudId = await creerSiege();
    final premiere = await comptes.etablirSession(compte('a1', '+224620000001'));
    expect(premiere.role, Role.utilisateurSimple);

    final ficheId = await creerFiche(noeudId, telephone: '+224620000001');
    final seconde = await comptes.etablirSession(compte('a1', '+224620000001'));

    expect(seconde.fideleId, ficheId);
  });

  group('resoudreConflit', () {
    late String ficheId;
    late String conflitId;

    setUp(() async {
      final noeudId = await creerSiege();
      ficheId = await creerFiche(noeudId, telephone: '+224620000001');
      await comptes.etablirSession(compte('ancien', '+224620000001'));
      await comptes.etablirSession(compte('nouveau', '+224620000001'));
      conflitId = (await journal()).firstWhere((e) => e.statut == StatutEntreeJournal.enAttente).id;
    });

    test('réservée à un administrateur', () async {
      final nonAdmin = await comptes.etablirSession(compte('ancien', '+224620000001'));
      await expectLater(
        comptes.resoudreConflit(entreeId: conflitId, lier: true, administrateur: nonAdmin),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'action_reservee_administrateur')),
      );
    });

    test('lier : le lien passe explicitement au nouveau compte, l\'ancien redevient utilisateur simple, résolution tracée',
        () async {
      final admin = await _administrateur(db, comptes);
      await comptes.resoudreConflit(entreeId: conflitId, lier: true, administrateur: admin);

      final ligne = await (db.select(db.fideles)..where((t) => t.id.equals(ficheId))).getSingle();
      expect(ligne.authUserId, 'nouveau');
      expect((await comptes.watchSession('ancien').first)!.role, Role.utilisateurSimple);
      final entree = (await journal()).firstWhere((e) => e.id == conflitId);
      expect(entree.statut, StatutEntreeJournal.resoluLie);
      expect(entree.resoluParAuthUserId, admin.authUserId);
      expect(entree.resoluLe, isNotNull);
    });

    test('rejeter : le lien existant est conservé et le conflit n\'est jamais rouvert', () async {
      final admin = await _administrateur(db, comptes);
      await comptes.resoudreConflit(entreeId: conflitId, lier: false, administrateur: admin);
      await comptes.etablirSession(compte('nouveau', '+224620000001'));

      final ligne = await (db.select(db.fideles)..where((t) => t.id.equals(ficheId))).getSingle();
      expect(ligne.authUserId, 'ancien');
      expect((await journal()).where((e) => e.statut == StatutEntreeJournal.enAttente), isEmpty);
    });

    test('un conflit déjà résolu ne peut pas l\'être une seconde fois', () async {
      final admin = await _administrateur(db, comptes);
      await comptes.resoudreConflit(entreeId: conflitId, lier: false, administrateur: admin);
      await expectLater(
        comptes.resoudreConflit(entreeId: conflitId, lier: true, administrateur: admin),
        throwsA(isA<AppError>().having((e) => e.code, 'code', 'conflit_liaison_deja_resolu')),
      );
    });
  });
}

/// Administrateur par sa fiche (rôle porté par `fideles.role`).
Future<SessionUtilisateur> _administrateur(AppDatabase db, CompteRepository comptes) async {
  final noeud = await db.select(db.organisationNodes).getSingle();
  final fidele = await FideleRepository(db, SyncCoordinator(db)).creerFidele(
    noeudId: noeud.id,
    nom: 'Admin',
    prenoms: 'Paul',
    dateNaissance: DateTime(1980, 1, 1),
    sexe: Sexe.masculin,
    statutCivil: StatutCivil.marie,
    telephone: '+224620000099',
  );
  await (db.update(db.fideles)..where((t) => t.id.equals(fidele.id)))
      .write(const FidelesCompanion(role: Value('administrateur')));
  return comptes.etablirSession(
    const UtilisateurAuthentifie(id: 'admin', identifiant: IdentifiantTelephone('+224620000099')),
  );
}
