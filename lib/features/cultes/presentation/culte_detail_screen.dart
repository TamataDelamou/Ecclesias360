import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/culte_controller.dart';
import '../domain/models/culte.dart';
import '../domain/models/mode_presence.dart';
import '../domain/models/presence_culte.dart';
import '../domain/models/publication_culte.dart';
import '../domain/models/sequence_liturgique.dart';
import '../domain/models/statut_culte.dart';

/// Fiche détaillée d'un culte : statut (RG-XII-05), liturgie (RG-XII-01),
/// présences (RG-XII-02) et publication post-culte (RG-XII-03).
class CulteDetailScreen extends StatelessWidget {
  const CulteDetailScreen({required this.culteId, super.key});

  final String culteId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CulteController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cultesTitre)),
      body: FutureBuilder<Culte?>(
        future: controller.findCulteById(culteId),
        builder: (context, snapshot) {
          final culte = snapshot.data;
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (culte == null) return Center(child: Text(l10n.cultesAucun));

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              Text(
                culte.theme?.trim().isNotEmpty == true ? culte.theme! : culte.typeCulte,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(culte.dateHeure.toString().split('.').first),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.culteStatutTitre, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimensions.spacingSm),
              Wrap(
                spacing: AppDimensions.spacingSm,
                children: [
                  for (final statut in StatutCulte.values)
                    OutlinedButton(
                      onPressed: statut == culte.statut
                          ? null
                          : () => controller.changerStatutCulte(id: culte.id, statut: statut),
                      child: Text(statut.code),
                    ),
                ],
              ),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.culteLiturgieTitre, style: Theme.of(context).textTheme.titleMedium),
              _LiturgieSection(culteId: culte.id, controller: controller),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.cultePresencesTitre, style: Theme.of(context).textTheme.titleMedium),
              _PresencesSection(culte: culte, controller: controller),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.cultePublicationTitre, style: Theme.of(context).textTheme.titleMedium),
              _PublicationSection(culteId: culte.id, controller: controller),
              if (controller.erreur != null) ...[
                const SizedBox(height: AppDimensions.spacingLg),
                Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _LiturgieSection extends StatelessWidget {
  const _LiturgieSection({required this.culteId, required this.controller});

  final String culteId;
  final CulteController controller;

  Future<void> _ajouterSequence(BuildContext context, List<SequenceLiturgique> sequencesExistantes) async {
    final libelleController = TextEditingController();
    final dureeController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.culteAjouterSequenceTitre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: libelleController,
                decoration: InputDecoration(labelText: l10n.culteChampLibelleSequence),
              ),
              TextField(
                controller: dureeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l10n.culteChampDureeMinutes),
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

    if (confirme == true && libelleController.text.trim().isNotEmpty) {
      await controller.ajouterSequence(
        culteId: culteId,
        ordre: sequencesExistantes.length + 1,
        libelle: libelleController.text.trim(),
        dureePrevueMinutes: int.tryParse(dureeController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<SequenceLiturgique>>(
      stream: controller.watchSequences(culteId),
      builder: (context, snapshot) {
        final sequences = snapshot.data ?? const <SequenceLiturgique>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sequences.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSm),
                child: Text(l10n.culteAucuneSequence),
              )
            else
              for (final sequence in sequences)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Text('${sequence.ordre}')),
                  title: Text(sequence.libelle),
                  subtitle: sequence.dureePrevueMinutes != null
                      ? Text('${sequence.dureePrevueMinutes} min')
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => controller.retirerSequence(sequence.id),
                  ),
                ),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.culteAjouterSequenceBouton),
              onPressed: () => _ajouterSequence(context, sequences),
            ),
          ],
        );
      },
    );
  }
}

class _PresencesSection extends StatefulWidget {
  const _PresencesSection({required this.culte, required this.controller});

  final Culte culte;
  final CulteController controller;

  @override
  State<_PresencesSection> createState() => _PresencesSectionState();
}

class _PresencesSectionState extends State<_PresencesSection> {
  final _compteController = TextEditingController();

