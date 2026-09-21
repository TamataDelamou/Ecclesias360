/// Nature de la sortie définitive d'un bien du patrimoine (Module XX,
/// RG-XX-02) : cession (vente), don, ou mise au rebut.
enum TypeSortieBien {
  cession('cession'),
  don('don'),
  miseAuRebut('mise_au_rebut');

  const TypeSortieBien(this.code);

  final String code;

  static TypeSortieBien fromCode(String code) => TypeSortieBien.values
      .firstWhere((t) => t.code == code, orElse: () => throw ArgumentError('Type de sortie de bien inconnu : $code'));
}
