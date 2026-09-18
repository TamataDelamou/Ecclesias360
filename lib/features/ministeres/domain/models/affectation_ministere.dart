import 'role_affectation.dart';
import 'statut_affectation.dart';

/// RG-III-01 — un fidèle peut être affecté à plusieurs ministères ; au plus
/// un rôle `responsable` actif par ministère.
class AffectationMinistere {
  const AffectationMinistere({
    required this.id,
    required this.ministereId,
    required this.fideleId,
    required this.role,
    required this.dateDebut,
    this.dateFin,
    required this.statut,
  });

  final String id;
  final String ministereId;
  final String fideleId;
  final RoleAffectation role;
  final DateTime dateDebut;
  final DateTime? dateFin;
  final StatutAffectation statut;
}
