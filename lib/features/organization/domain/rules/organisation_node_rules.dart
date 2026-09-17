import '../../../../core/error/app_error.dart';
import '../models/categorie_confessionnelle.dart';
import '../models/type_noeud.dart';

/// Règles métier pures du Module I (RG-I-*). Aucune dépendance Flutter,
/// Drift ou Supabase — testables en isolation.
abstract final class OrganisationNodeRules {
  /// RG-I-01 — type fermé, un seul parent, siège = racine unique.
  static void validerCoherenceType({
    required TypeNoeud type,
    required String? noeudParentId,
    required bool racineExisteDeja,
  }) {
    if (type == TypeNoeud.siege) {
      if (noeudParentId != null) {
        throw ArgumentError('Le siège est la racine unique : il ne peut pas avoir de parent.');
      }
      if (racineExisteDeja) {
        throw AppError.rootAlreadyExists();
      }
      return;
    }
    if (noeudParentId == null) {
      throw ArgumentError('Un nœud non-siège doit obligatoirement avoir un nœud parent.');
    }
  }

  /// RG-I-09 — catégorie confessionnelle obligatoire et exclusive aux églises locales.
  static void validerCategorieConfessionnelle({
    required TypeNoeud type,
    required CategorieConfessionnelle? categorie,
  }) {
    final estEgliseLocale = type == TypeNoeud.egliseLocale;
    if (estEgliseLocale && categorie == null) {
      throw ArgumentError('categorie_confessionnelle est obligatoire pour un nœud de type église locale.');
    }
    if (!estEgliseLocale && categorie != null) {
      throw ArgumentError('categorie_confessionnelle ne s\'applique qu\'aux nœuds de type église locale.');
    }
  }

  /// Chemin matérialisé `/id/.../id/`, base du périmètre RG-SEC-05.
  static String construirePath({required String? parentPath, required String nodeId}) {
    final base = (parentPath == null || parentPath.isEmpty) ? '/' : parentPath;
    return '$base$nodeId/';
  }

  /// Profondeur déduite du chemin matérialisé — 0 pour la racine.
  static int calculerProfondeur(String path) {
    final segments = path.split('/').where((segment) => segment.isNotEmpty);
    return segments.length - 1;
  }

  /// RG-I-06 — interdit tout rattachement qui créerait un cycle (un nœud ne
  /// peut pas devenir le descendant de son propre descendant).
  static void validerNouveauRattachement({
    required String nodeId,
    required String nouveauParentId,
    required String nouveauParentPath,
  }) {
    if (nodeId == nouveauParentId) {
      throw ArgumentError('Un nœud ne peut pas être rattaché à lui-même.');
    }
    if (nouveauParentPath.contains('/$nodeId/')) {
      throw ArgumentError(
        'Rattachement circulaire interdit : le nouveau parent est un descendant de ce nœud.',
      );
    }
  }

  /// RG-I-02 — un nœud ne peut être supprimé que s'il n'a plus aucun
  /// rattachement actif (enfants, fidèles, biens, comptes, cultes...). Le
  /// détail des rattachements dépend des modules déjà construits ; le
  /// repository agrège la réponse depuis ce qui existe réellement.
  static AppError? raisonBlocageSuppression({
    required bool aDesEnfants,
    required bool aAutresRattachements,
  }) {
    if (aDesEnfants || aAutresRattachements) {
      return AppError.nodeHasBlockingReferences();
    }
    return null;
  }
}
