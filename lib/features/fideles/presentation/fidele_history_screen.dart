import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/fidele_controller.dart';
import '../domain/models/historique_fidele.dart';
import '../domain/rules/fidele_acces_rules.dart';

/// Écran 6 (Historique des modifications, RG-II-05).
class FideleHistoryScreen extends StatelessWidget {
  const FideleHistoryScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FideleController>();
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();
    // RG-II-10 : son propre historique, ou le rang de gestion (RG-SEC-04).
    if (!FideleAccesRules.peutConsulterFiche(
      role: session.role,
      fideleId: fideleId,
      fideleIdConsultant: session.session?.fideleId,
    )) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.fidelesTitre)),
        body: Center(child: Text(l10n.fidelesAccesReserve)),
      );
    }
    final fidele = controller.findById(fideleId);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fideleHistoriqueTitre(fidele?.nomComplet ?? fideleId))),
      body: StreamBuilder<List<HistoriqueFidele>>(
        stream: controller.watchHistorique(fideleId),
        builder: (context, snapshot) {
          final entrees = snapshot.data ?? const <HistoriqueFidele>[];
          if (entrees.isEmpty) {
            return Center(child: Text(l10n.fideleHistoriqueAucune));
          }
          return ListView.separated(
            itemCount: entrees.length,
            separatorBuilder: (_, _) => const Divider(height: AppDimensions.dividerHairline),
            itemBuilder: (context, index) {
              final entree = entrees[index];
              return ListTile(
                title: Text('${entree.champModifie} : ${entree.ancienneValeur ?? '—'} → ${entree.nouvelleValeur ?? '—'}'),
                // RG-II-05 : auteur et date de la modification.
                subtitle: Text(
                  l10n.fideleHistoriqueAuteurDate(
                    entree.auteurFideleId == null
                        ? l10n.fideleHistoriqueAuteurInconnu
                        : controller.findById(entree.auteurFideleId!)?.nomComplet ?? '—',
                    entree.date.toString().split('.').first,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
