enum StatutMinistere {
  actif('actif'),
  suspendu('suspendu'),
  archive('archive');

  const StatutMinistere(this.code);

  final String code;

  static StatutMinistere fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut ministère inconnu : $code'),
      );
}
