/// RG-VIII-02 — chaque version est un enregistrement à part entière, jamais
/// écrasée. La version 1 correspond au fichier fourni à l'archivage initial
/// et reste accessible indéfiniment, même après l'ajout de versions
/// ultérieures.
class VersionDocument {
  const VersionDocument({
    required this.id,
    required this.documentId,
    required this.numeroVersion,
    required this.fichier,
    required this.date,
  });

  final String id;
  final String documentId;
  final int numeroVersion;
  final String fichier;
  final DateTime date;
}
