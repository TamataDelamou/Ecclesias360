/// RG-VIII-01 — modèle de numérotation paramétrable par type de document.
/// `modeleNumerotation` accepte les jetons `{type}`, `{noeud}`, `{annee}` et
/// `{sequence}` (voir `ArchivageRules.genererNumero`).
class NomenclatureArchivage {
  const NomenclatureArchivage({
    required this.id,
    required this.typeDocument,
    required this.modeleNumerotation,
  });

  final String id;
  final String typeDocument;
  final String modeleNumerotation;
}
