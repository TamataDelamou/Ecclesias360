import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/statut_dossier_disciplinaire.dart';

/// Règles métier pures du Module X (RG-X-*).
abstract final class DisciplineRules {
  /// RG-X-01 — seul un pasteur référent (ou rôle supérieur) ou un membre
  /// d'une commission disciplinaire désigné peut ouvrir un dossier.
  static AppError? raisonBlocageOuverture({
    required Role roleActeur,
    required bool estMembreCommission,
  }) {
    final habiliteParRole = CapacityRules.possede(role: roleActeur, roleMinimalRequis: Role.pasteur);
    if (habiliteParRole || estMembreCommission) return null;
    return AppError.roleInsuffisantPourOuvertureDossier();
  }

  /// RG-X-02 — une décision ne peut être prononcée qu'une fois une
  /// commission instructrice assignée (la nature de faute est, elle,
  /// obligatoire dès l'ouverture — contrainte portée par le schéma).
  static AppError? raisonBlocageDecision({required bool commissionRenseignee}) {
    return commissionRenseignee ? null : AppError.commissionRequisePourDecision();
  }

  /// RG-X-02 — seul un dossier `enInstruction` peut recevoir une décision.
  static AppError? raisonBlocagePrononceDecision({required StatutDossierDisciplinaire statut}) {
    return statut == StatutDossierDisciplinaire.enInstruction
        ? null
        : AppError.dossierDisciplinaireNonEnInstruction();
  }

  /// RG-X-02/04 — un dossier ne peut être clos qu'après qu'une décision a
  /// été prononcée (jamais directement depuis `enInstruction`).
  static AppError? raisonBlocageCloture({required StatutDossierDisciplinaire statut}) {
    return statut == StatutDossierDisciplinaire.sanctionne
        ? null
        : AppError.dossierDisciplinaireNonSanctionne();
  }

  /// RG-X-04 — durée déterminée : date de réintégration prévue. Durée
  /// indéterminée ([dureeSanctionJours] `null`) : `null`, une revue
  /// périodique est planifiée à la place (voir [necessiteRevuePeriodique]).
  static DateTime? calculerDateReintegrationPrevue({
    required DateTime dateDecision,
    required int? dureeSanctionJours,
  }) {
    if (dureeSanctionJours == null) return null;
    return dateDecision.add(Duration(days: dureeSanctionJours));
  }

  /// RG-X-04 — une sanction à durée indéterminée nécessite une revue une
  /// fois [seuilJours] écoulés depuis la décision.
  static bool necessiteRevuePeriodique({
    required DateTime dateDecision,
    required DateTime maintenant,
    required int seuilJours,
  }) {
    return maintenant.difference(dateDecision).inDays >= seuilJours;
  }
}
