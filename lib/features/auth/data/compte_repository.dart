import 'package:drift/drift.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/id_generator.dart';
import '../../organization/data/local/app_database.dart';
import '../../parametres/domain/models/role.dart';
import '../../parametres/domain/rules/capacity_rules.dart';
import '../domain/models/entree_journal_liaison.dart';
import '../domain/models/issue_liaison.dart';
import '../domain/models/session_utilisateur.dart';
import '../domain/rules/liaison_compte_rules.dart';
import 'auth_gateway.dart';

/// Dépôt des comptes authentifiés (RG-SEC-01) : liaison d'un compte à une
/// fiche fidèle, rôle effectif connu hors ligne, journal des liaisons et
/// résolution des conflits par un administrateur. Tout est local (Drift) :
/// la synchronisation distante n'est active pour aucun module, le miroir
/// serveur est `public.enregistrer_compte_courant()` (migration 0018).
class CompteRepository {
  CompteRepository(this._db);

  final AppDatabase _db;

  /// Établit la session d'un compte qui vient de s'authentifier (ou dont la
  /// session est restaurée) : décide de sa liaison s'il n'est lié à aucune
  /// fiche, journalise l'issue, et renvoie son rôle effectif.
  Future<SessionUtilisateur> etablirSession(UtilisateurAuthentifie utilisateur) {
    return _db.transaction(() async {
      final dejaLiee = await (_db.select(_db.fideles)..where((t) => t.authUserId.equals(utilisateur.id)))
          .getSingleOrNull();
      if (dejaLiee == null) {
        await _decider(utilisateur);
      } else {
        await _enregistrerCompte(utilisateur, amorcage: false);
      }
      return (await _lireSession(utilisateur.id))!;
    });
  }

  Future<void> _decider(UtilisateurAuthentifie utilisateur) async {
    final fiches = await _db.select(_db.fideles).get();
    final fichesLieesParLePasse = await _fichesLieesParLePasse();
    final baseVide = (await (_db.select(_db.organisationNodes)..limit(1)).get()).isEmpty;

    final decision = LiaisonCompteRules.decider(
      identifiant: utilisateur.identifiant,
      baseVide: baseVide,
      fiches: [
        for (final fiche in fiches)
          FicheCandidate(
            fideleId: fiche.id,
            telephone: fiche.telephone,
            email: fiche.email,
            authUserId: fiche.authUserId,
            dejaLieeUneFois: fichesLieesParLePasse.contains(fiche.id),
          ),
      ],
    );

    if (decision.issue == IssueLiaison.lieAutomatiquement) {
      await (_db.update(_db.fideles)..where((t) => t.id.equals(decision.fideleId!)))
          .write(FidelesCompanion(authUserId: Value(utilisateur.id)));
    }
    await _enregistrerCompte(utilisateur, amorcage: decision.issue == IssueLiaison.administrateurAmorcage);
    await _journaliser(utilisateur, decision);
  }

  /// Fiches dont le journal atteste une liaison passée, même si le lien a
  /// depuis été retiré : garde-fou contre le recyclage de numéros.
  Future<Set<String>> _fichesLieesParLePasse() async {
    final lignes = await (_db.select(_db.journalLiaisonsComptes)
          ..where((t) =>
              t.fideleId.isNotNull() &
              (t.issue.equals(IssueLiaison.lieAutomatiquement.code) |
                  t.statut.equals(StatutEntreeJournal.resoluLie.code))))
        .get();
    return {for (final ligne in lignes) ligne.fideleId!};
  }

