import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/statut_periode_comptable.dart';
import '../models/type_compte.dart';

/// Règles métier pures du Module XXI (RG-XXI-*).
abstract final class ComptabiliteRules {
  /// RG-XXI-03 — aucune écriture ne peut être générée sur une période déjà
  /// clôturée (immuabilité) ; la correction se fait dans la période
  /// courante ouverte, jamais par réouverture.
  static AppError? raisonBlocageEcritureSurPeriode({required StatutPeriodeComptable statutPeriode}) {
    if (statutPeriode == StatutPeriodeComptable.ouverte) return null;
    return AppError.periodeComptableCloturee();
  }

  /// RG-XXI-03 — seul un pasteur (ou rôle supérieur) peut clôturer une
  /// période comptable, même seuil que la validation comptable du Module XI.
  static AppError? raisonBlocageClotureComptable({required Role roleActeur}) {
    if (CapacityRules.possede(role: roleActeur, roleMinimalRequis: Role.pasteur)) return null;
    return AppError.roleInsuffisantPourClotureComptable();
  }

  /// RG-SEC-06 — consultation de la comptabilité d'un nœud (caisse, journal,
  /// rapport) : pasteur (ou rôle supérieur), ou trésorier désigné du nœud,
  /// quel que soit son rang. Miroir local de la policy
  /// `ecritures_comptables_lecture` (0019), sans le bornage par périmètre
  /// hiérarchique (dette RG-SEC-05, inventaire du Module II).
  static bool peutConsulterComptabilite({required Role role, required bool estTresorierDuNoeud}) {
    return estTresorierDuNoeud || CapacityRules.possede(role: role, roleMinimalRequis: Role.pasteur);
  }

  /// RG-XXI-01 — solde d'un compte : pour un compte actif/charge, le débit
  /// augmente le solde ; pour un compte passif/produit, c'est le crédit —
  /// convention comptable standard de la partie double.
  static int calculerSoldeCompte({required TypeCompte type, required int totalDebit, required int totalCredit}) {
    return switch (type) {
      TypeCompte.actif || TypeCompte.charge => totalDebit - totalCredit,
      TypeCompte.passif || TypeCompte.produit => totalCredit - totalDebit,
    };
  }

  /// RG-XXI-04 — dépassement de seuil d'alerte budgétaire : le montant déjà
  /// engagé (dépenses) atteint ou dépasse le pourcentage paramétrable du
  /// montant prévu.
  static bool depassementSeuilBudget({
    required int montantEngage,
    required int montantPrevu,
    required int seuilAlertePourcentage,
  }) {
    if (montantPrevu <= 0) return montantEngage > 0;
    return montantEngage * 100 >= montantPrevu * seuilAlertePourcentage;
  }

  /// RG-XXI-05 — écart de rapprochement bancaire : différence entre le
  /// solde système et le solde du relevé, signalé s'il subsiste après
  /// rapprochement automatique.
  static int ecartRapprochement({required int soldeSysteme, required int soldeReleve}) {
    return soldeSysteme - soldeReleve;
  }
}
