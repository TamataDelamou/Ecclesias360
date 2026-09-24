import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../parametres/domain/models/role.dart';
import '../../parametres/domain/rules/capacity_rules.dart';
import '../application/finances_controller.dart';
import '../domain/models/contribution.dart';
import '../domain/rules/finances_rules.dart';

/// Habilitation du compte courant au Module XI (RG-XI-02, RG-SEC-06) : son
/// rôle, sa fiche et les nœuds dont il est trésorier, tirés de la session —
/// plus jamais d'un sélecteur « rôle agissant » / « validé par ».
class AccesFinances {
  const AccesFinances({required this.role, required this.fideleId, required this.noeudsDuTresorier});

  final Role role;

  /// Fiche liée au compte : `null` pour un compte sans fiche, qui ne peut
  /// être tracé comme valideur (RG-XI-02).
  final String? fideleId;
  final Set<String> noeudsDuTresorier;

  bool get _estPasteur => CapacityRules.possede(role: role, roleMinimalRequis: Role.pasteur);

  /// Contributions, validation, rejet, contre-passation d'un nœud.
  bool peutGererContributions(String noeudId) => _estPasteur || noeudsDuTresorier.contains(noeudId);

  bool peutConsulter(Contribution contribution) => FinancesRules.peutConsulterContribution(
        role: role,
        estTresorierDuNoeud: noeudsDuTresorier.contains(contribution.noeudId),
        estDonateur: fideleId != null && contribution.fideleId == fideleId,
      );

  /// Historique financier d'un fidèle (contributions, engagements) : lui-même,
  /// un pasteur (ou plus), ou un trésorier de son nœud.
  bool peutConsulterFidele({required String fideleIdConsulte, required String? noeudDuFidele}) =>
      fideleIdConsulte == fideleId || _estPasteur || (noeudDuFidele != null && noeudsDuTresorier.contains(noeudDuFidele));

  /// Projets d'un nœud (policy `projets_acces`) : rang responsable, porteur
  /// d'un mandat dans le périmètre, ou trésorier du nœud.
  bool peutGererProjets(String noeudId) =>
      CapacityRules.possede(role: role, roleMinimalRequis: Role.responsable) || noeudsDuTresorier.contains(noeudId);

  /// Désignation des trésoriers (policy `tresoriers_noeud_ecriture`).
  bool get peutDesignerTresoriers => _estPasteur;
}

class AccesFinancesBuilder extends StatelessWidget {
  const AccesFinancesBuilder({required this.builder, super.key});

  final Widget Function(BuildContext context, AccesFinances acces) builder;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionController>();
    final fideleId = session.session?.fideleId;
    if (fideleId == null) {
      return builder(context, AccesFinances(role: session.role, fideleId: null, noeudsDuTresorier: const {}));
    }
    return StreamBuilder<Set<String>>(
      stream: context.read<FinancesController>().watchNoeudsDuTresorier(fideleId),
      builder: (context, snapshot) => builder(
        context,
        AccesFinances(role: session.role, fideleId: fideleId, noeudsDuTresorier: snapshot.data ?? const {}),
      ),
    );
  }
}

/// Écran affiché à un compte sans habilitation (RG-SEC-06).
class EcranFinancesAccesReserve extends StatelessWidget {
  const EcranFinancesAccesReserve({required this.titre, super.key});

  final String titre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: Center(child: Text(AppLocalizations.of(context)!.financesAccesReserve)),
    );
  }
}
