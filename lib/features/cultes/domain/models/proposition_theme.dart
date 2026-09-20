import 'statut_proposition.dart';

/// RG-XII-06 — [categorie] reste `null` tant que le classement automatique
/// par l'assistant IA (Module XVI) n'est pas construit ; [nbLikes]/
/// [nbDislikes] sont calculés à partir des votes réels (`VoteProposition`),
/// jamais des compteurs mutables indépendants pouvant diverger.
class PropositionTheme {
  const PropositionTheme({
    required this.id,
    required this.fideleId,
    required this.titre,
    required this.statut,
    required this.dateSoumission,
    required this.nbLikes,
    required this.nbDislikes,
    this.explication,
    this.categorie,
  });

  final String id;
  final String fideleId;
  final String titre;
  final String? explication;
  final String? categorie;
  final StatutProposition statut;
  final DateTime dateSoumission;
  final int nbLikes;
  final int nbDislikes;
}
