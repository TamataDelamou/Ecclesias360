/// RG-XII-03 — publication post-culte, optionnelle. L'archivage
/// automatique dans la médiathèque (Module XIII) reste différé, non
/// construit : cette publication vit uniquement dans le Module XII pour
/// cette itération.
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
