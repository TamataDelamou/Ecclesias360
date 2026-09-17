import '../../../../core/error/app_error.dart';
import '../models/statut_spirituel.dart';

/// Règles métier pures du Module II (RG-II-*). Aucune dépendance Flutter,
/// Drift ou Supabase — testables en isolation.
abstract final class FideleRules {
  /// Chaîne de progression normale (RG-II-02). L'ordre est significatif :
  /// seule une avance d'exactement un cran est autorisée hors import.
  static const List<StatutSpirituel> _chaineProgression = [
    StatutSpirituel.visiteur,
    StatutSpirituel.nouveauConverti,
    StatutSpirituel.baptise,
    StatutSpirituel.membreActif,
  ];

  /// RG-II-02 / RG-II-03 — valide une transition de statut spirituel.
  ///
  /// - [sautHistorique] (import de masse RG-II-09) autorise n'importe
  ///   quelle transition, marquée explicitement comme telle.
  /// - [viaModuleDiscipline] doit être `true` uniquement lorsque l'appel
  ///   provient du Module X — seul déclencheur autorisé du statut
  ///   `membreEnDiscipline` (RG-II-03) ; la fiche fidèle ne peut jamais
  ///   l'atteindre autrement.
  /// - Hors de ces deux cas, seule une progression d'un cran dans la
  ///   chaîne visiteur → nouveau converti → baptisé → membre actif est
  ///   autorisée, ou un passage vers un état terminal (décédé, transféré)
  ///   depuis l'un de ces quatre statuts — le Cahier ne restreint ce
  ///   passage terminal à aucun stade particulier de la progression.
  static void validerTransitionStatutSpirituel({
    required StatutSpirituel actuel,
    required StatutSpirituel cible,
    bool sautHistorique = false,
    bool viaModuleDiscipline = false,
  }) {
    if (sautHistorique) return;

    if (cible == StatutSpirituel.membreEnDiscipline) {
      if (!viaModuleDiscipline) {
        throw AppError.statutDisciplineReserveAuModuleX();
      }
      return;
    }

    if (actuel == StatutSpirituel.membreEnDiscipline && !viaModuleDiscipline) {
      throw ArgumentError('Seul le Module X peut faire sortir un fidèle du statut en discipline.');
    }

    if (actuel == StatutSpirituel.membreDecede) {
      throw ArgumentError('Le statut décédé est terminal.');
    }

    final indexActuel = _chaineProgression.indexOf(actuel);
    if (cible == StatutSpirituel.membreDecede || cible == StatutSpirituel.membreTransfere) {
      if (indexActuel == -1) {
        throw ArgumentError('Transition invalide depuis $actuel vers $cible.');
      }
      return;
    }

    final indexCible = _chaineProgression.indexOf(cible);
    if (indexActuel == -1 || indexCible == -1 || indexCible != indexActuel + 1) {
      throw ArgumentError(
        'Progression invalide de $actuel vers $cible : un seul cran à la fois dans '
        'la chaîne visiteur → nouveau converti → baptisé → membre actif (RG-II-02).',
      );
    }
  }

  /// RG-II-06 — un fidèle est mineur avant 18 ans à la date de référence.
  static bool estMineur(DateTime dateNaissance, {DateTime? reference}) {
    final maintenant = reference ?? DateTime.now();
    var age = maintenant.year - dateNaissance.year;
    final anniversaireDejaPasseCetteAnnee = (maintenant.month > dateNaissance.month) ||
        (maintenant.month == dateNaissance.month && maintenant.day >= dateNaissance.day);
    if (!anniversaireDejaPasseCetteAnnee) age -= 1;
    return age < 18;
  }

  /// RG-II-06 — un tuteur est soit un fidèle enregistré, soit un tiers
  /// identifié par un nom, jamais ni les deux ni aucun des deux.
  static void validerTuteur({required String? tuteurFideleId, required String? tuteurTiersNom}) {
    final aFideleEnregistre = tuteurFideleId != null && tuteurFideleId.isNotEmpty;
    final aTiers = tuteurTiersNom != null && tuteurTiersNom.isNotEmpty;
    if (aFideleEnregistre == aTiers) {
      throw ArgumentError(
        'Un tuteur est soit un fidèle enregistré, soit un tiers identifié par son nom — jamais les deux, jamais aucun.',
      );
    }
  }

  /// RG-II-08 — un fidèle ne peut être supprimé physiquement tant que des
  /// rattachements existent ; seul l'archivage logique est permis. Le
  /// détail des rattachements (finances, discipline, documents) dépend des
  /// modules déjà construits — le dépôt agrège la réponse depuis ce qui
  /// existe réellement.
  static AppError? raisonBlocageSuppression({required bool aDesRattachements}) {
    return aDesRattachements ? AppError.fideleHasBlockingReferences() : null;
  }
}
