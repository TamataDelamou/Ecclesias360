import '../../features/parametres/domain/models/role.dart';

/// Auteur d'une action tracée (RG-XXIII-06, RG-II-05) : le compte réel de la
/// session, sa fiche liée (`null` pour un compte sans fiche — administrateur
/// d'amorçage) et son rôle au moment de l'action. Toujours tiré de la
/// session, jamais d'un sélecteur.
class Acteur {
  const Acteur({required this.authUserId, required this.fideleId, required this.role});

  final String authUserId;
  final String? fideleId;
  final Role role;
}
