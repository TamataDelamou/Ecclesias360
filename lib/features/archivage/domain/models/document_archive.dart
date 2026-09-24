import 'dossier_rattache.dart';
import 'niveau_confidentialite.dart';
import 'statut_document_archive.dart';

/// RG-VIII-01/02/04 — document archivé transversal. `numeroArchive` est
/// attribué de façon immuable dès l'archivage : Module VIII ne reçoit jamais
/// de contenu à l'état de brouillon, la validation a lieu dans le module
/// producteur avant l'appel à `ArchivageRepository.archiver` (voir RG-VIII-01,
/// « jamais en brouillon »). `fichier` reflète toujours la dernière version ;
/// `VersionDocument` conserve l'historique complet, y compris la version 1.
/// `moduleOrigine`/`objetIdOrigine` portent la navigation croisée
/// bidirectionnelle vers l'objet métier d'origine (RG-VIII-04) — pas de FK,
/// les modules producteurs sont hétérogènes et certains n'existent pas
/// encore.
class DocumentArchive {
  const DocumentArchive({
    required this.id,
    required this.numeroArchive,
    required this.typeDocument,
    required this.moduleOrigine,
    required this.objetIdOrigine,
    required this.noeudId,
    required this.niveauConfidentialite,
    required this.statut,
    required this.fichier,
    required this.dateArchivage,
    this.dateMiseCorbeille,
    this.dossiersRattaches = const [],
  });

  final String id;
  final String numeroArchive;
  final String typeDocument;
  final String moduleOrigine;
  final String objetIdOrigine;
  final String noeudId;
  final NiveauConfidentialite niveauConfidentialite;
  final StatutDocumentArchive statut;
  final String fichier;
  final DateTime dateArchivage;
  final DateTime? dateMiseCorbeille;

  /// Dossiers disciplinaires dont ce document est l'origine ou une pièce
  /// (vide pour tout autre document) : leur règle d'accès prime sur le
  /// niveau stocké (RG-VIII-03, voir `ArchivageRules.peutConsulterDocument`).
  final List<DossierRattache> dossiersRattaches;

  bool get estDisciplinaire => dossiersRattaches.isNotEmpty;
}
