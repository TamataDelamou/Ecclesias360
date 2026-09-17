import 'categorie_confessionnelle.dart';
import 'statut_noeud.dart';
import 'type_noeud.dart';

/// Entité pure NœudOrganisationnel (Module I, RG-I-*).
class OrganisationNode {
  const OrganisationNode({
    required this.id,
    required this.typeNoeud,
    required this.noeudParentId,
    required this.nom,
    required this.codeInterne,
    required this.statut,
    required this.path,
    required this.depth,
    required this.createdAt,
    required this.updatedAt,
    this.logoUrl,
    this.cachetUrl,
    this.dateFondation,
    this.categorieConfessionnelle,
    this.zoneGeoId,
  });

  final String id;
  final TypeNoeud typeNoeud;
  final String? noeudParentId;
  final String nom;
  final String codeInterne;
  final StatutNoeud statut;
  final String? logoUrl;
  final String? cachetUrl;
  final DateTime? dateFondation;
  final CategorieConfessionnelle? categorieConfessionnelle;
  final String? zoneGeoId;

  /// Chemin matérialisé `/id/id/.../id/` (racine → ce nœud inclus), utilisé
  /// par `noeuds_du_perimetre()` (RG-SEC-05) pour les requêtes de descendance.
  final String path;

  /// Profondeur dans l'arbre — 0 pour la racine (siège).
  final int depth;

  final DateTime createdAt;
  final DateTime updatedAt;

  bool get estRacine => typeNoeud == TypeNoeud.siege;

  OrganisationNode copyWith({
    TypeNoeud? typeNoeud,
    String? noeudParentId,
    bool clearNoeudParentId = false,
    String? nom,
    String? codeInterne,
    StatutNoeud? statut,
    String? logoUrl,
    String? cachetUrl,
    DateTime? dateFondation,
    CategorieConfessionnelle? categorieConfessionnelle,
    String? zoneGeoId,
    String? path,
    int? depth,
    DateTime? updatedAt,
  }) {
    return OrganisationNode(
      id: id,
      typeNoeud: typeNoeud ?? this.typeNoeud,
      noeudParentId: clearNoeudParentId ? null : (noeudParentId ?? this.noeudParentId),
      nom: nom ?? this.nom,
      codeInterne: codeInterne ?? this.codeInterne,
      statut: statut ?? this.statut,
      logoUrl: logoUrl ?? this.logoUrl,
      cachetUrl: cachetUrl ?? this.cachetUrl,
      dateFondation: dateFondation ?? this.dateFondation,
      categorieConfessionnelle: categorieConfessionnelle ?? this.categorieConfessionnelle,
      zoneGeoId: zoneGeoId ?? this.zoneGeoId,
      path: path ?? this.path,
      depth: depth ?? this.depth,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
