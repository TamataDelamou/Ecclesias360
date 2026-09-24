import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/organisation_controller.dart';
import '../domain/models/historique_rattachement.dart';
import '../domain/rules/organisation_acces_rules.dart';

/// Écran 6 (Historique des rattachements, RG-I-06).
class RattachementHistoryScreen extends StatelessWidget {
  const RattachementHistoryScreen({required this.nodeId, super.key});

  final String nodeId;

  @override
  Widget build(BuildContext context) {
    // Gardé aussi contre l'accès direct par la route (RG-SEC-04).
    if (!OrganisationAccesRules.peutGererNoeuds(context.watch<SessionController>().role)) {
      return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.organisationTitre)),
        body: Center(child: Text(AppLocalizations.of(context)!.organisationAccesReserve)),
      );
    }
    final controller = context.read<OrganisationController>();
    final noeud = controller.findById(nodeId);

    return Scaffold(
      appBar: AppBar(title: Text('Historique — ${noeud?.nom ?? nodeId}')),
      body: StreamBuilder<List<HistoriqueRattachement>>(
        stream: controller.watchHistorique(nodeId),
        builder: (context, snapshot) {
          final entrees = snapshot.data ?? const <HistoriqueRattachement>[];
          if (entrees.isEmpty) {
            return const Center(child: Text('Aucun changement de rattachement enregistré.'));
          }
          return ListView.separated(
            itemCount: entrees.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entree = entrees[index];
              final ancien = entree.ancienParentId == null
                  ? 'aucun (racine)'
                  : controller.findById(entree.ancienParentId!)?.nom ?? entree.ancienParentId!;
              final nouveau =
                  controller.findById(entree.nouveauParentId)?.nom ?? entree.nouveauParentId;
              return ListTile(
                title: Text('$ancien → $nouveau'),
                subtitle: Text(
                  [
                    entree.dateEffet.toIso8601String(),
                    if (entree.motif != null && entree.motif!.isNotEmpty) entree.motif!,
                  ].join(' · '),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
