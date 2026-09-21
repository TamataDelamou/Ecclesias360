import 'statut_projet.dart';

/// Projet financier d'un nœud (Module XI, RG-XI-03). Le solde n'est jamais
/// stocké ni incrémenté directement (même précédent que le décompte des
/// votes du Module XII, RG-XII-06) : il se recalcule à chaque lecture à
/// partir des contributions validées qui le référencent moins les dépenses
/// validées (voir `FinancesRules.calculerSoldeProjet`).
class Projet {
  const Projet({
    required this.id,
    required this.noeudId,
    required this.nom,
    required this.budgetPrevisionnel,
    required this.devise,
    required this.statut,
  });

  final String id;
  final String noeudId;
  final String nom;
  final int budgetPrevisionnel;
  final String devise;
  final StatutProjet statut;
}
