import '../../../../core/error/app_error.dart';
import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/type_noeud.dart';

/// Règles pures d'accès au Module I (RG-SEC-04/05), miroir local des
/// policies `organisation_nodes` et `node_responsables` de 0019. Le
/// périmètre hiérarchique (nœuds d'un mandat actif et leurs descendants)
/// est approché par le rang responsable, en attendant le bornage local par
/// périmètre (dette RG-SEC-05, inventaire du Module II). Appliquées par
/// `OrganisationController` avant tout appel au dépôt (le blocage est à la
/// source, pas à l'affichage) et reprises par les écrans ; le serveur reste
/// la source de vérité. La capacité de `roles.json` (niveau supérieur) est
/// fournie par l'appelant, jamais figée ici.
abstract final class OrganisationAccesRules {
  static bool _auMoins(Role role, Role requis) => CapacityRules.possede(role: role, roleMinimalRequis: requis);

  /// Arbre complet (périmètre) : rang responsable. En dessous, un fidèle
  /// enregistré ne voit que son Église (policy : « son église »), un
  /// utilisateur simple rien (RG-SEC-06bis).
  static bool voitToutLArbre(Role role) => _auMoins(role, Role.responsable);

  static bool peutConsulterNoeud({required Role role, required String noeudId, required String? noeudDuConsultant}) =>
      voitToutLArbre(role) || (_auMoins(role, Role.membre) && noeudDuConsultant == noeudId);

  /// Modifier, archiver, rattacher ailleurs, historique des rattachements,
  /// liste des responsables.
  static bool peutGererNoeuds(Role role) => _auMoins(role, Role.responsable);

  /// Désigner ou retirer un responsable (policy : périmètre ∧ pasteur).
  static bool peutDesignerResponsables(Role role) => _auMoins(role, Role.pasteur);

  /// Suppression physique (RG-I-02) : policy `organisation_nodes` → administrateur.
  static bool peutSupprimerNoeud(Role role) => _auMoins(role, Role.administrateur);

  /// RG-I-03 — seule l'église locale se crée au rang de gestion ; tout nœud
  /// d'un niveau supérieur (et sa validation) exige la capacité
  /// `creer_noeud_niveau_superieur`.
  static bool exigeCapaciteNiveauSuperieur(TypeNoeud type) => type != TypeNoeud.egliseLocale;

  /// RG-I-03 — créer ou valider un nœud de ce type. [capaciteNiveauSuperieur] :
  /// la capacité `creer_noeud_niveau_superieur` est-elle accordée au compte.
  static bool peutCreerOuValider({
    required TypeNoeud type,
    required Role role,
    required bool capaciteNiveauSuperieur,
  }) => exigeCapaciteNiveauSuperieur(type) ? capaciteNiveauSuperieur : peutGererNoeuds(role);

  static AppError? raisonBlocageCreationOuValidation({
    required TypeNoeud type,
    required Role role,
    required bool capaciteNiveauSuperieur,
  }) {
    if (peutCreerOuValider(type: type, role: role, capaciteNiveauSuperieur: capaciteNiveauSuperieur)) return null;
    return exigeCapaciteNiveauSuperieur(type)
        ? AppError.capaciteNiveauSuperieurRequise()
        : AppError.gestionOrganisationReservee();
  }

  static AppError? raisonBlocageGestion({required Role role}) =>
      peutGererNoeuds(role) ? null : AppError.gestionOrganisationReservee();

  static AppError? raisonBlocageDesignation({required Role role}) =>
      peutDesignerResponsables(role) ? null : AppError.designationResponsablesReservee();

  static AppError? raisonBlocageSuppression({required Role role}) =>
      peutSupprimerNoeud(role) ? null : AppError.suppressionNoeudReservee();
}
