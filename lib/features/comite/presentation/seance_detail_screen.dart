import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/comite_controller.dart';
import '../domain/models/decision.dart';
import '../domain/models/erratum_pv.dart';
import '../domain/models/proces_verbal.dart';
import '../domain/models/seance_comite.dart';
import '../domain/models/statut_decision.dart';
import '../domain/models/statut_proces_verbal.dart';
import '../domain/models/tache_suivi.dart';

/// Écran 5 (Enregistrement des décisions et votes) + écran 6 (PV, rédaction
/// et validation) + écran 7 (Suivi des tâches, imbriqué par décision),
/// RG-VII-02/03/04/05.
class SeanceDetailScreen extends StatelessWidget {
  const SeanceDetailScreen({required this.seanceId, super.key});

  final String seanceId;

  Future<void> _ajouterDecision(BuildContext context, ComiteController controller) async {
    final libelleController = TextEditingController();
    final resultatController = TextEditingController();
    bool porteeDisciplinaire = false;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.comiteAjouterDecisionTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: libelleController, decoration: InputDecoration(labelText: l10n.comiteChampLibelle)),
                TextField(
                  controller: resultatController,
                  decoration: InputDecoration(labelText: l10n.comiteChampResultatVote),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: porteeDisciplinaire,
                  title: Text(l10n.comiteChampPorteeDisciplinaire),
                  onChanged: (v) => setState(() => porteeDisciplinaire = v ?? false),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );

    if (confirme == true && libelleController.text.trim().isNotEmpty) {
      await controller.ajouterDecision(
        seanceId: seanceId,
        libelle: libelleController.text.trim(),
        resultatVote: resultatController.text.trim().isEmpty ? null : resultatController.text.trim(),
        porteeDisciplinaire: porteeDisciplinaire,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ComiteController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.comiteSeanceTitre)),
      body: FutureBuilder<SeanceComite?>(
        future: controller.findSeanceById(seanceId),
        builder: (context, snapshot) {
          final seance = snapshot.data;
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (seance == null) return Center(child: Text(l10n.comiteSeanceIntrouvableCorps));

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              Text(seance.ordreDuJour, style: Theme.of(context).textTheme.titleLarge),
              Text(seance.date.toIso8601String().split('T').first),
              Chip(
                label: Text(
                  seance.quorumAtteint == null
                      ? l10n.comiteQuorumNonConfigure
                      : seance.quorumAtteint!
                          ? l10n.comiteQuorumAtteint
                          : l10n.comiteQuorumNonAtteint,
                ),
              ),
              const Divider(height: AppDimensions.spacingXxl),
              Row(
                children: [
                  Text(l10n.comiteDecisionsTitre, style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text(l10n.commonAjouter),
                    onPressed: () => _ajouterDecision(context, controller),
                  ),
                ],
              ),
              _DecisionsSection(seanceId: seanceId, controller: controller),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.comiteProcesVerbalTitre, style: Theme.of(context).textTheme.titleMedium),
              _ProcesVerbalSection(seanceId: seanceId, controller: controller),
            ],
          );
        },
      ),
    );
  }
}

class _DecisionsSection extends StatelessWidget {
  const _DecisionsSection({required this.seanceId, required this.controller});

  final String seanceId;
  final ComiteController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Decision>>(
      stream: controller.watchDecisions(seanceId),
      builder: (context, snapshot) {
        final decisions = snapshot.data ?? const <Decision>[];
        if (decisions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSm),
            child: Text(AppLocalizations.of(context)!.comiteAucuneDecision),
          );
        }
        return Column(
          children: [for (final decision in decisions) _DecisionTile(decision: decision, controller: controller)],
        );
      },
    );
  }
}

class _DecisionTile extends StatelessWidget {
  const _DecisionTile({required this.decision, required this.controller});

  final Decision decision;
  final ComiteController controller;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(decision.libelle),
      subtitle: Text(
        '${decision.statut.code}'
        '${decision.resultatVote != null ? ' · ${decision.resultatVote}' : ''}'
        '${decision.porteeDisciplinaire ? ' · portée disciplinaire' : ''}',
      ),
      children: [
        Wrap(
          spacing: 8,
          children: [
            for (final statut in StatutDecision.values)
              OutlinedButton(
                onPressed: statut == decision.statut
                    ? null
                    : () => controller.changerStatutDecision(id: decision.id, statut: statut),
                child: Text(statut.code),
              ),
          ],
        ),
        if (controller.erreur != null)
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingSm),
            child: Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        _TachesSection(decisionId: decision.id, controller: controller),
      ],
    );
  }
}