  Future<void> _enregistrerCompte(UtilisateurAuthentifie utilisateur, {required bool amorcage}) async {
    final existant = await (_db.select(_db.comptesUtilisateurs)
          ..where((t) => t.authUserId.equals(utilisateur.id)))
        .getSingleOrNull();
    if (existant == null) {
      await _db.into(_db.comptesUtilisateurs).insert(
            ComptesUtilisateursCompanion.insert(
              authUserId: utilisateur.id,
              identifiant: utilisateur.identifiant.valeur,
              administrateurAmorcage: Value(amorcage),
              creeLe: DateTime.now(),
            ),
          );
    } else if (amorcage && !existant.administrateurAmorcage) {
      await (_db.update(_db.comptesUtilisateurs)..where((t) => t.authUserId.equals(utilisateur.id)))
          .write(const ComptesUtilisateursCompanion(administrateurAmorcage: Value(true)));
    }
  }

  /// Une issue identique (même compte, même issue, même fiche) déjà
  /// journalisée n'est pas répétée à chaque reconnexion — et un conflit
  /// déjà rejeté par un administrateur n'est jamais rouvert.
  Future<void> _journaliser(UtilisateurAuthentifie utilisateur, DecisionLiaison decision) async {
    final requete = _db.select(_db.journalLiaisonsComptes)
      ..where((t) => t.authUserId.equals(utilisateur.id) & t.issue.equals(decision.issue.code));
    final doublon = (await requete.get()).any((ligne) => ligne.fideleId == decision.fideleId);
    if (doublon) return;

    await _db.into(_db.journalLiaisonsComptes).insert(
          JournalLiaisonsComptesCompanion.insert(
            id: IdGenerator.newId(),
            authUserId: utilisateur.id,
            identifiant: utilisateur.identifiant.valeur,
            fideleId: Value(decision.fideleId),
            issue: decision.issue.code,
            statut: decision.issue.enAttenteAdministrateur
                ? StatutEntreeJournal.enAttente.code
                : StatutEntreeJournal.consigne.code,
            creeLe: DateTime.now(),
          ),
        );
  }

  /// Rôle effectif d'un compte : celui de sa fiche s'il est lié,
  /// administrateur s'il est l'administrateur d'amorçage, utilisateur simple
  /// sinon (RG-SEC-06bis). Même règle que `public.role_courant()`.
  Future<SessionUtilisateur?> _lireSession(String authUserId) async {
    final compte = await (_db.select(_db.comptesUtilisateurs)..where((t) => t.authUserId.equals(authUserId)))
        .getSingleOrNull();
    if (compte == null) return null;
    final fiche =
        await (_db.select(_db.fideles)..where((t) => t.authUserId.equals(authUserId))).getSingleOrNull();
    return _session(compte, fiche);
  }

  static SessionUtilisateur _session(CompteUtilisateurRow compte, FideleRow? fiche) {
    final role = fiche != null
        ? Role.fromCode(fiche.role)
        : (compte.administrateurAmorcage ? Role.administrateur : Role.utilisateurSimple);
    return SessionUtilisateur(
      authUserId: compte.authUserId,
      identifiant: compte.identifiant,
      role: role,
      fideleId: fiche?.id,
    );
  }

