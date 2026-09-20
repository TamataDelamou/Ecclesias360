/// Foyer unique des valeurs par défaut des règles métier qui ne sont pas
/// imposées par le Cahier (voir AGENTS.md §5) — à ne pas dupliquer ailleurs.
abstract final class AppDefaults {
  /// RG-III-02 — horizon par défaut (en jours) pour lister les mandats de
  /// responsable de ministère arrivant à échéance. Le Cahier n'impose pas
  /// cette valeur ; auparavant écrite deux fois (`MinistereRules` et
  /// `MinistereController`), désormais centralisée ici.
  static const int mandatEcheanceHorizonJours = 30;
}
