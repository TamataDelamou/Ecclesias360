import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';

/// Règles pures d'accès au Module II (RG-SEC-04/05/06), miroir local de la
/// policy `fideles` de 0019 : lecture de sa propre fiche ou dans le
/// périmètre, écriture dans le périmètre. Le périmètre est approché par le
/// rang responsable (dette RG-SEC-05) ; le serveur reste la source de vérité.
abstract final class FideleAccesRules {
  static bool _auMoins(Role role, Role requis) => CapacityRules.possede(role: role, roleMinimalRequis: requis);

  /// Liste des fidèles et fiches d'autrui.
  static bool peutConsulterTousLesFideles(Role role) => _auMoins(role, Role.responsable);

  /// Sa propre fiche reste lisible à tout fidèle enregistré (RG-II-10), en
  /// lecture seule tant que l'écran « Profil et préférences » n'existe pas.
  static bool peutConsulterFiche({required Role role, required String fideleId, required String? fideleIdConsultant}) =>
      peutConsulterTousLesFideles(role) || (_auMoins(role, Role.membre) && fideleIdConsultant == fideleId);

  /// Créer, modifier (coordonnées, statut spirituel, liens, tuteur), archiver.
  static bool peutGererFideles(Role role) => _auMoins(role, Role.responsable);

  static AppError? raisonBlocageGestion({required Role roleActeur}) =>
      peutGererFideles(roleActeur) ? null : AppError.gestionFidelesReservee();
}