class _TachesSection extends StatelessWidget {
  const _TachesSection({required this.decisionId, required this.controller});

  final String decisionId;
  final ComiteController controller;

  Future<void> _ajouterTache(BuildContext context, FideleController fideleController) async {
    final fideles = fideleController.fideles;
    if (fideles.isEmpty) return;

    String assigneFideleId = fideles.first.id;
    final descriptionController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.comiteAjouterTacheTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: descriptionController, decoration: InputDecoration(labelText: l10n.commonDescription)),
                DropdownButtonFormField<String>(
                  initialValue: assigneFideleId,
                  decoration: InputDecoration(labelText: l10n.comiteChampAssigneA),
                  items: fideles
                      .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                      .toList(),
                  onChanged: (valeur) => setState(() => assigneFideleId = valeur ?? assigneFideleId),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );

    if (confirme == true && descriptionController.text.trim().isNotEmpty) {
      await controller.creerTache(
        decisionId: decisionId,
        description: descriptionController.text.trim(),
        assigneFideleId: assigneFideleId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fideleController = context.watch<FideleController>();
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<TacheSuivi>>(
      stream: controller.watchTaches(decisionId),
      builder: (context, snapshot) {
        final taches = snapshot.data ?? const <TacheSuivi>[];
        return Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.spacingLg,
            right: AppDimensions.spacingLg,
            bottom: AppDimensions.spacingSm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.comiteTachesDeSuiviTitre, style: Theme.of(context).textTheme.labelLarge),
              for (final tache in taches)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: tache.statut.code == 'fait',
                  title: Text(tache.description),
                  subtitle: Text(fideleController.findById(tache.assigneFideleId)?.nomComplet ?? tache.assigneFideleId),
                  onChanged: tache.statut.code == 'fait' ? null : (_) => controller.marquerTacheFaite(tache.id),
                ),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: Text(l10n.comiteAjouterTacheBouton),
                onPressed: () => _ajouterTache(context, fideleController),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProcesVerbalSection extends StatefulWidget {
  const _ProcesVerbalSection({required this.seanceId, required this.controller});

  final String seanceId;
  final ComiteController controller;

  @override
  State<_ProcesVerbalSection> createState() => _ProcesVerbalSectionState();
}

class _ProcesVerbalSectionState extends State<_ProcesVerbalSection> {
  final _contenuController = TextEditingController();
  final _erratumController = TextEditingController();

  @override
  void dispose() {
    _contenuController.dispose();
    _erratumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<ProcesVerbal?>(
      stream: widget.controller.watchProcesVerbal(widget.seanceId),
      builder: (context, snapshot) {
        final pv = snapshot.data;
        final estValide = pv?.statut == StatutProcesVerbal.valide;

        if (!estValide) {
          if (pv != null && _contenuController.text.isEmpty) {
            _contenuController.text = pv.contenu;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _contenuController,
                decoration: InputDecoration(labelText: l10n.comiteChampBrouillonPv),
                maxLines: 6,
              ),
              const SizedBox(height: AppDimensions.spacingSm),
              Wrap(
                spacing: AppDimensions.spacingSm,
                children: [
                  OutlinedButton(
                    onPressed: () => widget.controller.enregistrerBrouillon(
                      seanceId: widget.seanceId,
                      contenu: _contenuController.text.trim(),
                    ),
                    child: Text(l10n.comiteEnregistrerBrouillon),
                  ),
                  if (pv != null)
                    FilledButton(
                      onPressed: () => widget.controller.validerProcesVerbal(pv.id),
                      child: Text(l10n.comiteValiderPv),
                    ),
                ],
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.comitePvValideEtImmuable),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(pv!.contenu),
            const Divider(height: AppDimensions.spacingXl),
            Text(l10n.comiteErratumsTitre, style: Theme.of(context).textTheme.labelLarge),
            StreamBuilder<List<ErratumPv>>(
              stream: widget.controller.watchErratums(pv.id),
              builder: (context, snapshot) {
                final erratums = snapshot.data ?? const <ErratumPv>[];
                return Column(
                  children: [
                    for (final erratum in erratums)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(erratum.texte),
                        subtitle: Text(erratum.dateAjout.toIso8601String().split('T').first),
                      ),
                  ],
                );
              },
            ),
            TextField(
              controller: _erratumController,
              decoration: InputDecoration(labelText: l10n.comiteChampNouvelErratum),
            ),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.comiteAjouterErratumBouton),
              onPressed: () async {
                if (_erratumController.text.trim().isEmpty) return;
                await widget.controller.ajouterErratum(procesVerbalId: pv.id, texte: _erratumController.text.trim());
                _erratumController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
