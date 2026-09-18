/// RG-V-01 — une profession déclarée par un fidèle passe de `declare` à
/// `verifie` une fois confirmée par un responsable ; jamais l'inverse.
enum StatutVerification {
  declare('declare'),
  verifie('verifie');

  const StatutVerification(this.code);

  final String code;

  static StatutVerification fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de vérification inconnu : $code'),
      );
}
