import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/application/session_controller.dart';
import '../../parametres/domain/models/role.dart';
import '../../parametres/domain/rules/capacity_rules.dart';
import '../application/discipline_controller.dart';
import '../domain/models/commission_disciplinaire.dart';
import '../domain/models/dossier_disciplinaire.dart';
import '../domain/rules/discipline_rules.dart';

/// Habilitation du compte courant au Module X (RG-X-01/05, RG-SEC-06) :
/// son rôle et les commissions dont il est membre, tirés de la session —
/// plus jamais d'un sélecteur « rôle agissant ».
class AccesDiscipline {
  const AccesDiscipline({required this.role, required this.commissions});

  final Role role;
  final List<CommissionDisciplinaire> commissions;

  bool get estPasteur => CapacityRules.possede(role: role, roleMinimalRequis: Role.pasteur);

  /// Accès au module : pasteur (ou plus), ou membre d'au moins une commission.
  bool get aAcces => estPasteur || commissions.isNotEmpty;

  bool peutConsulter(DossierDisciplinaire dossier) => DisciplineRules.peutConsulterDossier(
    role: role,
    estMembreCommissionAssignee: commissions.any((c) => c.id == dossier.commissionId),
  );

  bool peutOuvrir(String noeudId) =>
      DisciplineRules.raisonBlocageOuverture(
        roleActeur: role,
        estMembreCommission: commissions.any((c) => c.noeudId == noeudId),
      ) ==
      null;
}

class AccesDisciplineBuilder extends StatelessWidget {
  const AccesDisciplineBuilder({required this.builder, super.key});

  final Widget Function(BuildContext context, AccesDiscipline acces) builder;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionController>();
    final fideleId = session.session?.fideleId;
    if (fideleId == null) {
      return builder(context, AccesDiscipline(role: session.role, commissions: const []));
    }
    return StreamBuilder<List<CommissionDisciplinaire>>(
      stream: context.read<DisciplineController>().watchCommissionsDuFidele(fideleId),
      builder: (context, snapshot) =>
          builder(context, AccesDiscipline(role: session.role, commissions: snapshot.data ?? const [])),
    );
  }
}
