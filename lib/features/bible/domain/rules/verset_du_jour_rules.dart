import '../models/livre_biblique.dart';

/// Origine du verset du jour retenu.
enum OrigineVersetDuJour { manuel, plan, rotation }

/// Règles pures du verset du jour (Module XXIV). Précédence : un verset
/// désigné manuellement, puis le passage du jour d'un plan de lecture suivi,
/// puis une rotation déterministe par date.
///
/// Seule la rotation est alimentée aujourd'hui : aucune entité du Cahier ne
/// porte un verset « manuel » (source différée, décision du porteur du
/// projet, 2026-09-24), et les plans de lecture arrivent au Lot B. L'ordre de
/// précédence est néanmoins fixé ici, pour qu'aucune source ajoutée plus tard
/// ne le redéfinisse.
abstract final class VersetDuJourRules {
  static (ReferenceBiblique, OrigineVersetDuJour) choisir({
    required DateTime date,
    required List<ReferenceBiblique> rotation,
    ReferenceBiblique? manuel,
    ReferenceBiblique? plan,
  }) {
    if (manuel != null) return (manuel, OrigineVersetDuJour.manuel);
    if (plan != null) return (plan, OrigineVersetDuJour.plan);
    if (rotation.isEmpty) throw ArgumentError('La rotation des versets du jour est vide.');
    // Jour calendaire (UTC) : le même verset pour toute la journée, quelle
    // que soit l'heure ou le fuseau de consultation.
    final jour = DateTime.utc(date.year, date.month, date.day).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
    return (rotation[jour % rotation.length], OrigineVersetDuJour.rotation);
  }
}
