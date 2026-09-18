enum TypeActiviteMinistere {
  reunion('reunion'),
  rapport('rapport');

  const TypeActiviteMinistere(this.code);

  final String code;

  static TypeActiviteMinistere fromCode(String code) => values.firstWhere(
        (t) => t.code == code,
        orElse: () => throw ArgumentError("Type d'activité inconnu : $code"),
      );
}

/// RG-III-05 — journal d'activités du ministère (réunions, rapports
/// d'activité).
class ActiviteMinistere {
  const ActiviteMinistere({
    required this.id,
    required this.ministereId,
    required this.type,
    required this.description,
    required this.date,
    this.auteurFideleId,
  });

  final String id;
  final String ministereId;
  final TypeActiviteMinistere type;
  final String description;
  final DateTime date;
  final String? auteurFideleId;
}
