import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import 'acces_finances.dart';

/// Point d'entrée « Engagements des fidèles » d'un nœud, ouvert depuis
/// l'écran Contributions (RG-XI-04, RG-SEC-06). Un trésorier de rang membre
/// n'a pas accès aux fiches des fidèles (policy `fideles`, 0019) : cet écran
/// ne liste que le nom de chaque fidèle rattaché au nœud et mène directement
/// à ses engagements — jamais à sa fiche (historique spirituel, liens,
/// discipline, notes restent fermés).
///
/// Réservé à un pasteur (ou plus) ou à un trésorier de **ce** nœud : un
/// trésorier d'un autre nœud, ou d'un nœud parent, n'y accède pas (même
/// règle que `est_tresorier(noeud_du_fidele(...))` côté serveur).
class EngagementsDuNoeudScreen extends StatelessWidget {
  const EngagementsDuNoeudScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AccesFinancesBuilder(
      builder: (context, acces) {
        if (!acces.peutConsulterEngagementsDuNoeud(noeudId)) {
          return EcranFinancesAccesReserve(titre: l10n.financesEngagementsDuNoeudTitre);
        }
        final fideles = context.watch<FideleController>().fideles.where((f) => f.noeudId == noeudId).toList()
          ..sort((a, b) => a.nomComplet.compareTo(b.nomComplet));
        return Scaffold(
          appBar: AppBar(title: Text(l10n.financesEngagementsDuNoeudTitre)),
          body: fideles.isEmpty
              ? Center(child: Text(l10n.financesEngagementsDuNoeudAucunFidele))
              : ListView.separated(
                  padding: const EdgeInsets.all(AppDimensions.spacingLg),
                  itemCount: fideles.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingSm),
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.event_repeat_outlined),
                      title: Text(fideles[index].nomComplet),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(AppRoutes.engagementsDuFidele(fideles[index].id)),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
