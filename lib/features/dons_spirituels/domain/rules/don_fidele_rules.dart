import '../models/don_fidele.dart';
import '../models/don_ministere_compatible.dart';

/// Règles métier pures du Module IV (RG-IV-*).
abstract final class DonFideleRules {
  /// RG-IV-02 — l'historique n'est jamais écrasé : l'évaluation courante
  /// est la plus récente par [DonFidele.dateEvaluation].
  static DonFidele? evaluationCourante(List<DonFidele> evaluations) {
    if (evaluations.isEmpty) return null;
    return evaluations.reduce((a, b) => a.dateEvaluation.isAfter(b.dateEvaluation) ? a : b);
  }

  /// RG-IV-03 — types de ministères compatibles avec un don, à partir de la
  /// table de correspondance (suggestion uniquement, jamais d'affectation
  /// automatique).
  static List<String> typesMinisteresCompatibles(
    String donId,
    List<DonMinistereCompatible> correspondances,
  ) {
    return correspondances
        .where((c) => c.donId == donId)
        .map((c) => c.typeMinistereId)
        .toList(growable: false);
  }

  /// Statistiques de répartition (écran 6, « vue locale ») — pour chaque
  /// don, le nombre de fidèles de [fideleIds] dont l'évaluation courante
  /// (RG-IV-02) le concerne.
  static Map<String, int> repartitionParDon(
    List<DonFidele> evaluations, {
    required Set<String> fideleIds,
  }) {
    final parPaire = <String, List<DonFidele>>{};
    for (final evaluation in evaluations) {
      if (!fideleIds.contains(evaluation.fideleId)) continue;
      parPaire.putIfAbsent('${evaluation.fideleId}|${evaluation.donId}', () => []).add(evaluation);
    }

    final compteur = <String, int>{};
    for (final groupe in parPaire.values) {
      final courante = evaluationCourante(groupe);
      if (courante != null) {
        compteur.update(courante.donId, (n) => n + 1, ifAbsent: () => 1);
      }
    }
    return compteur;
  }
}
