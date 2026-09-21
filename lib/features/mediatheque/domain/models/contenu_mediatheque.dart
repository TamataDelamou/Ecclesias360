import 'statut_publication_contenu.dart';
import 'type_contenu_mediatheque.dart';

/// Contenu de la médiathèque chrétienne (Module XIII, RG-XIII-01 à 05).
///
/// Le champ [fichier] est une simple référence (URL ou texte) vers le
/// média : cette itération ne construit ni téléversement de fichier réel,
/// ni lecture audio/vidéo, ni téléchargement hors ligne, ni gestion de
/// l'espace de stockage local (décision explicite : « métadonnées
/// seulement »).
class ContenuMediatheque {
  const ContenuMediatheque({
    required this.id,
    required this.typeContenu,
    required this.titre,
    this.sourceModule,
    this.sourceId,
    required this.noeudEditeurId,
    this.fichier,
    required this.theme,
    this.motsCles = const [],
    this.intervenant,
    required this.dateContenu,
    required this.statut,
    required this.droitsTelechargement,
    required this.moderationAPriori,
    this.compteurConsultations = 0,
  });

  final String id;
  final TypeContenuMediatheque typeContenu;
  final String titre;

  /// Module d'origine si ce contenu a été archivé automatiquement (ex.
  /// 'XII' pour une publication de culte) ; `null` pour un contenu saisi
  /// directement dans la médiathèque.
  final String? sourceModule;

  /// Identifiant de l'entité d'origine dans le module source (ex. l'id du
  /// culte) ; `null` si [sourceModule] est `null`.
  final String? sourceId;

  final String noeudEditeurId;

  /// Référence (URL ou texte libre) vers le média ; aucun fichier binaire
  /// n'est stocké ni géré par l'application dans cette itération.
  final String? fichier;

  final String theme;
  final List<String> motsCles;
  final String? intervenant;
  final DateTime dateContenu;
  final StatutPublicationContenu statut;
  final bool droitsTelechargement;
  final bool moderationAPriori;
  final int compteurConsultations;

  ContenuMediatheque copierAvec({
    String? id,
    TypeContenuMediatheque? typeContenu,
    String? titre,
    Object? sourceModule = _sentinelle,
    Object? sourceId = _sentinelle,
    String? noeudEditeurId,
    Object? fichier = _sentinelle,
    String? theme,
    List<String>? motsCles,
    Object? intervenant = _sentinelle,
    DateTime? dateContenu,
    StatutPublicationContenu? statut,
    bool? droitsTelechargement,
    bool? moderationAPriori,
    int? compteurConsultations,
  }) {
    return ContenuMediatheque(
      id: id ?? this.id,
      typeContenu: typeContenu ?? this.typeContenu,
      titre: titre ?? this.titre,
      sourceModule: sourceModule == _sentinelle ? this.sourceModule : sourceModule as String?,
      sourceId: sourceId == _sentinelle ? this.sourceId : sourceId as String?,
      noeudEditeurId: noeudEditeurId ?? this.noeudEditeurId,
      fichier: fichier == _sentinelle ? this.fichier : fichier as String?,
      theme: theme ?? this.theme,
      motsCles: motsCles ?? this.motsCles,
      intervenant: intervenant == _sentinelle ? this.intervenant : intervenant as String?,
      dateContenu: dateContenu ?? this.dateContenu,
      statut: statut ?? this.statut,
      droitsTelechargement: droitsTelechargement ?? this.droitsTelechargement,
      moderationAPriori: moderationAPriori ?? this.moderationAPriori,
      compteurConsultations: compteurConsultations ?? this.compteurConsultations,
    );
  }
}

const _sentinelle = Object();
