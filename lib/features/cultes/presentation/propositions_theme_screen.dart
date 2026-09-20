import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/culte_controller.dart';
import '../domain/models/proposition_theme.dart';
import '../domain/models/valeur_vote.dart';
import '../domain/models/vote_proposition.dart';

/// Écran « Propositions de thème » (RG-XII-06) — soumission et vote. En
/// l'absence de session réelle (RG-SEC-01 non construit), un sélecteur de
/// fidèle actif détermine l'auteur des soumissions et des votes, comme
/// convention établie ailleurs dans l'application.
class PropositionsThemeScreen extends StatefulWidget {
  const PropositionsThemeScreen({super.key});

  @override
  State<PropositionsThemeScreen> createState() => _PropositionsThemeScreenState();
}

class _PropositionsThemeScreenState extends State<PropositionsThemeScreen> {
  String? _fideleActifId;

  Future<void> _soumettreProposition(BuildContext context, CulteController controller) async {
    if (_fideleActifId == null) return;
    final titreController = TextEditingController();
    final explicationController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.propositionSoumettreTitre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titreController, decoration: InputDecoration(labelText: l10n.propositionChampTitre)),
              TextField(
                controller: explicationController,
                decoration: InputDecoration(labelText: l10n.propositionChampExplication),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
          ],
        );
      },
    );

    if (confirme == true && titreController.text.trim().isNotEmpty) {
      await controller.soumettreProposition(
        fideleId: _fideleActifId!,
        titre: titreController.text.trim(),
        explication: explicationController.text.trim().isEmpty ? null : explicationController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CulteController>();
    final fideles = context.watch<FideleController>().fideles;
    final l10n = AppLocalizations.of(context)!;
    _fideleActifId ??= fideles.isNotEmpty ? fideles.first.id : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.propositionsThemeTitre),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimensions.spacingXxl),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
            child: DropdownButtonFormField<String>(
              initialValue: _fideleActifId,
              decoration: InputDecoration(labelText: l10n.propositionsVoterEnTantQue),
              items: [for (final fidele in fideles) DropdownMenuItem(value: fidele.id, child: Text(fidele.nomComplet))],
              onChanged: (valeur) => setState(() => _fideleActifId = valeur),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<PropositionTheme>>(
        stream: controller.watchPropositions(),
        builder: (context, snapshot) {
          final propositions = snapshot.data ?? const <PropositionTheme>[];
          if (propositions.isEmpty) {
            return Center(child: Text(l10n.propositionsAucune));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            itemCount: propositions.length,
            itemBuilder: (context, index) => _PropositionTile(
              proposition: propositions[index],
              controller: controller,
              fideleActifId: _fideleActifId,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fideleActifId == null ? null : () => _soumettreProposition(context, controller),
        tooltip: l10n.propositionSoumettreTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PropositionTile extends StatelessWidget {
  const _PropositionTile({required this.proposition, required this.controller, required this.fideleActifId});

  final PropositionTheme proposition;
  final CulteController controller;
  final String? fideleActifId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(proposition.titre, style: Theme.of(context).textTheme.titleMedium),
            if (proposition.explication != null) Text(proposition.explication!),
            const SizedBox(height: AppDimensions.spacingSm),
            StreamBuilder<List<VoteProposition>>(
              stream: controller.watchVotes(proposition.id),
              builder: (context, snapshot) {
                final votes = snapshot.data ?? const <VoteProposition>[];
                ValeurVote? voteActif;
                for (final vote in votes) {
                  if (vote.fideleId == fideleActifId) {
                    voteActif = vote.valeur;
                    break;
                  }
                }
                return Row(
                  children: [
                    IconButton.filledTonal(
                      isSelected: voteActif == ValeurVote.jaime,
                      icon: const Icon(Icons.thumb_up_outlined),
                      onPressed: fideleActifId == null
                          ? null
                          : () => controller.voter(
                              propositionId: proposition.id,
                              fideleId: fideleActifId!,
                              valeur: ValeurVote.jaime,
                            ),
                    ),
                    Text('${proposition.nbLikes}'),
                    const SizedBox(width: AppDimensions.spacingMd),
                    IconButton.filledTonal(
                      isSelected: voteActif == ValeurVote.jenaimepas,
                      icon: const Icon(Icons.thumb_down_outlined),
                      onPressed: fideleActifId == null
                          ? null
                          : () => controller.voter(
                              propositionId: proposition.id,
                              fideleId: fideleActifId!,
                              valeur: ValeurVote.jenaimepas,
                            ),
                    ),
                    Text('${proposition.nbDislikes}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
