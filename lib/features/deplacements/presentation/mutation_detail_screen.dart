import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../../organization/application/organisation_controller.dart';
import '../application/deplacement_controller.dart';
import '../domain/models/cote.dart';
import '../domain/models/lettre_recommandation.dart';
import '../domain/models/mutation.dart';
import '../domain/models/statut_mutation.dart';

/// Écrans « Validation pastorale (origine) » + « Validation pastorale
/// (destination) » + « Lettre de recommandation générée » (RG-IX-01/02)
/// combinés : les deux validations et le lien vers la lettre archivée
/// apparaissent sur une même fiche, plutôt que deux écrans miroirs — même
/// convention que les autres modules (ex. Comité).
class MutationDetailScreen extends StatelessWidget {
  const MutationDetailScreen({required this.mutationId, super.key});

  final String mutationId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DeplacementController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.deplacementsDetailTitre)),
      body: FutureBuilder<Mutation?>(
        future: controller.findById(mutationId),
        builder: (context, snapshot) {
          final mutation = snapshot.data;
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (mutation == null) return Center(child: Text(l10n.deplacementsIntrouvable));

          return _MutationDetailBody(mutation: mutation, controller: controller);
        },
      ),
    );
  }
}

class _MutationDetailBody extends StatefulWidget {
  const _MutationDetailBody({required this.mutation, required this.controller});

  final Mutation mutation;
  final DeplacementController controller;

  @override
  State<_MutationDetailBody> createState() => _MutationDetailBodyState();
}

class _MutationDetailBodyState extends State<_MutationDetailBody> {
  late Mutation _mutation = widget.mutation;

  Future<void> _rafraichir() async {
    final mutation = await widget.controller.findById(_mutation.id);
    if (mounted && mutation != null) setState(() => _mutation = mutation);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organisationController = context.watch<OrganisationController>();
    final fideleController = context.watch<FideleController>();
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();

    final fidele = fideleController.findById(_mutation.fideleId)?.nomComplet ?? '—';
    final origine = organisationController.findById(_mutation.noeudOrigineId)?.nom ?? '—';
    final destination = organisationController.findById(_mutation.noeudDestinationId)?.nom ?? '—';

    final (statutLabel, statutColor) = switch (_mutation.statut) {
      StatutMutation.enAttente => (l10n.deplacementsStatutEnAttente, palette?.warning),
      StatutMutation.validee => (l10n.deplacementsStatutValidee, palette?.success),
      StatutMutation.refusee => (l10n.deplacementsStatutRefusee, Theme.of(context).colorScheme.error),
    };

    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      children: [
        Text(fidele, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppDimensions.spacingSm),
        Chip(
          label: Text(statutLabel),
          backgroundColor: statutColor?.withValues(alpha: 0.16),
          labelStyle: TextStyle(color: statutColor),
          side: BorderSide.none,
        ),
        const Divider(height: AppDimensions.spacingXxl),
        _LigneInfo(label: l10n.deplacementsCoteOrigineLabel, valeur: origine),
        _LigneInfo(label: l10n.deplacementsCoteDestinationLabel, valeur: destination),
        _LigneInfo(label: l10n.deplacementsMotifLabel, valeur: _mutation.motif),
        _LigneInfo(
          label: l10n.deplacementsDateDemandeLabel,
          valeur: _mutation.dateDemande.toIso8601String().split('T').first,
        ),
        if (_mutation.dateValidation != null)
          _LigneInfo(
            label: l10n.deplacementsDateValidationLabel,
            valeur: _mutation.dateValidation!.toIso8601String().split('T').first,
          ),
        if (_mutation.motifRefus != null) _LigneInfo(label: l10n.deplacementsChampMotifRefus, valeur: _mutation.motifRefus!),
        if (_mutation.statut == StatutMutation.enAttente) ...[
          const Divider(height: AppDimensions.spacingXxl),
          Wrap(
            spacing: AppDimensions.spacingSm,
            runSpacing: AppDimensions.spacingSm,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: Text(l10n.deplacementsValiderOrigineBouton),
                onPressed: _mutation.valideeParOrigine
                    ? null
                    : () async {
                        await widget.controller.validerCote(mutationId: _mutation.id, cote: Cote.origine);
                        await _rafraichir();
                      },
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: Text(l10n.deplacementsValiderDestinationBouton),
                onPressed: _mutation.valideeParDestination
                    ? null
                    : () async {
                        await widget.controller.validerCote(mutationId: _mutation.id, cote: Cote.destination);
                        await _rafraichir();
                      },
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.cancel_outlined),
                label: Text(l10n.deplacementsRefuserBouton),
                onPressed: () => _refuser(context),
              ),
            ],
          ),
        ],
        if (_mutation.statut == StatutMutation.validee) ...[
          const Divider(height: AppDimensions.spacingXxl),
          FutureBuilder<LettreRecommandation?>(
            future: widget.controller.lettreDe(_mutation.id),
            builder: (context, snapshot) {
              final lettre = snapshot.data;
              if (lettre == null) return const SizedBox.shrink();
              return OutlinedButton.icon(
                icon: const Icon(Icons.description_outlined),
                label: Text(l10n.deplacementsVoirLettreBouton),
                onPressed: () => context.push(AppRoutes.documentArchive(lettre.documentArchiveId)),
              );
            },
          ),
        ],
        if (widget.controller.erreur != null) ...[
          const SizedBox(height: AppDimensions.spacingLg),
          Text(widget.controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ],
      ],
    );
  }

  Future<void> _refuser(BuildContext context) async {
    final motifController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.deplacementsRefuserTitre),
          content: TextField(
            controller: motifController,
            decoration: InputDecoration(labelText: l10n.deplacementsChampMotifRefus),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.deplacementsRefuserBouton)),
          ],
        );
      },
    );
    if (confirme == true) {
      await widget.controller.refuserMutation(
        mutationId: _mutation.id,
        motifRefus: motifController.text.trim().isEmpty ? null : motifController.text.trim(),
      );
      await _rafraichir();
    }
  }
}

class _LigneInfo extends StatelessWidget {
  const _LigneInfo({required this.label, required this.valeur});

  final String label;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppDimensions.labelColumnWidthNarrow,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}
