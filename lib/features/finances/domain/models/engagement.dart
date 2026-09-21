import 'periodicite_engagement.dart';
import 'statut_engagement.dart';
import 'type_engagement.dart';

/// Engagement récurrent d'un fidèle (Module XI, RG-XI-04) — génère des
/// échéances suivies (voir `EcheanceEngagement`).
class Engagement {
  const Engagement({
    required this.id,
    required this.fideleId,
    required this.type,
    required this.montantPrevu,
    required this.periodicite,
    required this.dateDebut,
    required this.statut,
  });

  final String id;
  final String fideleId;
  final TypeEngagement type;
  final int montantPrevu;
  final PeriodiciteEngagement periodicite;
  final DateTime dateDebut;
  final StatutEngagement statut;
}
