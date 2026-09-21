/// RG-XII-03 — publication post-culte, optionnelle. Chaque média non-nul
/// (audio/vidéo/document) est archivé automatiquement dans la médiathèque
/// (Module XIII, RG-XIII-02) via `MediathequeRepository`, injecté en
/// producteur optionnel dans `CulteRepository` — voir
/// `CulteRepository._archiverDansMediathequeSiInjecte`.
class PublicationCulte {
  const PublicationCulte({
    required this.id,
    required this.culteId,
    required this.datePublication,
    this.texteBiblique,
    this.audioUrl,
    this.videoUrl,
    this.pdfUrl,
  });

  final String id;
  final String culteId;
  final DateTime datePublication;
  final String? texteBiblique;
  final String? audioUrl;
  final String? videoUrl;
  final String? pdfUrl;
}
