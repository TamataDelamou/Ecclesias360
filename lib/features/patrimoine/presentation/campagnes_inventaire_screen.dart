import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../application/patrimoine_controller.dart';
import '../domain/models/campagne_inventaire.dart';
import '../domain/models/statut_campagne_inventaire.dart';

/// Écran « Campagnes d'inventaire (liste) » du Cahier (RG-XX-04) — accessible
/// depuis [BiensListScreen] par l'icône de la barre d'app, même motif que
/// l'accès aux trésoriers depuis l'écran Contributions du Module XI.
class CampagnesInventaireScreen extends StatelessWidget {
  const CampagnesInventaireScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PatrimoineController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.patrimoineCampagnesTitre)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _demarrerCampagne(context, controller),
        tooltip: l10n.patrimoineCampagneDemarrerTooltip,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<CampagneInventaire>>(
        stream: controller.watchCampagnesInventaire(noeudId),
        builder: (context, snapshot) {
          final campagnes = snapshot.data ?? const <CampagneInventaire>[];
          if (campagnes.isEmpty) {
            return Center(child: Text(l10n.patrimoineCampagnesAucune));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            itemCount: campagnes.length,
            itemBuilder: (context, index) {
              final campagne = campagnes[index];
              return StaggeredFadeIn(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.spacingSm),
                  child: Card(
                    child: ListTile(
                      title: Text(campagne.libelle),
                      subtitle: Text(campagne.dateDebut.toIso8601String().split('T').first),
                      trailing: Chip(
                        label: Text(
                          campagne.statut == StatutCampagneInventaire.enCours
                              ? l10n.patrimoineCampagneEnCours
                              : l10n.patrimoineCampagneCloturee,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide.none,
                      ),
                      onTap: () => context.push(AppRoutes.campagneInventaire(campagne.id)),
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

  Future<void> _demarrerCampagne(BuildContext context, PatrimoineController controller) async {
    final libelleController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.patrimoineCampagneDemarrerTitre),
          content: TextField(
            controller: libelleController,
            decoration: InputDecoration(labelText: l10n.patrimoineChampLibelleCampagne),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.patrimoineCampagneDemarrerBouton)),
          ],
        );
      },
    );

    if (confirme == true && libelleController.text.trim().isNotEmpty && context.mounted) {
      final campagne = await controller.demarrerCampagne(noeudId: noeudId, libelle: libelleController.text.trim());
      if (campagne != null && context.mounted) {
        context.push(AppRoutes.campagneInventaire(campagne.id));
      }
    }
  }
}
