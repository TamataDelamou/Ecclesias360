/// RG-XXIII-06 — une modification d'un paramètre du Module XXIII, historisée
/// avec son auteur, sa date et la valeur précédente. Les valeurs sont un
/// instantané JSON de l'enregistrement (`null` à la création pour
/// `ancienneValeur`, à la suppression pour `nouvelleValeur`).
class EntreeJournalParametres {
  const EntreeJournalParametres({
    required this.id,
    required this.referentiel,
    required this.objetId,
    required this.action,
    required this.auteurAuthUserId,
    required this.date,
    this.ancienneValeur,
    this.nouvelleValeur,
    this.auteurFideleId,
  });

  final String id;

  /// Table du paramètre modifié (ex. `zones_geographiques`).
  final String referentiel;
  final String objetId;
  final ActionJournalParametres action;
  final String? ancienneValeur;
  final String? nouvelleValeur;
  final String auteurAuthUserId;
  final String? auteurFideleId;
  final DateTime date;
}

/// Mêmes codes que le déclencheur serveur (`tg_op` en minuscules, 0024).
enum ActionJournalParametres {
  creation('insert'),
  modification('update'),
  suppression('delete');

  const ActionJournalParametres(this.code);

  final String code;

  static ActionJournalParametres fromCode(String code) =>
      values.firstWhere((a) => a.code == code, orElse: () => throw ArgumentError('Action de journal inconnue : $code'));
}
