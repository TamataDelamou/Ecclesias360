import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../../parametres/domain/models/role.dart';
import '../../parametres/domain/rules/capacity_rules.dart';
import '../data/auth_gateway.dart';
import '../data/compte_repository.dart';
import '../domain/models/entree_journal_liaison.dart';
import '../domain/models/identifiant_connexion.dart';
import '../domain/models/methode_otp.dart';
import '../domain/models/session_utilisateur.dart';

enum EtatSession { chargement, deconnecte, connecte }

/// Session courante (RG-SEC-01), instanciée à la racine de l'application
/// (`app.dart`) : source unique de « qui agit » et de son rôle pour tous les
/// modules ; sa [garde] est le `refreshListenable` du routeur.
class SessionController extends ChangeNotifier {
  SessionController(this._gateway, this._comptes) {
    _abonnementAuth = _gateway.changements.listen(_onAuthChange);
    final restauree = _gateway.utilisateurCourant;
    if (restauree == null) {
      _etat = EtatSession.deconnecte;
      _garde.value = (_etat, null);
    } else {
      unawaited(_etablir(restauree));
    }
  }

  final AuthGateway _gateway;
  final CompteRepository _comptes;
  late final StreamSubscription<UtilisateurAuthentifie?> _abonnementAuth;
  StreamSubscription<SessionUtilisateur?>? _abonnementSession;

  /// Établissement en cours : `verifierCode` et l'évènement de connexion
  /// émis par le fournisseur visent le même compte — une seule exécution.
  (String, Future<void>)? _etablissement;

  EtatSession _etat = EtatSession.chargement;
  SessionUtilisateur? _session;
  IdentifiantConnexion? _identifiantEnCours;
  MethodeOtp? _methodeEnCours;
  bool _enCours = false;
  String? _erreur;

  EtatSession get etat => _etat;
  SessionUtilisateur? get session => _session;
  bool get estConnecte => _etat == EtatSession.connecte && _session != null;
  Role get role => _session?.role ?? Role.utilisateurSimple;
  IdentifiantConnexion? get identifiantEnCours => _identifiantEnCours;
  MethodeOtp? get methodeEnCours => _methodeEnCours;
  bool get enCours => _enCours;
  String? get erreur => _erreur;

  /// `refreshListenable` du routeur : ne notifie que lorsque ce dont dépend
  /// la garde d'accès change (état, rôle). Rafraîchir le routeur à chaque
  /// écriture sur `fideles` (flux `watchSession`) restaurait une page
  /// venant d'être dépilée.
  Listenable get garde => _garde;
  final ValueNotifier<(EtatSession, Role?)> _garde = ValueNotifier((EtatSession.chargement, null));

  @override
  void notifyListeners() {
    _garde.value = (_etat, _session?.role);
    super.notifyListeners();
  }

  /// RG-XXIII-02 — capacité du compte courant, hiérarchie additive.
  bool peut(Role roleMinimalRequis) => estConnecte && CapacityRules.possede(role: role, roleMinimalRequis: roleMinimalRequis);

  Future<bool> envoyerCode(IdentifiantConnexion identifiant, MethodeOtp methode) => _executer(() async {
        await _gateway.envoyerCode(identifiant, methode);
        _identifiantEnCours = identifiant;
        _methodeEnCours = methode;
      });

  Future<bool> verifierCode(String code) {
    final identifiant = _identifiantEnCours;
    if (identifiant == null) return Future.value(false);
    return _executer(() async {
      final utilisateur = await _gateway.verifierCode(identifiant, code);
      await _etablir(utilisateur);
    });
  }

  void abandonnerVerification() {
    _identifiantEnCours = null;
    _methodeEnCours = null;
    _erreur = null;
    notifyListeners();
  }

  Future<bool> deconnecter() => _executer(() async {
        await _gateway.deconnecter();
        _terminer();
      });

  Stream<List<EntreeJournalLiaison>> watchJournalLiaisons() => _comptes.watchJournal();

  Future<bool> resoudreConflit({required String entreeId, required bool lier, String? fideleIdChoisi}) {
    final administrateur = _session;
    if (administrateur == null) return Future.value(false);
    return _executer(() => _comptes.resoudreConflit(
          entreeId: entreeId,
          lier: lier,
          administrateur: administrateur,
          fideleIdChoisi: fideleIdChoisi,
        ));
  }

  void _onAuthChange(UtilisateurAuthentifie? utilisateur) {
    if (utilisateur == null) {
      _terminer();
    } else if (_session?.authUserId != utilisateur.id) {
      // Connexion par Magic Link (lien profond) : aucun appel à
      // verifierCode n'a précédé.
      unawaited(_etablir(utilisateur));
    }
  }

  Future<void> _etablir(UtilisateurAuthentifie utilisateur) {
    final enCours = _etablissement;
    if (enCours != null && enCours.$1 == utilisateur.id) return enCours.$2;
    final etablissement = _etablirUneFois(utilisateur).whenComplete(() => _etablissement = null);
    _etablissement = (utilisateur.id, etablissement);
    return etablissement;
  }

  Future<void> _etablirUneFois(UtilisateurAuthentifie utilisateur) async {
    final session = await _comptes.etablirSession(utilisateur);
    unawaited(_abonnementSession?.cancel());
    _session = session;
    _etat = EtatSession.connecte;
    _identifiantEnCours = null;
    _methodeEnCours = null;
    _abonnementSession = _comptes.watchSession(utilisateur.id).listen((misAJour) {
      if (misAJour == null || misAJour == _session) return;
      _session = misAJour;
      notifyListeners();
    });
    notifyListeners();
  }

  void _terminer() {
    unawaited(_abonnementSession?.cancel());
    _abonnementSession = null;
    _session = null;
    _etat = EtatSession.deconnecte;
    notifyListeners();
  }

  Future<bool> _executer(Future<void> Function() action) async {
    _enCours = true;
    _erreur = null;
    notifyListeners();
    try {
      await action();
      _enCours = false;
      notifyListeners();
      return true;
    } on AppError catch (error) {
      _enCours = false;
      _erreur = error.message;
      notifyListeners();
      return false;
    } on ArgumentError catch (error) {
      _enCours = false;
      _erreur = error.message?.toString() ?? 'Requête invalide.';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _abonnementAuth.cancel();
    _abonnementSession?.cancel();
    _garde.dispose();
    super.dispose();
  }
}
