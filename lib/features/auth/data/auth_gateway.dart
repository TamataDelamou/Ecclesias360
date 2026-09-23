import '../../../core/error/app_error.dart';
import '../domain/models/identifiant_connexion.dart';
import '../domain/models/methode_otp.dart';

/// Identité renvoyée par le fournisseur d'authentification une fois l'OTP
/// vérifié (ou la session restaurée).
class UtilisateurAuthentifie {
  const UtilisateurAuthentifie({required this.id, required this.identifiant});

  final String id;
  final IdentifiantConnexion identifiant;
}

/// Port d'authentification sans mot de passe (RG-SEC-01). L'implémentation
/// de production est `SupabaseAuthGateway` ; les tests injectent une
/// implémentation en mémoire. Aucune méthode ne manipule de mot de passe.
abstract class AuthGateway {
  /// Utilisateur de la session restaurée au démarrage, `null` si aucune.
  /// Disponible hors ligne (RG-OFF) : une session persistée reste valable
  /// même si son jeton d'accès ne peut pas être rafraîchi faute de réseau.
  UtilisateurAuthentifie? get utilisateurCourant;

  /// Émet à chaque connexion/déconnexion, y compris une déconnexion forcée
  /// à distance (révocation du jeton de rafraîchissement, RG-SEC-02) ou une
  /// connexion par Magic Link reçue par lien profond.
  Stream<UtilisateurAuthentifie?> get changements;

  Future<void> envoyerCode(IdentifiantConnexion identifiant, MethodeOtp methode);

  Future<UtilisateurAuthentifie> verifierCode(IdentifiantConnexion identifiant, String code);

  Future<void> deconnecter();
}

/// Repli lorsque Supabase n'est pas configuré (`.env` absent) : l'accès à
/// l'application reste fermé — une configuration manquante ne doit jamais
/// ouvrir l'application sans authentification.
class AuthGatewayNonConfigure implements AuthGateway {
  const AuthGatewayNonConfigure();

  @override
  UtilisateurAuthentifie? get utilisateurCourant => null;

  @override
  Stream<UtilisateurAuthentifie?> get changements => const Stream.empty();

  @override
  Future<void> envoyerCode(IdentifiantConnexion identifiant, MethodeOtp methode) =>
      Future.error(AppError.authentificationNonConfiguree());

  @override
  Future<UtilisateurAuthentifie> verifierCode(IdentifiantConnexion identifiant, String code) =>
      Future.error(AppError.authentificationNonConfiguree());

  @override
  Future<void> deconnecter() async {}
}
