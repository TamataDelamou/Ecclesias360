import 'valeur_vote.dart';

/// RG-XII-06 — un vote par fidèle et par proposition (contrainte UNIQUE),
/// modifiable (le fidèle peut changer d'avis, jamais voter deux fois pour
/// le même sens).
class VoteProposition {
  const VoteProposition({
    required this.id,
    required this.propositionId,
    required this.fideleId,
    required this.valeur,
  });

  final String id;
  final String propositionId;
  final String fideleId;
  final ValeurVote valeur;
}
