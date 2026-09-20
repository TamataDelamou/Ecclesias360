/// Lettre de recommandation générée automatiquement à la validation d'une
/// mutation (RG-IX-02), archivée dans le Module VIII.
class LettreRecommandation {
  const LettreRecommandation({
    required this.id,
    required this.mutationId,
    required this.documentArchiveId,
  });

  final String id;
  final String mutationId;
  final String documentArchiveId;
}
