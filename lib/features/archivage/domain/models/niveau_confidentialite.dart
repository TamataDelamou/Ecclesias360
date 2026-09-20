/// RG-VIII-03 — niveau de confidentialité d'un document archivé. `restreint`
/// hérite des documents à caractère disciplinaire (Module X, non construit)
/// ou sensible (Module II, RG-II-10) ; la restriction d'accès effective à la
/// consultation reste différée (bloquée par RG-SEC-01 — aucune session/rôle
/// réel à l'exécution, même précédent que les capacités des Modules
/// I/II/XXIII).
enum NiveauConfidentialite {
  standard('standard'),
  restreint('restreint');

  const NiveauConfidentialite(this.code);

  final String code;

  static NiveauConfidentialite fromCode(String code) => values.firstWhere(
        (v) => v.code == code,
        orElse: () => throw ArgumentError('Niveau de confidentialité inconnu : $code'),
      );
}
