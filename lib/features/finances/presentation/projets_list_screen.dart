import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../application/finances_controller.dart';
import '../domain/models/projet.dart';
import 'acces_finances.dart';

/// Écran « Liste des projets » (RG-XI-03), scopé à un nœud.
class ProjetsListScreen extends StatelessWidget {
  const ProjetsListScreen({required this.noeudId, super.key});

  final String noeudId;

  Future<void> _creerProjet(BuildContext context, FinancesController controller) async {
    final nomController = TextEditingController();
    final budgetController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.financesProjetCreerTitre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomController, decoration: InputDecoration(labelText: l10n.financesChampNomProjet)),
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.financesChampBudgetPrevisionnel,
                  suffixText: AppDefaults.financesDeviseParDefaut,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonCreer)),
          ],
        );
      },
    );

    final budget = int.tryParse(budgetController.text.trim()) ?? 0;
    if (confirme == true && nomController.text.trim().isNotEmpty && context.mounted) {
      final projet = await controller.creerProjet(
        noeudId: noeudId,
        nom: nomController.text.trim(),
        budgetPrevisionnel: budget,
        devise: AppDefaults.financesDeviseParDefaut,
      );
      if (projet != null && context.mounted) {
        context.push(AppRoutes.projet(projet.id));
      }
    }
  }

  /// Accès réservé (policy `projets_acces`, 0019) au rang responsable et au
  /// trésorier du nœud.
  @override
  Widget build(BuildContext context) {
    return AccesFinancesBuilder(
      builder: (context, acces) => acces.peutGererProjets(noeudId)
          ? _construire(context)
          : EcranFinancesAccesReserve(titre: AppLocalizations.of(context)!.financesProjetsTitre),
    );
  }

  Widget _construire(BuildContext context) {
    final controller = context.read<FinancesController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financesProjetsTitre)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _creerProjet(context, controller),
        tooltip: l10n.financesProjetCreerTooltip,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Projet>>(
        stream: controller.watchProjets(noeudId),
        builder: (context, snapshot) {
          final projets = snapshot.data ?? const <Projet>[];
          if (projets.isEmpty) {
            return Center(child: Text(l10n.financesProjetsAucun));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            itemCount: projets.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingSm),
            itemBuilder: (context, index) {
              final projet = projets[index];
              return StaggeredFadeIn(
                index: index,
                child: Card(
                  child: ListTile(
                    onTap: () => context.push(AppRoutes.projet(projet.id)),
                    title: Text(projet.nom),
                    subtitle: FutureBuilder<int>(
                      future: controller.soldeProjet(projet.id),
                      builder: (context, soldeSnapshot) => Text(
                        l10n.financesProjetSoldeSurBudget(
                          soldeSnapshot.data ?? 0,
                          projet.budgetPrevisionnel,
                          projet.devise,
                        ),
                      ),
                    ),
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
