enum RoleAffectation {
  membre('membre'),
  responsable('responsable');

  const RoleAffectation(this.code);

  final String code;

  static RoleAffectation fromCode(String code) => values.firstWhere(
        (r) => r.code == code,
        orElse: () => throw ArgumentError("Rôle d'affectation inconnu : $code"),
      );
}
