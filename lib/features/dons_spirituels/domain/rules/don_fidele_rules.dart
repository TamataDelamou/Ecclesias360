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
}
