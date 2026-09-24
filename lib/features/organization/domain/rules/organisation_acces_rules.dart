import '../../../parametres/domain/models/role.dart';
import '../../../parametres/domain/rules/capacity_rules.dart';
import '../models/type_noeud.dart';

/// Règles pures d'accès au Module I (RG-SEC-04/05), miroir local des
/// policies `organisation_nodes` et `node_responsables` de 0019. Le
/// périmètre hiérarchique (nœuds d'un mandat actif et leurs descendants)
/// est approché par le rang responsable, en attendant le bornage local par
/// périmètre (dette RG-SEC-05, inventaire du Module II). Le serveur reste la
/// source de vérité ; les capacités de `roles.json` (création de niveau
/// supérieur, annuaire) sont appliquées par `CapacitesController`.
abstract final class OrganisationAccesRules {
  static bool _auMoins(Role role, Role requis) => CapacityRules.possede(role: role, roleMinimalRequis: requis);

  /// Arbre complet (périmètre) : rang responsable. En dessous, un fidèle
  /// enregistré ne voit que son Église (policy : « son église »), un
  /// utilisateur simple rien (RG-SEC-06bis).
  static bool voitToutLArbre(Role role) => _auMoins(role, Role.responsable);

  static bool peutConsulterNoeud({required Role role, required String noeudId, required String? noeudDuConsultant}) =>
      voitToutLArbre(role) || (_auMoins(role, Role.membre) && noeudDuConsultant == noeudId);

  /// Modifier, archiver, ajouter un nœud enfant, historique des rattachements.
  static bool peutGererNoeuds(Role role) => _auMoins(role, Role.responsable);

  /// Désigner ou retirer un responsable (policy : périmètre ∧ pasteur).
  static bool peutDesignerResponsables(Role role) => _auMoins(role, Role.pasteur);

  /// RG-I-03 — seule l'église locale se crée au rang de gestion ; tout nœud
  /// d'un niveau supérieur (et sa validation) exige la capacité
  /// `creer_noeud_niveau_superieur`.
  static bool exigeCapaciteNiveauSuperieur(TypeNoeud type) => type != TypeNoeud.egliseLocale;
}
