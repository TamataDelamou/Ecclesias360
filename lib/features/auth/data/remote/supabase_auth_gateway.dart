import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/app_error.dart';
import '../../domain/models/identifiant_connexion.dart';
import '../../domain/models/methode_otp.dart';
import '../../domain/rules/identifiant_rules.dart';
import '../auth_gateway.dart';

/// Lien profond de retour du Magic Link (déclaré dans AndroidManifest.xml,
/// Info.plist et `additional_redirect_urls` de `supabase/config.toml`).
const String lienRetourMagicLink = 'io.gsg.ecclesias360://login-callback';

/// Authentification native Supabase sans mot de passe (RG-SEC-01) :
/// `signInWithOtp` / `verifyOtp` uniquement.
class SupabaseAuthGateway implements AuthGateway {
  SupabaseAuthGateway(this._auth);

  final GoTrueClient _auth;

  @override
  UtilisateurAuthentifie? get utilisateurCourant => _versDomaine(_auth.currentSession?.user);

  @override
  Stream<UtilisateurAuthentifie?> get changements => _auth.onAuthStateChange
      .where((etat) => const {
            AuthChangeEvent.signedIn,
            AuthChangeEvent.signedOut,
          }.contains(etat.event))
      .map((etat) => _versDomaine(etat.session?.user));

  @override
  Future<void> envoyerCode(IdentifiantConnexion identifiant, MethodeOtp methode) => _traduire(() {
        return switch (identifiant) {
          IdentifiantTelephone(:final valeur) => _auth.signInWithOtp(
              phone: valeur,
              channel: methode == MethodeOtp.whatsapp ? OtpChannel.whatsapp : OtpChannel.sms,
            ),
          IdentifiantEmail(:final valeur) => _auth.signInWithOtp(
              email: valeur,
              // Le lien profond n'a de sens que sur mobile ; sur Windows le
              // même e-mail porte le code à saisir.
              emailRedirectTo: !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? lienRetourMagicLink : null,
            ),
        };
      });

  @override
  Future<UtilisateurAuthentifie> verifierCode(IdentifiantConnexion identifiant, String code) => _traduire(() async {
        final reponse = switch (identifiant) {
          IdentifiantTelephone(:final valeur) =>
            await _auth.verifyOTP(type: OtpType.sms, phone: valeur, token: code.trim()),
          IdentifiantEmail(:final valeur) =>
            await _auth.verifyOTP(type: OtpType.email, email: valeur, token: code.trim()),
        };
        final utilisateur = _versDomaine(reponse.user);
        if (utilisateur == null) throw AppError.codeOtpInvalide();
        return utilisateur;
      });

  @override
  Future<void> deconnecter() => _traduire(() => _auth.signOut());

  /// Supabase renvoie le téléphone sans « + » : il est renormalisé en E.164.
  static UtilisateurAuthentifie? _versDomaine(User? user) {
    if (user == null) return null;
    final telephone = user.phone;
    final IdentifiantConnexion? identifiant = telephone != null && telephone.isNotEmpty
        ? IdentifiantRules.telephone(telephone.startsWith('+') ? telephone : '+$telephone')
        : (user.email == null ? null : IdentifiantRules.email(user.email!));
    if (identifiant == null) return null;
    return UtilisateurAuthentifie(id: user.id, identifiant: identifiant);
  }

  /// Traduit les erreurs du fournisseur en erreurs métier à code stable
  /// (AGENTS.md §11 point 3) — jamais le message brut du serveur.
  static Future<T> _traduire<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AuthException catch (erreur) {
      if (erreur.statusCode == '429') throw AppError.tropDeTentativesOtp();
      if (erreur.code == 'otp_expired' || erreur.statusCode == '403' || erreur.statusCode == '401') {
        throw AppError.codeOtpInvalide();
      }
      throw AppError.authentificationIndisponible();
    } on SocketException {
      throw AppError.authentificationIndisponible();
    } on TimeoutException {
      throw AppError.authentificationIndisponible();
    }
  }
}
