import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/periodicite_engagement.dart';

/// Règles métier pures du Module XI (RG-XI-*).
abstract final class FinancesRules {
  /// RG-XI-02 — seul un pasteur (ou rôle supérieur) ou un trésorier désigné
  /// du nœud peut valider ou rejeter une contribution en attente.
  static AppError? raisonBlocageValidationContribution({
    required Role roleActeur,
    required bool estTresorierDuNoeud,
  }) {
    final habiliteParRole = CapacityRules.possede(role: roleActeur, roleMinimalRequis: Role.pasteur);
    if (habiliteParRole || estTresorierDuNoeud) return null;
    return AppError.roleInsuffisantPourValidationContribution();
  }

  /// RG-XI-02 / RG-SEC-06 — séparation stricte des tâches : la personne qui a
  /// saisi une contribution ne décide jamais de sa validation ou de son
  /// rejet, quel que soit son rang (administrateur compris). Un site ne
  /// comptant qu'une seule personne habilitée voit donc ses propres saisies
  /// attendre une seconde personne : comportement voulu, pas un défaut. Une
  /// saisie antérieure au traçage (`saisieParFideleId` nul) n'a pas
  /// d'auteur connu à opposer.
  static AppError? raisonBlocageSeparationTaches({
    required String? saisieParFideleId,
    required String decideurFideleId,
  }) {
    return saisieParFideleId != null && saisieParFideleId == decideurFideleId
        ? AppError.decisionParLeSaisissant()
        : null;
  }

  /// RG-SEC-06 — une contribution n'est consultée que par un pasteur (ou
  /// rôle supérieur), un trésorier désigné de son nœud, ou son donateur.
  /// Miroir local de la policy `contributions_lecture` (migration 0019).
  static bool peutConsulterContribution({
    required Role role,
    required bool estTresorierDuNoeud,
    required bool estDonateur,
  }) {
    return CapacityRules.possede(role: role, roleMinimalRequis: Role.pasteur) || estTresorierDuNoeud || estDonateur;
  }

  /// RG-XI-03 — une dépense ne peut dépasser le solde disponible du projet
  /// sans dérogation tracée d'un rôle habilité.
  static AppError? raisonBlocageDepense({
    required int soldeDisponible,
    required int montantDepense,
    required bool derogationTracee,
  }) {
    if (montantDepense <= soldeDisponible || derogationTracee) return null;
    return AppError.depenseDepasseSoldeSansDerogation();
  }

  /// RG-XI-03 — solde en temps réel d'un projet : recettes (contributions
  /// validées rattachées) moins dépenses validées, jamais un compteur
  /// mutable stocké (même précédent que le décompte des votes, RG-XII-06).
  static int calculerSoldeProjet({required int totalContributionsValidees, required int totalDepenses}) {
    return totalContributionsValidees - totalDepenses;
  }

  /// RG-XI-06 — deux contributions sont des doublons potentiels de
  /// synchronisation hors ligne quand elles partagent le même fidèle, le
  /// même montant et la même minute (l'horodatage terrain n'est fiable qu'à
  /// la minute près).
  static bool sontDoublonsPotentiels({
    required String? fideleIdA,
    required int montantA,
    required DateTime dateA,
    required String? fideleIdB,
    required int montantB,
    required DateTime dateB,
  }) {
    if (fideleIdA == null || fideleIdB == null || fideleIdA != fideleIdB) return false;
    if (montantA != montantB) return false;
    final minuteA = DateTime(dateA.year, dateA.month, dateA.day, dateA.hour, dateA.minute);
    final minuteB = DateTime(dateB.year, dateB.month, dateB.day, dateB.hour, dateB.minute);
    return minuteA == minuteB;
  }

  /// RG-XI-04 — génère les dates d'échéance d'un engagement à partir de sa
  /// date de début et de sa périodicité.
  static List<DateTime> genererDatesEcheance({
    required DateTime dateDebut,
    required PeriodiciteEngagement periodicite,
    required int nombre,
  }) {
    final increment = switch (periodicite) {
      PeriodiciteEngagement.hebdomadaire => const Duration(days: 7),
      PeriodiciteEngagement.mensuelle => const Duration(days: 30),
      PeriodiciteEngagement.trimestrielle => const Duration(days: 90),
      PeriodiciteEngagement.annuelle => const Duration(days: 365),
    };
    return List.generate(nombre, (i) => dateDebut.add(increment * (i + 1)));
  }

  /// RG-XI-04 — une échéance en attente devenue passée est en retard.
  static bool estEnRetard({required DateTime dateEcheance, required DateTime maintenant}) {
    return maintenant.isAfter(dateEcheance);
  }
}
