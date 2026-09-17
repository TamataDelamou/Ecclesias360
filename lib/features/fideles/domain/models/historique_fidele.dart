/// Entité pure HistoriqueFidele (RG-II-05) — historisation des
/// modifications de champs sensibles (statut spirituel, coordonnées,
/// photo) avec auteur et date.
class HistoriqueFidele {
  const HistoriqueFidele({
    required this.id,
    required this.fideleId,
    required this.champModifie,
    required this.ancienneValeur,
    required this.nouvelleValeur,
    required this.auteurFideleId,
    required this.date,
  });

  final String id;
  final String fideleId;
  final String champModifie;
  final String? ancienneValeur;
  final String? nouvelleValeur;
  final String? auteurFideleId;
  final DateTime date;
}
