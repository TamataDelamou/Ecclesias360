/// Catégorie de bien (Module XX, RG-XX-01) — référentiel fermé et
/// extensible : le Cahier cite neuf catégories de départ dans l'objectif
/// fonctionnel du module (terrains, bâtiments, véhicules, instruments de
/// musique, caméras, sonorisation, ordinateurs, mobilier, stocks), même
/// précédent que `TypeOffrande`/`NatureFaute`.
class CategorieBien {
  const CategorieBien({
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
  final String statut;
}
