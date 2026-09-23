import '../models/identifiant_connexion.dart';
import '../models/issue_liaison.dart';
import 'identifiant_rules.dart';

/// Vue minimale d'une fiche fidèle pour la décision de liaison — sans
/// dépendance au Module II ni à Drift.
class FicheCandidate {
  const FicheCandidate({
    required this.fideleId,
    this.telephone,
    this.email,
    this.authUserId,
    this.dejaLieeUneFois = false,
  });

  final String fideleId;

  /// Saisie brute de la fiche : normalisée ici avant comparaison.
  final String? telephone;
  final String? email;

  /// Compte actuellement lié à la fiche, s'il y en a un.
  final String? authUserId;

  /// Vrai si le journal atteste d'une liaison passée de cette fiche, même
  /// si `authUserId` a depuis été vidé (compte supprimé, lien retiré).
  final bool dejaLieeUneFois;

  bool get estOuAEteLiee => authUserId != null || dejaLieeUneFois;
}

class DecisionLiaison {
  const DecisionLiaison(this.issue, {this.fideleId});

  final IssueLiaison issue;

  /// Fiche liée (issue `lieAutomatiquement`) ou fiche en conflit (issue
  /// `ficheDejaLiee`) ; `null` sinon.
  final String? fideleId;
}

/// Règle pure de liaison d'un compte authentifié à une fiche fidèle
/// (RG-SEC-01, RG-SEC-06bis). Miroir SQL : `public.enregistrer_compte_courant()`
/// (migration 0018) — les deux doivent rester strictement équivalents, même
/// précédent que `PerimetreRules` ↔ `noeuds_du_perimetre()`.
///
/// Appelée uniquement pour un compte qui n'est lié à aucune fiche : un
/// compte déjà lié se reconnecte sans nouvelle décision.
abstract final class LiaisonCompteRules {
  static DecisionLiaison decider({
    required IdentifiantConnexion identifiant,
    required List<FicheCandidate> fiches,
    required bool baseVide,
  }) {
    final correspondances = fiches.where((f) => correspond(identifiant, f)).toList(growable: false);

    if (correspondances.length > 1) {
      return const DecisionLiaison(IssueLiaison.correspondanceMultiple);
    }
    if (correspondances.length == 1) {
      final fiche = correspondances.single;
      return fiche.estOuAEteLiee
          ? DecisionLiaison(IssueLiaison.ficheDejaLiee, fideleId: fiche.fideleId)
          : DecisionLiaison(IssueLiaison.lieAutomatiquement, fideleId: fiche.fideleId);
    }
    return DecisionLiaison(baseVide ? IssueLiaison.administrateurAmorcage : IssueLiaison.aucuneCorrespondance);
  }

  /// Comparaison sur valeurs normalisées uniquement : une fiche dont le
  /// téléphone n'est pas réductible à E.164 (format national) ne correspond
  /// jamais — l'indicatif pays ne se devine pas.
  static bool correspond(IdentifiantConnexion identifiant, FicheCandidate fiche) {
    return switch (identifiant) {
      IdentifiantTelephone(:final valeur) =>
        fiche.telephone != null && IdentifiantRules.normaliserTelephone(fiche.telephone!) == valeur,
      IdentifiantEmail(:final valeur) =>
        fiche.email != null && IdentifiantRules.normaliserEmail(fiche.email!) == valeur,
    };
  }
}
