import '../../../../core/error/app_error.dart';
import '../../../discipline/domain/rules/discipline_rules.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/dossier_rattache.dart';
import '../models/niveau_confidentialite.dart';

/// Règles métier pures du Module VIII (RG-VIII-*).
abstract final class ArchivageRules {
  /// RG-VIII-01 — nomenclature paramétrable : jetons `{type}`, `{noeud}`,
  /// `{annee}`, `{sequence}` (séquence complétée à gauche par des zéros,
  /// largeur fournie par l'appelant — voir `AppDefaults.archivageSequencePadding`).
  static String genererNumero({
    required String modeleNumerotation,
    required String typeDocument,
    required String codeNoeud,
    required int annee,
    required int sequence,
    required int sequencePadding,
  }) {
    final sequenceFormatee = sequence.toString().padLeft(sequencePadding, '0');
    return modeleNumerotation
        .replaceAll('{type}', typeDocument)
        .replaceAll('{noeud}', codeNoeud)
        .replaceAll('{annee}', annee.toString())
        .replaceAll('{sequence}', sequenceFormatee);
  }

  /// RG-VIII-03 — le niveau hérite de ce que déclare le module producteur
  /// (discipline Module X, donnée sensible RG-II-10) : Module VIII ne connaît
  /// pas lui-même la nature métier de l'objet archivé.
  static NiveauConfidentialite niveauConfidentialiteEffectif({required bool sensible}) =>
      sensible ? NiveauConfidentialite.restreint : NiveauConfidentialite.standard;

  /// RG-VIII-03 / RG-X-05 / RG-SEC-06 — consultation d'un document archivé.
  /// Un document rattaché à un dossier disciplinaire (origine ou pièce) suit
  /// la règle d'accès de **chacun** de ces dossiers, quel que soit son niveau
  /// stocké : jamais plus permissif que le dossier lui-même, même si le
  /// niveau venait à être abaissé. Pour tout autre document, le niveau
  /// décide : `restreint` à partir du rang pasteur, `standard` à partir du
  /// rang responsable (porteur d'un mandat — approximation locale du
  /// périmètre de la policy `documents_archive_lecture`, en attendant le
  /// bornage local par périmètre, dette RG-SEC-05). Miroir de
  /// `document_archive_accessible()` (0023).
  static bool peutConsulterDocument({
    required Role role,
    required NiveauConfidentialite niveau,
    required List<DossierRattache> dossiersRattaches,
    required Set<String> commissionsDuConsultant,
  }) {
    if (dossiersRattaches.isNotEmpty) {
      return dossiersRattaches.every(
        (d) =>
            d.trouve &&
            DisciplineRules.peutConsulterDossier(
              role: role,
              estMembreCommissionAssignee: d.commissionId != null && commissionsDuConsultant.contains(d.commissionId),
            ),
      );
    }
    final rangRequis = niveau == NiveauConfidentialite.restreint ? Role.pasteur : Role.responsable;
    return CapacityRules.possede(role: role, roleMinimalRequis: rangRequis);
  }

  /// RG-VIII-05 — purge définitive réservée à un pasteur (ou rôle
  /// supérieur), miroir de la policy `documents_archive_purge` (0019).
  static AppError? raisonBlocagePurge({required Role roleActeur}) {
    if (CapacityRules.possede(role: roleActeur, roleMinimalRequis: Role.pasteur)) return null;
    return AppError.roleInsuffisantPourPurgeDocument();
  }

  /// RG-VIII-05 — purgeable seulement une fois le délai paramétré écoulé
  /// depuis la mise en corbeille ; jamais avant, jamais automatique sans
  /// action explicite d'un administrateur habilité.
  static bool estPurgeable({
    required DateTime dateMiseCorbeille,
    required int delaiPurgeJours,
    required DateTime maintenant,
  }) {
    return !maintenant.isBefore(dateMiseCorbeille.add(Duration(days: delaiPurgeJours)));
  }
}
