/// Issue de la liaison automatique d'un compte authentifié à une fiche
/// fidèle (RG-SEC-01, RG-SEC-06bis). Chaque issue est journalisée
/// (`journal_liaisons_comptes`), même celles qui ne lient rien, pour qu'un
/// administrateur puisse repérer a posteriori une liaison douteuse.
enum IssueLiaison {
  /// Une seule fiche correspond à l'identifiant vérifié et n'a jamais été
  /// liée à aucun compte : liaison automatique.
  lieAutomatiquement('lie_automatiquement', enAttenteAdministrateur: false),

  /// Premier compte connecté sur une base vide (aucun nœud racine) :
  /// administrateur d'amorçage, sans fiche fidèle tant qu'il n'en crée pas.
  administrateurAmorcage('administrateur_amorcage', enAttenteAdministrateur: false),

  /// Aucune fiche ne correspond : utilisateur simple (RG-SEC-06bis).
  aucuneCorrespondance('aucune_correspondance', enAttenteAdministrateur: false),

  /// Plusieurs fiches correspondent : on ne choisit jamais à la place de
  /// l'administrateur — utilisateur simple, conflit signalé.
  correspondanceMultiple('correspondance_multiple', enAttenteAdministrateur: true),

  /// La seule fiche correspondante est, ou a déjà été, liée à un autre
  /// compte (même expiré/inactif). Garde-fou contre le recyclage de numéros
  /// de téléphone (SIM churn) : le lien existant n'est jamais écrasé
  /// silencieusement — utilisateur simple, conflit signalé.
  ficheDejaLiee('fiche_deja_liee', enAttenteAdministrateur: true);

  const IssueLiaison(this.code, {required this.enAttenteAdministrateur});

  final String code;

  /// Vrai si l'issue ouvre un conflit à résoudre par un administrateur.
  final bool enAttenteAdministrateur;

  static IssueLiaison fromCode(String code) =>
      values.firstWhere((i) => i.code == code, orElse: () => throw ArgumentError('Issue inconnue : $code'));
}
