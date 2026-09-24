/// Livre d'une version biblique (Module XXIV). [bookId] est stable pour
/// toutes les versions — 1..66 protocanon, 67..73 deutérocanoniques — et ne
/// suit jamais l'ordre d'affichage, porté par [ordre] (propre à la version) :
/// une référence, un favori ou une note reste valable d'une version à
/// l'autre.
class LivreBiblique {
  const LivreBiblique({
    required this.bookId,
    required this.nom,
    required this.abreviation,
    required this.ordre,
    required this.deuterocanonique,
    required this.nbChapitres,
  });

  final int bookId;
  final String nom;
  final String abreviation;
  final int ordre;
  final bool deuterocanonique;
  final int nbChapitres;
}

/// Un verset d'une version biblique.
class VersetBiblique {
  const VersetBiblique({required this.bookId, required this.chapitre, required this.verset, required this.texte});

  final int bookId;
  final int chapitre;
  final int verset;
  final String texte;
}

/// Référence à un chapitre, et éventuellement à un verset, par identifiants
/// stables.
class ReferenceBiblique {
  const ReferenceBiblique({required this.bookId, required this.chapitre, this.verset});

  final int bookId;
  final int chapitre;
  final int? verset;

  @override
  bool operator ==(Object other) =>
      other is ReferenceBiblique && other.bookId == bookId && other.chapitre == chapitre && other.verset == verset;

  @override
  int get hashCode => Object.hash(bookId, chapitre, verset);

  @override
  String toString() => '$bookId $chapitre${verset == null ? '' : ':$verset'}';
}
