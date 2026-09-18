/// RG-VII-02 — correction tracée d'un procès-verbal déjà validé, ne
/// modifie jamais le contenu original.
class ErratumPv {
  const ErratumPv({
    required this.id,
    required this.procesVerbalId,
    required this.texte,
    required this.dateAjout,
    this.auteurFideleId,
  });

  final String id;
  final String procesVerbalId;
  final String texte;
  final DateTime dateAjout;
  final String? auteurFideleId;
}
