import 'origine_contribution.dart';
import 'statut_contribution.dart';

/// Contribution d'un fidèle (ou d'un donateur anonyme identifié
/// techniquement — `fideleId` alors `null` et `libelleDonateurAnonyme`
/// renseigné, RG-XI-01) rattachée à un type d'offrande, un nœud et,
/// éventuellement, un culte ou un projet. `contributionOrigineId` et
/// `estContrePassation` portent la correction tracée exigée par RG-XI-05 :
/// une contribution validée n'est jamais modifiée, seulement contre-passée
/// par une nouvelle ligne de montant inverse qui la référence.
class Contribution {
  const Contribution({
    required this.id,
    this.fideleId,
    this.libelleDonateurAnonyme,
    required this.typeOffrandeId,
    required this.montant,
    required this.devise,
    required this.noeudId,
    this.culteId,
    this.projetId,
    required this.modePaiement,
    required this.statut,
    required this.origine,
    required this.dateSaisie,
    this.saisieParFideleId,
    this.valideParFideleId,
    this.dateValidation,
    this.motifRejet,
    this.contributionOrigineId,
    required this.estContrePassation,
  });

  final String id;
  final String? fideleId;
  final String? libelleDonateurAnonyme;
  final String typeOffrandeId;
  final int montant;
  final String devise;
  final String noeudId;
  final String? culteId;
  final String? projetId;
  final String modePaiement;
  final StatutContribution statut;
  final OrigineContribution origine;
  final DateTime dateSaisie;

  /// RG-XI-02 — auteur de la saisie, jamais décideur de la même
  /// contribution. `null` seulement pour une saisie antérieure au traçage.
  final String? saisieParFideleId;

  /// Auteur de la décision comptable (validation ou rejet).
  final String? valideParFideleId;
  final DateTime? dateValidation;
  final String? motifRejet;
  final String? contributionOrigineId;
  final bool estContrePassation;
}
