import 'package:flutter/foundation.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../../parametres/domain/models/role.dart';
import '../data/finances_repository.dart';
import '../domain/models/contribution.dart';
import '../domain/models/depense_projet.dart';
import '../domain/models/echeance_engagement.dart';
import '../domain/models/engagement.dart';
import '../domain/models/origine_contribution.dart';
import '../domain/models/periodicite_engagement.dart';
import '../domain/models/projet.dart';
import '../domain/models/tresorier_noeud.dart';
import '../domain/models/type_engagement.dart';
import '../domain/models/type_offrande.dart';

/// Contrôleur du Module XI, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/fidèle — même précédent que `DisciplineController`/
/// `DeplacementController`.
class FinancesController extends ChangeNotifier {
  FinancesController(this._repository);

  final FinancesRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  // --- Types d'offrande --------------------------------------------------

  Stream<List<TypeOffrande>> watchTypesOffrande() => _repository.watchTypesOffrande();

  // --- Trésoriers ----------------------------------------------------------

  Stream<List<TresorierNoeud>> watchTresoriers(String noeudId) => _repository.watchTresoriers(noeudId);

  Stream<Set<String>> watchNoeudsDuTresorier(String fideleId) => _repository.watchNoeudsDuTresorier(fideleId);

  Future<bool> designerTresorier({required String fideleId, required String noeudId}) =>
      _executer(() => _repository.designerTresorier(fideleId: fideleId, noeudId: noeudId));

  Future<bool> retirerTresorier(String id) => _executer(() => _repository.retirerTresorier(id));

  // --- Contributions ---------------------------------------------------------

  Stream<List<Contribution>> watchContributions(String noeudId) => _repository.watchContributions(noeudId);

  Stream<List<Contribution>> watchContributionsDuFidele(String fideleId) =>
      _repository.watchContributionsDuFidele(fideleId);

  Future<Contribution?> findContributionById(String id) => _repository.findContributionById(id);

  Future<Contribution?> saisirContribution({
    String? fideleId,
    String? libelleDonateurAnonyme,
    required String typeOffrandeId,
    required int montant,
    required String devise,
    required String noeudId,
    String? culteId,
    String? projetId,
    required String modePaiement,
    required OrigineContribution origine,
    required String saisieParFideleId,
  }) async {
    Contribution? resultat;
    final ok = await _executer(() async {
      resultat = await _repository.saisirContribution(
        fideleId: fideleId,
        libelleDonateurAnonyme: libelleDonateurAnonyme,
        typeOffrandeId: typeOffrandeId,
        montant: montant,
        devise: devise,
        noeudId: noeudId,
        culteId: culteId,
        projetId: projetId,
        modePaiement: modePaiement,
        origine: origine,
        saisieParFideleId: saisieParFideleId,
      );
    });
    return ok ? resultat : null;
  }

  Future<bool> validerContribution({required String id, required Role roleActeur, required String valideParFideleId}) =>
      _executer(
        () => _repository.validerContribution(id: id, roleActeur: roleActeur, valideParFideleId: valideParFideleId),
      );

  Future<bool> rejeterContribution({
    required String id,
    required Role roleActeur,
    required String rejeteParFideleId,
    String? motifRejet,
  }) =>
      _executer(
        () => _repository.rejeterContribution(
          id: id,
          roleActeur: roleActeur,
          rejeteParFideleId: rejeteParFideleId,
          motifRejet: motifRejet,
        ),
      );

  Future<bool> contrePasserContribution({
    required String id,
    required Role roleActeur,
    required String valideParFideleId,
    String? motif,
  }) =>
      _executer(
        () => _repository.contrePasserContribution(
          id: id,
          roleActeur: roleActeur,
          valideParFideleId: valideParFideleId,
          motif: motif,
        ),
      );

  Future<List<Contribution>> detecterDoublonsPotentiels(Contribution nouvelle) =>
      _repository.detecterDoublonsPotentiels(nouvelle);

  // --- Projets et dépenses ----------------------------------------------------

  Stream<List<Projet>> watchProjets(String noeudId) => _repository.watchProjets(noeudId);

  Future<Projet?> findProjetById(String id) => _repository.findProjetById(id);

  Future<Projet?> creerProjet({
    required String noeudId,
    required String nom,
    required int budgetPrevisionnel,
    required String devise,
  }) async {
    Projet? resultat;
    final ok = await _executer(() async {
      resultat =
          await _repository.creerProjet(noeudId: noeudId, nom: nom, budgetPrevisionnel: budgetPrevisionnel, devise: devise);
    });
    return ok ? resultat : null;
  }

  Stream<List<DepenseProjet>> watchDepensesProjet(String projetId) => _repository.watchDepensesProjet(projetId);

  Future<int> soldeProjet(String projetId) => _repository.soldeProjet(projetId);

  Future<bool> ajouterDepenseProjet({
    required String projetId,
    required int montant,
    required String libelle,
    required String valideParFideleId,
    bool derogationTracee = false,
    String? motifDerogation,
  }) =>
      _executer(
        () => _repository.ajouterDepenseProjet(
          projetId: projetId,
          montant: montant,
          libelle: libelle,
          valideParFideleId: valideParFideleId,
          derogationTracee: derogationTracee,
          motifDerogation: motifDerogation,
        ),
      );

  // --- Engagements et échéances ------------------------------------------------

  /// RG-SEC-06 : vérifié dans le dépôt pour [acteur] (session), pas
  /// seulement à l'écran.
  Stream<List<Engagement>> watchEngagements(String fideleId, {required Acteur acteur}) =>
      _repository.watchEngagements(fideleId, acteur: acteur);

  Future<Engagement?> creerEngagement({
    required Acteur acteur,
    required String fideleId,
    required TypeEngagement type,
    required int montantPrevu,
    required PeriodiciteEngagement periodicite,
    required DateTime dateDebut,
    int nombreEcheances = 12,
  }) async {
    Engagement? resultat;
    final ok = await _executer(() async {
      resultat = await _repository.creerEngagement(
        acteur: acteur,
        fideleId: fideleId,
        type: type,
        montantPrevu: montantPrevu,
        periodicite: periodicite,
        dateDebut: dateDebut,
        nombreEcheances: nombreEcheances,
      );
    });
    return ok ? resultat : null;
  }

  Stream<List<EcheanceEngagement>> watchEcheances(String engagementId) => _repository.watchEcheances(engagementId);

  Future<bool> honorerEcheance({required Acteur acteur, required String id, required String contributionId}) =>
      _executer(() => _repository.honorerEcheance(acteur: acteur, id: id, contributionId: contributionId));

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
