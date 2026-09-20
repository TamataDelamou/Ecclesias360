/// RG-X-02 — nature d'une pièce versée à un dossier disciplinaire.
enum NaturePieceDossier {
  temoignage('temoignage'),
  preuve('preuve');

  const NaturePieceDossier(this.code);

  final String code;

  static NaturePieceDossier fromCode(String code) => values.firstWhere(
        (n) => n.code == code,
        orElse: () => throw ArgumentError('Nature de pièce de dossier inconnue : $code'),
      );
}
