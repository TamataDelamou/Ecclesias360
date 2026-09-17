import 'statut_referentiel.dart';

/// Entité pure ZoneGeographique (Module XXIII, référentiel consommé par le
/// Module I — RG-I-05).
class ZoneGeographique {
  const ZoneGeographique({
    required this.id,
    required this.libelle,
    required this.niveau,
    required this.statut,
    this.parentId,
  });

  final String id;
  final String libelle;
  final int niveau;
  final String? parentId;
  final StatutReferentiel statut;
}
