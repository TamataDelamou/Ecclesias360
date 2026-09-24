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

  /// RG-XIII-03 — nombre de signalements sur un commentaire publié à
  /// partir duquel il est masqué automatiquement, en attendant une
  /// décision de modération. Le Cahier n'impose pas cette valeur.
  static const int mediathequeSeuilSignalementsAvantMasquage = 3;

  /// Module XXIV — version biblique ouverte par défaut (RG-XXIV-01 : la
  /// seule embarquée), tant que l'utilisateur n'en a pas choisi une autre.
  static const String bibleVersionParDefaut = 'lsg1910';

  /// Module XXIV — rotation du verset du jour (`VersetDuJourRules`), en
  /// identifiants stables (livre 1..66, chapitre, verset) présents dans
  /// toutes les versions. Le Cahier n'impose aucune liste : sélection
  /// initiale, remplaçable sans migration.
  static const List<(int, int, int)> bibleRotationVersetsDuJour = [
    (19, 23, 1), (43, 3, 16), (45, 8, 28), (50, 4, 13), (20, 3, 5), (23, 40, 31), (24, 29, 11),
    (19, 46, 2), (40, 11, 28), (43, 14, 6), (45, 12, 2), (46, 13, 4), (48, 5, 22), (49, 2, 8),
    (58, 11, 1), (59, 1, 5), (60, 5, 7), (62, 4, 8), (19, 119, 105), (6, 1, 9), (5, 31, 6),
    (33, 6, 8), (43, 8, 32), (40, 6, 33), (19, 37, 5), (47, 5, 17), (51, 3, 23), (50, 4, 6),
    (43, 15, 13), (45, 5, 8), (19, 91, 1),
  ];
}
