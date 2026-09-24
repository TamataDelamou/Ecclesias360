/// Entité pure VersionBiblique (Module XXIV, RG-XXIV-01) — ligne du
/// référentiel `versions_bibliques`, extensible en données (AGENTS.md §12
/// point 4) : une nouvelle version ou une nouvelle langue est une ligne de
/// plus, jamais une valeur d'enum.
class VersionBiblique {
  const VersionBiblique({
    required this.code,
    required this.nom,
    required this.langue,
    required this.edition,
    required this.licence,
    required this.source,
    required this.embarquee,
    required this.fichier,
    required this.taille,
    required this.sha256,
    required this.nbLivres,
    required this.nbVersets,
  });

  final String code;
  final String nom;
  final String langue;

  /// Édition exacte du texte (jamais seulement le nom du traducteur).
  final String edition;
  final String licence;
  final String source;

  /// `true` : livrée avec l'application ; `false` : téléchargée à la demande
  /// depuis le bucket `corpus-bibliques`, puis lisible hors connexion.
  final bool embarquee;

  /// Nom du fichier compressé (`<code>.db.gz`).
  final String fichier;

  /// Taille (octets) et empreinte SHA-256 du fichier compressé : un
  /// téléchargement qui ne les respecte pas est rejeté.
  final int taille;
  final String sha256;
  final int nbLivres;
  final int nbVersets;
}
