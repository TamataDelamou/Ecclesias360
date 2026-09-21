import 'statut_moderation_commentaire.dart';

/// Commentaire déposé sur un contenu de la médiathèque, soumis à
/// modération a priori ou a posteriori selon le contenu (Module XIII,
/// RG-XIII-03).
class Commentaire {
  const Commentaire({
    required this.id,
    required this.contenuId,
    required this.fideleId,
    required this.texte,
    required this.statutModeration,
    required this.date,
    this.nombreSignalements = 0,
  });

  final String id;
  final String contenuId;
  final String fideleId;
  final String texte;
  final StatutModerationCommentaire statutModeration;
  final DateTime date;
  final int nombreSignalements;

  Commentaire copierAvec({
    String? id,
    String? contenuId,
    String? fideleId,
    String? texte,
    StatutModerationCommentaire? statutModeration,
    DateTime? date,
    int? nombreSignalements,
  }) {
    return Commentaire(
      id: id ?? this.id,
      contenuId: contenuId ?? this.contenuId,
      fideleId: fideleId ?? this.fideleId,
      texte: texte ?? this.texte,
      statutModeration: statutModeration ?? this.statutModeration,
      date: date ?? this.date,
      nombreSignalements: nombreSignalements ?? this.nombreSignalements,
    );
  }
}
