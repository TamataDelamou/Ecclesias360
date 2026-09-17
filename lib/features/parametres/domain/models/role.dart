/// Rôles fermés (RG-XXIII-02), hiérarchie croissante de privilège. Une
/// capacité accordée à un rôle est aussi disponible aux rôles supérieurs
/// (« héritée » — convention déjà en usage avant le sinistre, voir
/// RECONSTRUCTION_ecclesias360.md §3/§6).
enum Role {
  utilisateurSimple('utilisateur_simple'),
  membre('membre'),
  responsable('responsable'),
  pasteur('pasteur'),
  administrateur('administrateur');

  const Role(this.code);

  final String code;

  /// Rang dans la hiérarchie — plus élevé = plus de privilèges.
  int get rang => index;

  static Role fromCode(String code) =>
      values.firstWhere((r) => r.code == code, orElse: () => throw ArgumentError('Rôle inconnu : $code'));
}
