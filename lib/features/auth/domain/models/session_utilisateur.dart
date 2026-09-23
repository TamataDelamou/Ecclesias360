import '../../../parametres/domain/models/role.dart';

/// Compte authentifié tel que le reste de l'application le voit : identité
/// Supabase, fiche fidèle éventuellement liée et rôle effectif (RG-XXIII-02).
/// Connu hors ligne (RG-OFF) : reconstruit depuis la base locale, jamais
/// depuis un appel réseau.
class SessionUtilisateur {
  const SessionUtilisateur({
    required this.authUserId,
    required this.identifiant,
    required this.role,
    this.fideleId,
  });

  final String authUserId;
  final String identifiant;
  final Role role;

  /// `null` pour un utilisateur simple ou l'administrateur d'amorçage.
  final String? fideleId;

  bool get estUtilisateurSimple => role == Role.utilisateurSimple;

  @override
  bool operator ==(Object other) =>
      other is SessionUtilisateur &&
      other.authUserId == authUserId &&
      other.identifiant == identifiant &&
      other.role == role &&
      other.fideleId == fideleId;

  @override
  int get hashCode => Object.hash(authUserId, identifiant, role, fideleId);
}
