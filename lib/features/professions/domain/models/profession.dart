import '../../../parametres/domain/models/statut_referentiel.dart';

/// RG-V-02 — référentiel de métiers hiérarchisé (catégorie / métier),
/// paramétrable.
class Profession {
  const Profession({
    required this.id,
    required this.code,
    required this.categorie,
    required this.libelle,
    required this.statut,
  });

  final String id;
  final String code;
  final String categorie;
  final String libelle;
  final StatutReferentiel statut;
}
