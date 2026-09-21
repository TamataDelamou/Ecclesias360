/// Statut d'une campagne d'inventaire physique (Module XX, RG-XX-04).
enum StatutCampagneInventaire {
  enCours('en_cours'),
  cloturee('cloturee');

  const StatutCampagneInventaire(this.code);

  final String code;

  static StatutCampagneInventaire fromCode(String code) => StatutCampagneInventaire.values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de campagne d\'inventaire inconnu : $code'),
      );
}
