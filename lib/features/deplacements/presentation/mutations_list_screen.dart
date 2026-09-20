import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../../organization/application/organisation_controller.dart';
import '../application/deplacement_controller.dart';
import '../domain/models/mutation.dart';
import '../domain/models/statut_mutation.dart';

/// Écrans « Liste des mutations » (scopé par nœud) et « Historique des
/// déplacements d'un fidèle » (RG-IX-03), regroupés sur un seul écran
/// réutilisable selon le paramètre fourni. Le nœud combine en outre l'écran
/// « Demande de mutation » via le bouton d'ajout (RG-IX-01).
class MutationsListScreen extends StatelessWidget {
  const MutationsListScreen({this.noeudId, this.fideleId, super.key})
      : assert(
          (noeudId == null) != (fideleId == null),
          'MutationsListScreen attend soit noeudId, soit fideleId, jamais les deux ni aucun.',
        );

  final String? noeudId;
  final String? fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DeplacementController>();
    final l10n = AppLocalizations.of(context)!;
    final parNoeud = noeudId != null;

    return Scaffold(
      appBar: AppBar(title: Text(parNoeud ? l10n.deplacementsTitre : l10n.deplacementsHistoriqueTitre)),
      floatingActionButton: parNoeud
          ? FloatingActionButton(
              onPressed: () => _demanderMutation(context, controller, noeudId!),
              child: const Icon(Icons.add),
            )
          : null,
      body: StreamBuilder<List<Mutation>>(
        stream: controller.watchMutations(noeudId: noeudId, fideleId: fideleId),
        builder: (context, snapshot) {
          final mutations = snapshot.data ?? const <Mutation>[];
          if (mutations.isEmpty) {
            return Center(child: Text(parNoeud ? l10n.deplacementsAucuneMutation : l10n.deplacementsAucunDeplacement));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            itemCount: mutations.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingSm),
            itemBuilder: (context, index) {
              final mutation = mutations[index];
              return StaggeredFadeIn(
                index: index,
                child: _MutationCard(mutation: mutation, onTap: () => context.push(AppRoutes.mutation(mutation.id))),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _demanderMutation(
    BuildContext context,
    DeplacementController controller,
    String noeudOrigineId,
  ) async {
    final organisationController = context.read<OrganisationController>();
    final fideleController = context.read<FideleController>();
    final motifController = TextEditingController();
    final fidelesDuNoeud = fideleController.fideles.where((f) => f.noeudId == noeudOrigineId).toList();
    final autresNoeuds = organisationController.nodes.where((n) => n.id != noeudOrigineId).toList();
    String? fideleId = fidelesDuNoeud.isEmpty ? null : fidelesDuNoeud.first.id;
    String? noeudDestinationId = autresNoeuds.isEmpty ? null : autresNoeuds.first.id;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.deplacementsDemanderTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: fideleId,
                  decoration: InputDecoration(labelText: l10n.deplacementsChampFidele),
                  items: fidelesDuNoeud
                      .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                      .toList(),
                  onChanged: (valeur) => setState(() => fideleId = valeur),
                ),
                DropdownButtonFormField<String>(
                  initialValue: noeudDestinationId,
                  decoration: InputDecoration(labelText: l10n.deplacementsChampNoeudDestination),
                  items: autresNoeuds
                      .map((n) => DropdownMenuItem(value: n.id, child: Text(n.nom)))
                      .toList(),
                  onChanged: (valeur) => setState(() => noeudDestinationId = valeur),
                ),
                TextField(
                  controller: motifController,
                  decoration: InputDecoration(labelText: l10n.deplacementsChampMotif),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonEnregistrer)),
            ],
          ),
        );
      },
    );

    if (confirme == true &&
        fideleId != null &&
        noeudDestinationId != null &&
        motifController.text.trim().isNotEmpty) {
      await controller.demanderMutation(
        fideleId: fideleId!,
        noeudOrigineId: noeudOrigineId,
        noeudDestinationId: noeudDestinationId!,
        motif: motifController.text.trim(),
      );
    }
  }
}

class _MutationCard extends StatelessWidget {
  const _MutationCard({required this.mutation, required this.onTap});

  final Mutation mutation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organisationController = context.watch<OrganisationController>();
    final fideleController = context.watch<FideleController>();
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();

    final origine = organisationController.findById(mutation.noeudOrigineId)?.nom ?? '—';
    final destination = organisationController.findById(mutation.noeudDestinationId)?.nom ?? '—';
    final fidele = fideleController.findById(mutation.fideleId)?.nomComplet ?? '—';

    final (statutLabel, statutColor) = switch (mutation.statut) {
      StatutMutation.enAttente => (l10n.deplacementsStatutEnAttente, palette?.warning),
      StatutMutation.validee => (l10n.deplacementsStatutValidee, palette?.success),
      StatutMutation.refusee => (l10n.deplacementsStatutRefusee, Theme.of(context).colorScheme.error),
    };

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(fidele),
        subtitle: Text('$origine → $destination'),
        trailing: Chip(
          label: Text(statutLabel),
          backgroundColor: statutColor?.withValues(alpha: 0.16),
          labelStyle: TextStyle(color: statutColor),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
