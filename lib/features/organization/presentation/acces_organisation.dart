import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../auth/application/session_controller.dart';
import '../../fideles/application/fidele_controller.dart';
import '../../parametres/application/capacites_controller.dart';
import '../domain/models/type_noeud.dart';
import '../domain/rules/organisation_acces_rules.dart';

/// Nœud de rattachement de la fiche liée à la session (« son église »),
/// `null` pour un compte sans fiche.
String? noeudDuConsultant(BuildContext context) {
  final fideleId = context.watch<SessionController>().session?.fideleId;
  return fideleId == null ? null : context.watch<FideleController>().findById(fideleId)?.noeudId;
}

/// Capacité de `roles.json` accordée au compte courant (refus par défaut,
/// voir `CapacitesController`).
bool capaciteAccordee(BuildContext context, String capacite) =>
    context.watch<CapacitesController>().accorde(capacite: capacite, role: context.watch<SessionController>().role);

/// RG-I-03 — créer (ou valider) un nœud de ce type : l'église locale au rang
/// de gestion, tout niveau supérieur avec la capacité dédiée.
bool peutCreerOuValiderType(BuildContext context, TypeNoeud type) =>
    OrganisationAccesRules.exigeCapaciteNiveauSuperieur(type)
    ? capaciteAccordee(context, Capacites.creerNoeudNiveauSuperieur)
    : OrganisationAccesRules.peutGererNoeuds(context.watch<SessionController>().role);
