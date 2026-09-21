/// Statut de publication d'un contenu de la médiathèque (Module XIII,
/// RG-XIII-01).
enum StatutPublicationContenu {
  brouillon('brouillon'),
  publie('publie'),
  retire('retire');

  const StatutPublicationContenu(this.code);

  final String code;

  static StatutPublicationContenu fromCode(String code) => StatutPublicationContenu.values
      .firstWhere((s) => s.code == code, orElse: () => throw ArgumentError('Statut de publication inconnu : $code'));
}
