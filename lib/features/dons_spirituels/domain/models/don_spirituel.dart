/// RG-IV-04 — référentiel fixe des neuf dons spirituels (1 Corinthiens 12),
/// non modifiable dans cette itération (paramétrage en extension via le
/// Module XXIII, différé).
class DonSpirituel {
  const DonSpirituel({
    required this.id,
    required this.code,
    required this.libelle,
    required this.descriptionBiblique,
  });

  final String id;
  final String code;
  final String libelle;
  final String descriptionBiblique;
}
