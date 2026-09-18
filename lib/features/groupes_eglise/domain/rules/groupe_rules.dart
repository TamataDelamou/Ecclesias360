import '../../../../core/error/app_error.dart';
import '../../../fideles/domain/models/fidele.dart';
import '../models/criteres_groupe.dart';
import '../models/type_regle_groupe.dart';

/// Règles métier pures du Module VI (RG-VI-*).
abstract final class GroupeRules {
  /// RG-VI-01 — un fidèle correspond aux critères d'un groupe automatique
  /// si tous les critères renseignés correspondent (ET logique, champs
  /// absents = non contraignants).
  static bool correspond(Fidele fidele, CriteresGroupe criteres, {required DateTime maintenant}) {
    if (criteres.sexe != null && fidele.sexe.code != criteres.sexe) return false;
    if (criteres.statutCivil != null && fidele.statutCivil.code != criteres.statutCivil) return false;
    if (criteres.statutSpirituel != null && fidele.statutSpirituel.code != criteres.statutSpirituel) {
      return false;
    }

    if (criteres.ageMin != null || criteres.ageMax != null) {
      final age = _age(fidele.dateNaissance, maintenant);
      if (criteres.ageMin != null && age < criteres.ageMin!) return false;
      if (criteres.ageMax != null && age > criteres.ageMax!) return false;
    }

    return true;
  }

  static int _age(DateTime naissance, DateTime maintenant) {
    var age = maintenant.year - naissance.year;
    final anniversairePasse = (maintenant.month > naissance.month) ||
        (maintenant.month == naissance.month && maintenant.day >= naissance.day);
    if (!anniversairePasse) age -= 1;
    return age;
  }

  /// RG-VI-01 — priorité à la règle automatique en cas de conflit : une
  /// affectation manuelle qui contredit le calcul automatique d'un groupe
  /// n'est autorisée qu'avec une dérogation tracée (motif non vide).
  static AppError? raisonBlocageAffectationManuelle({
    required TypeRegleGroupe typeRegle,
    required bool correspondAuxCriteres,
    required bool aMotifDerogation,
  }) {
    if (typeRegle == TypeRegleGroupe.manuel) return null;
    if (correspondAuxCriteres) return null;
    return aMotifDerogation ? null : AppError.derogationRequisePourAffectationManuelle();
  }
}
