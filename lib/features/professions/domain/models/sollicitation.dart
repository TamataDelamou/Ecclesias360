/// RG-V-03 — sollicitation nommée d'un fidèle (via son groupe professionnel)
/// pour un projet ou une action sociale, avec traçabilité de la réponse.
class Sollicitation {
  const Sollicitation({
    required this.id,
    required this.fideleId,
    required this.objet,
    required this.date,
    this.reponse,
  });

  final String id;
  final String fideleId;
  final String objet;
  final DateTime date;
  final String? reponse;
}
