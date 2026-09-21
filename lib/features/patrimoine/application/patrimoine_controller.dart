import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../../parametres/domain/models/role.dart';
import '../data/patrimoine_repository.dart';
import '../domain/models/bien.dart';
import '../domain/models/campagne_inventaire.dart';
import '../domain/models/categorie_bien.dart';
import '../domain/models/etat_bien.dart';
import '../domain/models/mouvement_stock.dart';
import '../domain/models/objet_reservation.dart';
import '../domain/models/pointage_inventaire.dart';
import '../domain/models/reservation_bien.dart';
import '../domain/models/type_mouvement_stock.dart';
import '../domain/models/type_sortie_bien.dart';

/// Contrôleur du Module XX, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/bien/campagne — même précédent que `FinancesController`.
class PatrimoineController extends ChangeNotifier {
  PatrimoineController(this._repository);

  final PatrimoineRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  // --- Catégories de biens ----------------------------------------------------

  Stream<List<CategorieBien>> watchCategoriesBien() => _repository.watchCategoriesBien();

  // --- Biens -------------------------------------------------------------------

  Stream<List<Bien>> watchBiens(String noeudId) => _repository.watchBiens(noeudId);

  Future<Bien?> findBienById(String id) => _repository.findBienById(id);

  Future<Bien?> ajouterBien({
    required String idInventaire,
    required String categorieId,
    required String noeudId,
    required String designation,
    required int valeurAcquisition,
    required int valeurVenale,
    required String devise,
    required DateTime dateAcquisition,
    int? seuilAlerteStock,
  }) async {
    Bien? resultat;
    final ok = await _executer(() async {
      resultat = await _repository.ajouterBien(
        idInventaire: idInventaire,
        categorieId: categorieId,
        noeudId: noeudId,
        designation: designation,
        valeurAcquisition: valeurAcquisition,
        valeurVenale: valeurVenale,
        devise: devise,
        dateAcquisition: dateAcquisition,
        seuilAlerteStock: seuilAlerteStock,
      );
    });
    return ok ? resultat : null;
  }

  Future<bool> signalerEtat({required String id, required EtatBien nouvelEtat}) =>
      _executer(() => _repository.signalerEtat(id: id, nouvelEtat: nouvelEtat));

  Future<bool> sortirBien({
    required String id,
    required Role roleActeur,
    required TypeSortieBien typeSortie,
    required String valideParFideleId,
    String? motif,
  }) =>
      _executer(
        () => _repository.sortirBien(
          id: id,
          roleActeur: roleActeur,
          typeSortie: typeSortie,
          valideParFideleId: valideParFideleId,
          motif: motif,
        ),
      );

  // --- Réservations --------------------------------------------------------------

  Stream<List<ReservationBien>> watchReservations(String bienId) => _repository.watchReservations(bienId);

  Future<bool> reserverBien({
    required String bienId,
    required ObjetReservation objetReservation,
    String? culteId,
    String? objetLibre,
    required DateTime dateDebut,
    required DateTime dateFin,
  }) =>
      _executer(
        () => _repository.reserverBien(
          bienId: bienId,
          objetReservation: objetReservation,
          culteId: culteId,
          objetLibre: objetLibre,
          dateDebut: dateDebut,
          dateFin: dateFin,
        ),
      );

  // --- Mouvements de stock ----------------------------------------------------------

  Stream<List<MouvementStock>> watchMouvementsStock(String bienId) => _repository.watchMouvementsStock(bienId);

  Future<bool> enregistrerMouvementStock({
    required String bienId,
    required TypeMouvementStock type,
    required int quantite,
    String? motif,
  }) =>
      _executer(() => _repository.enregistrerMouvementStock(bienId: bienId, type: type, quantite: quantite, motif: motif));

  Future<int> quantiteStock(String bienId) => _repository.quantiteStock(bienId);

  Future<List<Bien>> biensSousSeuilAlerte(String noeudId) => _repository.biensSousSeuilAlerte(noeudId);

  // --- Campagnes d'inventaire et pointages --------------------------------------------

  Stream<List<CampagneInventaire>> watchCampagnesInventaire(String noeudId) =>
      _repository.watchCampagnesInventaire(noeudId);

  Future<CampagneInventaire?> findCampagneById(String id) => _repository.findCampagneById(id);

  Future<CampagneInventaire?> demarrerCampagne({required String noeudId, required String libelle}) async {
    CampagneInventaire? resultat;
    final ok = await _executer(() async {
      resultat = await _repository.demarrerCampagne(noeudId: noeudId, libelle: libelle);
    });
    return ok ? resultat : null;
  }

  Stream<List<PointageInventaire>> watchPointages(String campagneId) => _repository.watchPointages(campagneId);

  Future<bool> enregistrerPointage({
    required String campagneId,
    required String bienId,
    required EtatBien etatConstate,
    int? quantiteConstatee,
    String? commentaire,
  }) =>
      _executer(
        () => _repository.enregistrerPointage(
          campagneId: campagneId,
          bienId: bienId,
          etatConstate: etatConstate,
          quantiteConstatee: quantiteConstatee,
          commentaire: commentaire,
        ),
      );

  Future<bool> cloturerCampagne(String id) => _executer(() => _repository.cloturerCampagne(id));

  Future<bool> _executer(Future<void> Function() action) async {
    _enCours = true;
    _erreur = null;
    notifyListeners();
    try {
      await action();
      _enCours = false;
      notifyListeners();
      return true;
    } on AppError catch (error) {
      _enCours = false;
      _erreur = error.message;
      notifyListeners();
      return false;
    }
  }
}
