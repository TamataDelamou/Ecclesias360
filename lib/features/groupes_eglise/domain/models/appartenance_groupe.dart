import 'origine_appartenance.dart';

/// RG-VI-01/02 — appartenance d'un fidèle à un groupe (non exclusif,
/// RG-VI-02 : un fidèle peut appartenir à plusieurs groupes simultanément).
/// [motifDerogation] n'est renseigné que pour une affectation manuelle sur
/// un groupe automatique qui contredit le calcul (RG-VI-01).
class AppartenanceGroupe {
  const AppartenanceGroupe({
    required this.id,
    required this.fideleId,
    required this.groupeId,
    required this.dateAffectation,
    required this.origine,
    this.motifDerogation,
  });

  final String id;
  final String fideleId;
  final String groupeId;
  final DateTime dateAffectation;
  final OrigineAppartenance origine;
  final String? motifDerogation;
}
