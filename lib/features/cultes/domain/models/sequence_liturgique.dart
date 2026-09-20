/// RG-XII-01 — le programme (liturgie) d'un culte est structuré en
/// séquences ordonnées (louange, prédication, offrande, annonces...).
class SequenceLiturgique {
  const SequenceLiturgique({
    required this.id,
    required this.culteId,
    required this.ordre,
    required this.libelle,
    this.responsableId,
    this.dureePrevueMinutes,
  });

  final String id;
  final String culteId;
  final int ordre;
  final String libelle;
  final String? responsableId;
  final int? dureePrevueMinutes;
}
