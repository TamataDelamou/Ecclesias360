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
