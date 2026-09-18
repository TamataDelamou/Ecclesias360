import '../../../parametres/domain/models/statut_referentiel.dart';

/// RG-III-04 — catalogue paramétrable des types de ministères. Vingt-quatre
/// types standards fournis par défaut ([standard] = true), non désactivables
/// depuis cette UI (droits d'administration globale non distingués tant que
/// RG-SEC-01 n'est pas construit) ; les types personnalisés le sont.
class TypeMinistere {
  const TypeMinistere({
    required this.id,
    required this.code,
    required this.libelle,
    required this.standard,
    required this.statut,
  });

  final String id;
  final String code;
  final String libelle;
  final bool standard;
  final StatutReferentiel statut;
}