  /// Suit la session en direct : un changement de rôle ou de liaison (par
  /// un administrateur) se répercute sans reconnexion.
  Stream<SessionUtilisateur?> watchSession(String authUserId) {
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {_db.comptesUtilisateurs, _db.fideles},
        )
        .watch()
        .asyncMap((_) => _lireSession(authUserId));
  }

  Stream<List<EntreeJournalLiaison>> watchJournal() {
    final requete = _db.select(_db.journalLiaisonsComptes)..orderBy([(t) => OrderingTerm.desc(t.creeLe)]);
    return requete.watch().map((lignes) => lignes.map(_entreeVersDomaine).toList(growable: false));
  }

  /// Résolution d'un conflit par un administrateur. `lier` : la fiche
  /// (`fideleIdChoisi`, obligatoire pour une correspondance multiple) est
  /// liée au compte du conflit ; le compte qui la détenait éventuellement
  /// perd ce lien et redevient utilisateur simple. Sinon le compte reste
  /// utilisateur simple et le conflit n'est plus jamais rouvert.
  Future<void> resoudreConflit({
    required String entreeId,
    required bool lier,
    required SessionUtilisateur administrateur,
    String? fideleIdChoisi,
  }) {
    if (!CapacityRules.possede(role: administrateur.role, roleMinimalRequis: Role.administrateur)) {
      return Future.error(AppError.actionReserveeAdministrateur());
    }
    return _db.transaction(() async {
      final entree = await (_db.select(_db.journalLiaisonsComptes)..where((t) => t.id.equals(entreeId))).getSingle();
      if (entree.statut != StatutEntreeJournal.enAttente.code) throw AppError.conflitLiaisonDejaResolu();

      final fideleId = fideleIdChoisi ?? entree.fideleId;
      if (lier) {
        if (fideleId == null) throw ArgumentError('Une fiche doit être choisie pour lier ce compte.');
        await (_db.update(_db.fideles)..where((t) => t.authUserId.equals(entree.authUserId)))
            .write(const FidelesCompanion(authUserId: Value(null)));
        await (_db.update(_db.fideles)..where((t) => t.id.equals(fideleId)))
            .write(FidelesCompanion(authUserId: Value(entree.authUserId)));
      }
      await (_db.update(_db.journalLiaisonsComptes)..where((t) => t.id.equals(entreeId))).write(
        JournalLiaisonsComptesCompanion(
          statut: Value(lier ? StatutEntreeJournal.resoluLie.code : StatutEntreeJournal.resoluRejete.code),
          fideleId: Value(lier ? fideleId : entree.fideleId),
          resoluParAuthUserId: Value(administrateur.authUserId),
          resoluLe: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Un administrateur sans fiche lie son compte à [fideleId] : la fiche
  /// reçoit le compte et le rôle administrateur (sinon son rôle propre,
  /// `membre` par défaut, le rétrograderait), et la liaison est journalisée
  /// comme une résolution faite par lui-même.
  Future<void> lierMonCompteAFiche({required SessionUtilisateur administrateur, required String fideleId}) {
    return _db.transaction(() async {
      final fiche = await (_db.select(_db.fideles)..where((t) => t.id.equals(fideleId))).getSingle();
      final erreur = LiaisonCompteRules.raisonBlocageLiaisonAdministrateur(
        role: administrateur.role,
        ficheDuCompte: administrateur.fideleId,
        fiche: FicheCandidate(
          fideleId: fiche.id,
          authUserId: fiche.authUserId,
          dejaLieeUneFois: (await _fichesLieesParLePasse()).contains(fiche.id),
        ),
      );
      if (erreur != null) throw erreur;

      await (_db.update(_db.fideles)..where((t) => t.id.equals(fideleId))).write(
        FidelesCompanion(authUserId: Value(administrateur.authUserId), role: Value(Role.administrateur.code)),
      );
      final maintenant = DateTime.now();
      await _db.into(_db.journalLiaisonsComptes).insert(
            JournalLiaisonsComptesCompanion.insert(
              id: IdGenerator.newId(),
              authUserId: administrateur.authUserId,
              identifiant: administrateur.identifiant,
              fideleId: Value(fideleId),
              issue: IssueLiaison.administrateurAmorcage.code,
              statut: StatutEntreeJournal.resoluLie.code,
              resoluParAuthUserId: Value(administrateur.authUserId),
              resoluLe: Value(maintenant),
              creeLe: maintenant,
            ),
          );
    });
  }

  static EntreeJournalLiaison _entreeVersDomaine(JournalLiaisonCompteRow ligne) {
    return EntreeJournalLiaison(
      id: ligne.id,
      authUserId: ligne.authUserId,
      identifiant: ligne.identifiant,
      issue: IssueLiaison.fromCode(ligne.issue),
      statut: StatutEntreeJournal.fromCode(ligne.statut),
      creeLe: ligne.creeLe,
      fideleId: ligne.fideleId,
      resoluParAuthUserId: ligne.resoluParAuthUserId,
      resoluLe: ligne.resoluLe,
    );
  }
}
