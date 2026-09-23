import '../models/identifiant_connexion.dart';

/// Règles pures de saisie de l'identifiant de connexion (RG-SEC-01) et de
/// validation du téléphone au format international E.164 dès la saisie,
/// avant tout appel à Supabase (RG-SEC-01bis / KER-ID-06).
abstract final class IdentifiantRules {
  static final RegExp _e164 = RegExp(r'^\+[1-9]\d{7,14}$');
  static final RegExp _separateurs = RegExp(r'[\s\-.()/]');
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Normalise une saisie téléphonique vers E.164, ou `null` si elle n'y est
  /// pas réductible sans deviner. Séparateurs usuels retirés, préfixe
  /// international `00` converti en `+`. Un numéro au format national (sans
  /// indicatif pays) est refusé : l'indicatif ne se devine jamais — deux
  /// pays peuvent partager un même format local.
  static String? normaliserTelephone(String saisie) {
    var brut = saisie.trim().replaceAll(_separateurs, '');
    if (brut.startsWith('00')) brut = '+${brut.substring(2)}';
    return _e164.hasMatch(brut) ? brut : null;
  }

  static String? normaliserEmail(String saisie) {
    final brut = saisie.trim().toLowerCase();
    return _email.hasMatch(brut) ? brut : null;
  }

  static IdentifiantTelephone? telephone(String saisie) {
    final valeur = normaliserTelephone(saisie);
    return valeur == null ? null : IdentifiantTelephone(valeur);
  }

  static IdentifiantEmail? email(String saisie) {
    final valeur = normaliserEmail(saisie);
    return valeur == null ? null : IdentifiantEmail(valeur);
  }
}
