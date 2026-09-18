import 'statut_verification.dart';

/// RG-V-01 — déclaration d'une profession/compétence par un fidèle.
class ProfessionFidele {
  const ProfessionFidele({
    required this.id,
    required this.fideleId,
    required this.professionId,
    required this.statutVerification,
    this.anneesExperience,
  });

  final String id;
  final String fideleId;
  final String professionId;
  final StatutVerification statutVerification;
  final int? anneesExperience;
}
