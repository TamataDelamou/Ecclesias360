/// Règles pures RG-SEC-05 (cloisonnement hiérarchique), miroir Dart
/// testable des helpers `security definer` PostgreSQL — voir
/// RECONSTRUCTION_ecclesias360.md §3. Sert de source de vérité en
/// l'absence d'infrastructure pgTAP ; le comportement doit rester
/// strictement identique à `noeuds_du_perimetre()` (0004_securite.sql).
abstract final class PerimetreRules {
  /// RG-I-05 — un mandat est actif si `dateFin` est nulle ou future.
  static bool mandatActif({required DateTime? dateFin, DateTime? reference}) {
    final maintenant = reference ?? DateTime.now();
    return dateFin == null || dateFin.isAfter(maintenant);
  }

  /// RG-SEC-05 — nœuds du périmètre : les nœuds où le fidèle courant a un
  /// mandat actif, plus tous leurs descendants (racine incluse, parents et
  /// pairs exclus). [pathParNoeudId] associe chaque id de nœud connu à son
  /// chemin matérialisé (`/id/.../id/`, voir OrganisationNodeRules).
  static Set<String> noeudsDuPerimetre({
    required Iterable<String> racinesMandat,
    required Map<String, String> pathParNoeudId,
  }) {
    final racinesPaths = racinesMandat.map((id) => pathParNoeudId[id]).whereType<String>().toList();

    if (racinesPaths.isEmpty) return const {};

    return pathParNoeudId.entries
        .where((entry) => racinesPaths.any((racinePath) => entry.value.startsWith(racinePath)))
        .map((entry) => entry.key)
        .toSet();
  }
}
