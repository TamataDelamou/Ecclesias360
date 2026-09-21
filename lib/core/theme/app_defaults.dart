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

  /// RG-IX-01 — le Cahier prévoit qu'une mutation puisse être validée d'un
  /// seul côté (origine ou destination) « si la politique du réseau
  /// l'autorise, paramétrable » : `false` par défaut (les deux nœuds doivent
  /// valider), en l'absence d'un module de politique réseau dédié.
  static const bool deplacementValidationUnilateraleAutorisee = false;

  /// RG-X-04 — pour une sanction à durée indéterminée, intervalle (en jours)
  /// au-delà duquel une revue périodique du dossier est signalée. Le Cahier
  /// n'impose pas cette valeur.
  static const int disciplineRevuePeriodiqueJours = 90;

  /// RG-XI-01 — code devise par défaut des montants (Contribution/Projet).
  /// Le Cahier prévoit `devise_id` référençant le référentiel Kernel « GSG
  /// Referential », non construit (AGENTS.md §11 point 2 : à construire
  /// avec un futur module de facturation, pas avec ce module) — simple code
  /// texte en attendant, remplaçable sans migration lourde.
  static const String financesDeviseParDefaut = 'GNF';

  /// RG-XXI-04 — seuil d'alerte de dépassement budgétaire par défaut
  /// (pourcentage du montant prévu), utilisé quand `Budget.seuilAlertePourcentage`
  /// n'est pas renseigné. Le Cahier prévoit un seuil « paramétrable » sans
  /// imposer de valeur par défaut.
  static const int comptabiliteSeuilAlerteDepassementPourcentageParDefaut = 90;
}
