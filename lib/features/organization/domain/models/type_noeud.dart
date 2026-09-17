/// Types fermés de nœud organisationnel (RG-I-01). L'ordre reflète la
/// hiérarchie de consolidation, du siège (racine) vers l'église locale
/// (feuille) — utile pour les tris et les validations de rattachement.
enum TypeNoeud {
  siege('siege'),
  directionInternationale('direction_internationale'),
  directionNationale('direction_nationale'),
  union('union'),
  mission('mission'),
  reseau('reseau'),
  prefecture('prefecture'),
  region('region'),
  zone('zone'),
  district('district'),
  secteur('secteur'),
  egliseLocale('eglise_locale');

  const TypeNoeud(this.code);

  final String code;

  static TypeNoeud fromCode(String code) => values.firstWhere(
        (type) => type.code == code,
        orElse: () => throw ArgumentError('Type de nœud inconnu : $code'),
      );
}
