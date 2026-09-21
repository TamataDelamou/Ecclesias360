import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/etat_bien.dart';

/// Règles métier pures du Module XX (RG-XX-*).
abstract final class PatrimoineRules {
  /// RG-XX-02 — la sortie d'un bien (cession, don, mise au rebut) exige un
  /// rôle habilité (même seuil que la validation comptable du Module XI,
  /// RG-XI-02 : pasteur ou rôle supérieur).
  static AppError? raisonBlocageSortieBien({required Role roleActeur, required bool dejaSorti}) {
    if (dejaSorti) return AppError.bienDejaSorti();
    if (CapacityRules.possede(role: roleActeur, roleMinimalRequis: Role.pasteur)) return null;
    return AppError.roleInsuffisantPourSortieBien();
  }

  /// RG-XX-03 — deux plages se chevauchent si l'une démarre avant que
  /// l'autre ne se termine, dans les deux sens.
  static bool seChevauchent({
    required DateTime debutA,
    required DateTime finA,
    required DateTime debutB,
    required DateTime finB,
  }) {
    return debutA.isBefore(finB) && debutB.isBefore(finA);
  }

  /// RG-XX-03 — empêche tout conflit de double réservation sur la même
  /// plage horaire pour un même bien.
  static AppError? raisonBlocageReservation({
    required DateTime dateDebut,
    required DateTime dateFin,
    required List<(DateTime debut, DateTime fin)> reservationsExistantes,
  }) {
    final conflit = reservationsExistantes.any(
      (r) => seChevauchent(debutA: dateDebut, finA: dateFin, debutB: r.$1, finB: r.$2),
    );
    return conflit ? AppError.reservationConflitDetecte() : null;
  }

  /// RG-XX-05 — quantité en stock recalculée à la lecture (entrées moins
  /// sorties), jamais un compteur mutable stocké (même précédent que le
  /// solde de projet, Module XI, RG-XI-03).
  static int calculerQuantiteStock({required int totalEntrees, required int totalSorties}) {
    return totalEntrees - totalSorties;
  }

  /// RG-XX-05 — un bien à gestion de stock est sous son seuil d'alerte de
  /// réapprovisionnement quand la quantité actuelle ne l'atteint plus.
  static bool estSousSeuilAlerte({required int quantiteActuelle, required int? seuilAlerte}) {
    if (seuilAlerte == null) return false;
    return quantiteActuelle < seuilAlerte;
  }

  /// RG-XX-04 — un écart d'inventaire est détecté quand l'état constaté sur
  /// le terrain diffère de l'état déclaré au système, ou, pour un bien à
  /// gestion de stock, quand la quantité constatée diffère de la quantité
  /// déclarée.
  static bool detecterEcart({
    required EtatBien etatDeclare,
    required EtatBien etatConstate,
    int? quantiteDeclaree,
    int? quantiteConstatee,
  }) {
    if (etatDeclare != etatConstate) return true;
    if (quantiteDeclaree != null && quantiteConstatee != null && quantiteDeclaree != quantiteConstatee) {
      return true;
    }
    return false;
  }
}
