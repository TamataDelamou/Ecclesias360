/// Type fermé d'un contenu de la médiathèque (Module XIII, RG-XIII-01).
enum TypeContenuMediatheque {
  audio('audio'),
  video('video'),
  podcast('podcast'),
  ebook('ebook'),
  magazine('magazine'),
  document('document');

  const TypeContenuMediatheque(this.code);

  final String code;

  static TypeContenuMediatheque fromCode(String code) => TypeContenuMediatheque.values
      .firstWhere((t) => t.code == code, orElse: () => throw ArgumentError('Type de contenu inconnu : $code'));
}