  @override
  void dispose() {
    _compteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideleController = context.watch<FideleController>();

    if (widget.culte.modePresence == ModePresence.global) {
      if (_compteController.text.isEmpty && widget.culte.compteGlobalPresence != null) {
        _compteController.text = widget.culte.compteGlobalPresence.toString();
      }
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: _compteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l10n.culteChampCompteGlobal),
            ),
          ),
          const SizedBox(width: AppDimensions.spacingSm),
          FilledButton(
            onPressed: () => widget.controller.definirCompteGlobalPresence(
              culteId: widget.culte.id,
              compte: int.tryParse(_compteController.text.trim()) ?? 0,
            ),
            child: Text(l10n.culteEnregistrerCompte),
          ),
        ],
      );
    }

    return StreamBuilder<List<PresenceCulte>>(
      stream: widget.controller.watchPresences(widget.culte.id),
      builder: (context, snapshot) {
        final presences = snapshot.data ?? const <PresenceCulte>[];
        final presentsIds = presences.map((p) => p.fideleId).toSet();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final fidele in fideleController.fideles)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: presentsIds.contains(fidele.id),
                title: Text(fidele.nomComplet),
                onChanged: (coche) {
                  if (coche == true) {
                    widget.controller.ajouterPresenceNominale(culteId: widget.culte.id, fideleId: fidele.id);
                  } else {
                    PresenceCulte? presenceCorrespondante;
                    for (final presence in presences) {
                      if (presence.fideleId == fidele.id) {
                        presenceCorrespondante = presence;
                        break;
                      }
                    }
                    if (presenceCorrespondante != null) {
                      widget.controller.retirerPresenceNominale(presenceCorrespondante.id);
                    }
                  }
                },
              ),
          ],
        );
      },
    );
  }
}

class _PublicationSection extends StatefulWidget {
  const _PublicationSection({required this.culteId, required this.controller});

  final String culteId;
  final CulteController controller;

  @override
  State<_PublicationSection> createState() => _PublicationSectionState();
}

class _PublicationSectionState extends State<_PublicationSection> {
  final _texteController = TextEditingController();
  final _audioController = TextEditingController();
  final _videoController = TextEditingController();
  final _pdfController = TextEditingController();
  bool _initialise = false;

  @override
  void dispose() {
    _texteController.dispose();
    _audioController.dispose();
    _videoController.dispose();
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<PublicationCulte?>(
      stream: widget.controller.watchPublication(widget.culteId),
      builder: (context, snapshot) {
        final publication = snapshot.data;
        if (!_initialise && publication != null) {
          _texteController.text = publication.texteBiblique ?? '';
          _audioController.text = publication.audioUrl ?? '';
          _videoController.text = publication.videoUrl ?? '';
          _pdfController.text = publication.pdfUrl ?? '';
          _initialise = true;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              publication != null
                  ? l10n.cultePublieLe(publication.datePublication.toString().split('.').first)
                  : l10n.culteNonPublie,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            TextField(
              controller: _texteController,
              decoration: InputDecoration(labelText: l10n.culteChampTexteBiblique),
              maxLines: 3,
            ),
            TextField(
              controller: _audioController,
              decoration: InputDecoration(labelText: l10n.culteChampAudioUrl),
            ),
            TextField(
              controller: _videoController,
              decoration: InputDecoration(labelText: l10n.culteChampVideoUrl),
            ),
            TextField(
              controller: _pdfController,
              decoration: InputDecoration(labelText: l10n.culteChampPdfUrl),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => widget.controller.publier(
                culteId: widget.culteId,
                texteBiblique: _texteController.text.trim().isEmpty ? null : _texteController.text.trim(),
                audioUrl: _audioController.text.trim().isEmpty ? null : _audioController.text.trim(),
                videoUrl: _videoController.text.trim().isEmpty ? null : _videoController.text.trim(),
                pdfUrl: _pdfController.text.trim().isEmpty ? null : _pdfController.text.trim(),
              ),
              child: Text(l10n.cultePublierBouton),
            ),
          ],
        );
      },
    );
  }
}
