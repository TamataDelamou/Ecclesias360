/// Foyer unique des valeurs par défaut des règles métier qui ne sont pas
/// imposées par le Cahier (voir AGENTS.md §5) — à ne pas dupliquer ailleurs.
abstract final class AppDefaults {
  /// RG-III-02 — horizon par défaut (en jours) pour lister les mandats de
  /// responsable de ministère arrivant à échéance. Le Cahier n'impose pas
  /// cette valeur ; auparavant écrite deux fois (`MinistereRules` et
  /// `MinistereController`), désormais centralisée ici.
  static const int mandatEcheanceHorizonJours = 30;

  /// RG-VIII-01 — largeur (nombre de chiffres) de la séquence dans un numéro
  /// d'archive généré (ex. 0007). Le Cahier n'impose pas cette valeur.
  static const int archivageSequencePadding = 4;

  /// RG-VIII-05 — délai par défaut (en jours) avant qu'un document mis en
  /// corbeille devienne purgeable. Le Cahier n'impose pas cette valeur.
  static const int archivageDelaiPurgeJoursParDefaut = 365;
}
