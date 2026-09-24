import '../../../../core/error/app_error.dart';
import '../models/mode_presence.dart';
import '../models/valeur_vote.dart';
import '../models/vote_proposition.dart';

/// Règles métier pures du Module XII (RG-XII-*).
abstract final class CulteRules {
  /// RG-XII-02 — les deux modes de présence sont mutuellement exclusifs.
  static AppError? raisonBlocagePresence({
    required ModePresence modeDuCulte,
    required ModePresence modeDemande,
  }) {
    return modeDuCulte == modeDemande ? null : AppError.modePresenceIncompatible();
  }

  /// RG-XII-06 — « les autres fidèles votent » : l'auteur d'une proposition
  /// ne vote jamais sur la sienne. Miroir SQL : policies de
  /// `votes_proposition` (migration 0022).
  static AppError? raisonBlocageVote({required String auteurPropositionId, required String votantId}) {
    return auteurPropositionId == votantId ? AppError.voteSurSaPropreProposition() : null;
  }

  /// RG-XII-05 — génère les dates d'occurrences hebdomadaires futures d'un
  /// culte récurrent (ex. culte dominical), [nombreOccurrences] incluses.
  static List<DateTime> genererDatesRecurrentes({
    required DateTime premiereDateHeure,
    required int nombreOccurrences,
  }) {
    if (nombreOccurrences < 1) return const [];
    return [
      for (var i = 0; i < nombreOccurrences; i++) premiereDateHeure.add(Duration(days: 7 * i)),
    ];
  }

  /// RG-XII-06 — décompte des votes réels, jamais un compteur mutable
  /// indépendant pouvant diverger.
  static ({int likes, int dislikes}) decompterVotes(List<VoteProposition> votes) {
    final likes = votes.where((v) => v.valeur == ValeurVote.jaime).length;
    final dislikes = votes.where((v) => v.valeur == ValeurVote.jenaimepas).length;
    return (likes: likes, dislikes: dislikes);
  }
}
