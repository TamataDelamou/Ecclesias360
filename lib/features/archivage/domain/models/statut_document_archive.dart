/// RG-VIII-05 — un document archivé n'est jamais supprimé directement :
/// seule la mise en corbeille réversible (`enCorbeille`) est permise, suivie
/// d'une purge explicite une fois le délai paramétré écoulé (voir
/// `ArchivageRules.estPurgeable` et `ArchivageRepository.purgerDefinitivement`).
enum StatutDocumentArchive {
  actif('actif'),
  enCorbeille('en_corbeille');

  const StatutDocumentArchive(this.code);

  final String code;

  static StatutDocumentArchive fromCode(String code) => values.firstWhere(
        (v) => v.code == code,
        orElse: () => throw ArgumentError('Statut de document archivé inconnu : $code'),
      );
}
