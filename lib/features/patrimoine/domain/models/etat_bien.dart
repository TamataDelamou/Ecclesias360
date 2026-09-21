/// État d'un bien (Module XX, RG-XX-01). `cede` couvre toute forme de
/// sortie définitive du patrimoine (cession, don, mise au rebut, RG-XX-02) ;
/// la nature précise de la sortie est portée séparément par
/// `Bien.typeSortie`.
enum EtatBien {
  neuf('neuf'),
  bon('bon'),
  aReparer('a_reparer'),
  horsService('hors_service'),
  cede('cede');

  const EtatBien(this.code);

  final String code;

  static EtatBien fromCode(String code) =>
      EtatBien.values.firstWhere((e) => e.code == code, orElse: () => throw ArgumentError('État de bien inconnu : $code'));
}
