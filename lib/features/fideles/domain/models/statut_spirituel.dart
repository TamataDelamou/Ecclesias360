/// Machine à états du cheminement spirituel (RG-II-02). Les quatre premiers
/// valeurs forment la chaîne de progression normale ; `membreEnDiscipline`
/// n'est atteignable que depuis le Module X (RG-II-03) ; `membreDecede` et
/// `membreTransfere` sont des états terminaux.
enum StatutSpirituel {
  visiteur('visiteur'),
  nouveauConverti('nouveau_converti'),
  baptise('baptise'),
  membreActif('membre_actif'),
  membreEnDiscipline('membre_en_discipline'),
  membreDecede('membre_decede'),
  membreTransfere('membre_transfere');

  const StatutSpirituel(this.code);

  final String code;

  static StatutSpirituel fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut spirituel inconnu : $code'),
      );
}
