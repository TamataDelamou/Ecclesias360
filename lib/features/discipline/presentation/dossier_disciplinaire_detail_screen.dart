import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/discipline_controller.dart';
import '../domain/models/commission_disciplinaire.dart';
import '../domain/models/dossier_disciplinaire.dart';
import '../domain/models/membre_commission.dart';
import '../domain/models/nature_faute.dart';
import '../domain/models/nature_piece_dossier.dart';
import '../domain/models/piece_dossier.dart';
import '../domain/models/statut_dossier_disciplinaire.dart';
import '../domain/rules/discipline_rules.dart';

/// Écrans « Instruction / commission » + « Décision et sanction » + « Suivi
/// de réintégration » (RG-X-02/03/04) combinés en une seule fiche, même
/// convention que les autres modules (ex. Comité, Déplacements) : un dossier
/// disciplinaire se construit progressivement sur un même écran plutôt que
/// trois écrans miroirs.
class DossierDisciplinaireDetailScreen extends StatelessWidget {
  const DossierDisciplinaireDetailScreen({required this.dossierId, super.key});

  final String dossierId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DisciplineController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.disciplineDetailTitre)),
      body: FutureBuilder<DossierDisciplinaire?>(
        future: controller.findDossierById(dossierId),
        builder: (context, snapshot) {
          final dossier = snapshot.data;
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (dossier == null) return Center(child: Text(l10n.disciplineIntrouvable));

          return _DossierDetailBody(dossier: dossier, controller: controller);
        },
      ),
    );
  }
}

class _DossierDetailBody extends StatefulWidget {
  const _DossierDetailBody({required this.dossier, required this.controller});

  final DossierDisciplinaire dossier;
  final DisciplineController controller;

  @override
  State<_DossierDetailBody> createState() => _DossierDetailBodyState();
}

class _DossierDetailBodyState extends State<_DossierDetailBody> {
  late DossierDisciplinaire _dossier = widget.dossier;

  Future<void> _rafraichir() async {
    final dossier = await widget.controller.findDossierById(_dossier.id);
    if (mounted && dossier != null) setState(() => _dossier = dossier);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideleController = context.watch<FideleController>();
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();

    final fideleNom = fideleController.findById(_dossier.fideleId)?.nomComplet ?? '—';

    final (statutLabel, statutColor) = switch (_dossier.statut) {
      StatutDossierDisciplinaire.enInstruction => (l10n.disciplineStatutEnInstruction, palette?.warning),
      StatutDossierDisciplinaire.sanctionne => (l10n.disciplineStatutSanctionne, Theme.of(context).colorScheme.error),
      StatutDossierDisciplinaire.clos => (l10n.disciplineStatutClos, palette?.success),
    };

    return StreamBuilder<List<NatureFaute>>(
      stream: widget.controller.watchNaturesFaute(),
      builder: (context, naturesSnapshot) {
        final naturesParId = {for (final n in naturesSnapshot.data ?? const <NatureFaute>[]) n.id: n.libelle};
        final natureLibelle = naturesParId[_dossier.natureFauteId] ?? '—';

        return ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          children: [
            Text(fideleNom, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppDimensions.spacingSm),
            Chip(
              label: Text(statutLabel),
              backgroundColor: statutColor?.withValues(alpha: 0.16),
              labelStyle: TextStyle(color: statutColor),
              side: BorderSide.none,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            _LigneInfo(label: l10n.disciplineChampNatureFaute, valeur: natureLibelle),
            Text(l10n.disciplineOuvertLe(_dossier.dateOuverture.toIso8601String().split('T').first)),
            ..._alertes(context, l10n),
            const Divider(height: AppDimensions.spacingXxl),
            Text(l10n.disciplineCommissionTitre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            _CommissionSection(dossier: _dossier, controller: widget.controller, onChange: _rafraichir),
            const Divider(height: AppDimensions.spacingXxl),
            Text(l10n.disciplinePiecesTitre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            _PiecesSection(dossier: _dossier, controller: widget.controller),
            const Divider(height: AppDimensions.spacingXxl),
            Text(l10n.disciplineDecisionTitre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            _DecisionSection(dossier: _dossier, controller: widget.controller, onChange: _rafraichir),
            if (widget.controller.erreur != null) ...[
              const SizedBox(height: AppDimensions.spacingLg),
              Text(widget.controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        );
      },
    );
  }

  List<Widget> _alertes(BuildContext context, AppLocalizations l10n) {
    final maintenant = DateTime.now();
    final widgets = <Widget>[];
    if (_dossier.statut == StatutDossierDisciplinaire.sanctionne &&
        _dossier.dateReintegrationPrevue != null &&
        !maintenant.isBefore(_dossier.dateReintegrationPrevue!)) {
      widgets.add(
        Text(
          l10n.disciplineAlerteFinDePeriode(_dossier.dateReintegrationPrevue!.toIso8601String().split('T').first),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }
    if (_dossier.statut == StatutDossierDisciplinaire.sanctionne &&
        _dossier.dureeSanctionJours == null &&
        _dossier.dateDecision != null &&
        DisciplineRules.necessiteRevuePeriodique(
          dateDecision: _dossier.dateDecision!,
          maintenant: maintenant,
          seuilJours: AppDefaults.disciplineRevuePeriodiqueJours,
        )) {
      widgets.add(
        Text(l10n.disciplineAlerteRevuePeriodique, style: TextStyle(color: Theme.of(context).colorScheme.error)),
      );
    }
    return widgets;
  }
}

class _CommissionSection extends StatelessWidget {
  const _CommissionSection({required this.dossier, required this.controller, required this.onChange});

  final DossierDisciplinaire dossier;
  final DisciplineController controller;
  final Future<void> Function() onChange;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final commissionId = dossier.commissionId;

    // Toujours passer par le flux (même quand aucune commission n'est
    // encore assignée) : les données sont ainsi déjà disponibles de façon
    // synchrone au moment du clic, sans nouvel `await` avant l'ouverture
    // du dialogue (un `await` isolé y introduisait un délai imprévisible).
    return StreamBuilder<List<CommissionDisciplinaire>>(
      stream: controller.watchCommissions(dossier.noeudId),
      builder: (context, snapshot) {
        final commissions = snapshot.data ?? const <CommissionDisciplinaire>[];

        if (commissionId == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.disciplineCommissionAucune),
              const SizedBox(height: AppDimensions.spacingSm),
              OutlinedButton(
                onPressed: () => _assignerCommission(context, commissions),
                child: Text(l10n.disciplineCommissionAssignerBouton),
              ),
            ],
          );
        }

        final commissionsParId = {for (final c in commissions) c.id: c};
        final commission = commissionsParId[commissionId];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(commission?.nom ?? '—', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(l10n.disciplineCommissionMembresTitre, style: Theme.of(context).textTheme.labelLarge),
            _MembresCommission(commissionId: commissionId, noeudId: dossier.noeudId, controller: controller),
          ],
        );
      },
    );
  }

  Future<void> _assignerCommission(BuildContext context, List<CommissionDisciplinaire> commissions) async {
    final l10n = AppLocalizations.of(context)!;
    String? commissionChoisie = commissions.isEmpty ? null : commissions.first.id;
    final action = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.disciplineCommissionAssignerTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (commissions.isNotEmpty)
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: commissionChoisie,
                    items: commissions.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nom))).toList(),
                    onChanged: (valeur) => setState(() => commissionChoisie = valeur),
                  ),
                const SizedBox(height: AppDimensions.spacingSm),
                TextButton(
                  onPressed: () => context.pop('creer'),
                  child: Text(l10n.disciplineCommissionCreerBouton),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => context.pop(), child: Text(l10n.commonAnnuler)),
              if (commissions.isNotEmpty)
                FilledButton(onPressed: () => context.pop('assigner'), child: Text(l10n.commonEnregistrer)),
            ],
          ),
        );
      },
    );

    if (!context.mounted) return;

    if (action == 'creer') {
      final commissionId = await _creerCommission(context);
      if (commissionId != null) {
        await controller.assignerCommission(dossierId: dossier.id, commissionId: commissionId);
        await onChange();
      }
    } else if (action == 'assigner' && commissionChoisie != null) {
      await controller.assignerCommission(dossierId: dossier.id, commissionId: commissionChoisie!);
      await onChange();
    }
  }

  Future<String?> _creerCommission(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final nomController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.disciplineCommissionCreerTitre),
        content: TextField(
          controller: nomController,
          decoration: InputDecoration(labelText: l10n.disciplineChampNomCommission),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
          FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonCreer)),
        ],
      ),
    );
    final nom = nomController.text.trim();
    if (confirme != true || nom.isEmpty || !context.mounted) return null;
    final commission = await controller.creerCommission(noeudId: dossier.noeudId, nom: nom);
    return commission?.id;
  }
}

class _MembresCommission extends StatelessWidget {
  const _MembresCommission({required this.commissionId, required this.noeudId, required this.controller});

  final String commissionId;
  final String noeudId;
  final DisciplineController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideleController = context.watch<FideleController>();

    return StreamBuilder<List<MembreCommission>>(
      stream: controller.watchMembresCommission(commissionId),
      builder: (context, snapshot) {
        final membres = snapshot.data ?? const <MembreCommission>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final membre in membres)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(fideleController.findById(membre.fideleId)?.nomComplet ?? '—'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => controller.retirerMembreCommission(membre.id),
                ),
              ),
            TextButton.icon(
              icon: const Icon(Icons.person_add_outlined),
              label: Text(l10n.disciplineCommissionAjouterMembreTooltip),
              onPressed: () => _ajouterMembre(context, fideleController),
            ),
          ],
        );
      },
    );
  }

  Future<void> _ajouterMembre(BuildContext context, FideleController fideleController) async {
    final l10n = AppLocalizations.of(context)!;
    final fideles = fideleController.fideles.where((f) => f.noeudId == noeudId).toList();
    if (fideles.isEmpty) return;
    String fideleId = fideles.first.id;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.disciplineCommissionAjouterMembreTooltip),
            content: DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: fideleId,
              items: fideles.map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet))).toList(),
              onChanged: (valeur) => setState(() => fideleId = valeur ?? fideleId),
            ),
            actions: [
              TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );
    if (confirme == true) {
      await controller.ajouterMembreCommission(commissionId: commissionId, fideleId: fideleId);
    }
  }
}

class _PiecesSection extends StatelessWidget {
  const _PiecesSection({required this.dossier, required this.controller});

  final DossierDisciplinaire dossier;
  final DisciplineController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<PieceDossier>>(
      stream: controller.watchPieces(dossier.id),
      builder: (context, snapshot) {
        final pieces = snapshot.data ?? const <PieceDossier>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pieces.isEmpty) Text(l10n.disciplinePiecesAucune),
            for (final piece in pieces)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Icon(
                  piece.nature == NaturePieceDossier.temoignage ? Icons.record_voice_over_outlined : Icons.gavel_outlined,
                ),
                title: Text(
                  piece.nature == NaturePieceDossier.temoignage
                      ? l10n.disciplinePieceNatureTemoignage
                      : l10n.disciplinePieceNaturePreuve,
                ),
                subtitle: Text(piece.ajouteLe.toIso8601String().split('T').first),
                trailing: piece.documentArchiveId == null
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.folder_open_outlined),
                        onPressed: () => context.push(AppRoutes.documentArchive(piece.documentArchiveId!)),
                      ),
              ),
            TextButton.icon(
              icon: const Icon(Icons.note_add_outlined),
              label: Text(l10n.disciplinePieceAjouterTooltip),
              onPressed: () => _ajouterPiece(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _ajouterPiece(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final contenuController = TextEditingController();
    NaturePieceDossier nature = NaturePieceDossier.temoignage;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.disciplinePieceAjouterTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<NaturePieceDossier>(
                  isExpanded: true,
                  initialValue: nature,
                  decoration: InputDecoration(labelText: l10n.disciplinePieceChampNature),
                  items: [
                    DropdownMenuItem(
                      value: NaturePieceDossier.temoignage,
                      child: Text(l10n.disciplinePieceNatureTemoignage),
                    ),
                    DropdownMenuItem(
                      value: NaturePieceDossier.preuve,
                      child: Text(l10n.disciplinePieceNaturePreuve),
                    ),
                  ],
                  onChanged: (valeur) => setState(() => nature = valeur ?? nature),
                ),
                TextField(
                  controller: contenuController,
                  maxLines: 4,
                  decoration: InputDecoration(labelText: l10n.disciplinePieceChampContenu),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );

    if (confirme == true && contenuController.text.trim().isNotEmpty) {
      await controller.ajouterPiece(
        dossierId: dossier.id,
        nature: nature,
        contenu: contenuController.text.trim(),
        noeudId: dossier.noeudId,
      );
    }
  }
}

class _DecisionSection extends StatefulWidget {
  const _DecisionSection({required this.dossier, required this.controller, required this.onChange});

  final DossierDisciplinaire dossier;
  final DisciplineController controller;
  final Future<void> Function() onChange;

  @override
  State<_DecisionSection> createState() => _DecisionSectionState();
}

class _DecisionSectionState extends State<_DecisionSection> {
  final _decisionController = TextEditingController();
  final _dureeController = TextEditingController();
  bool _suspendreMinisteres = false;

  @override
  void dispose() {
    _decisionController.dispose();
    _dureeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dossier = widget.dossier;

    if (dossier.statut == StatutDossierDisciplinaire.enInstruction) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _decisionController,
            maxLines: 3,
            decoration: InputDecoration(labelText: l10n.disciplineChampDecision),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          TextField(
            controller: _dureeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: l10n.disciplineChampDureeSanction),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _suspendreMinisteres,
            title: Text(l10n.disciplineChampSuspendreMinisteres),
            onChanged: (valeur) => setState(() => _suspendreMinisteres = valeur ?? false),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          FilledButton(
            onPressed: dossier.commissionId == null || widget.controller.enCours ? null : _prononcer,
            child: Text(l10n.disciplinePrononcerBouton),
          ),
        ],
      );
    }

    final dureeLabel = dossier.dureeSanctionJours == null
        ? l10n.disciplineDureeIndeterminee
        : l10n.disciplineDureeJours(dossier.dureeSanctionJours!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dossier.decision ?? '—'),
        const SizedBox(height: AppDimensions.spacingSm),
        if (dossier.dateDecision != null)
          _LigneInfo(
            label: l10n.disciplineDecisionRendueLe(dossier.dateDecision!.toIso8601String().split('T').first),
            valeur: dureeLabel,
          ),
        if (dossier.statut == StatutDossierDisciplinaire.sanctionne) ...[
          const SizedBox(height: AppDimensions.spacingSm),
          FilledButton(
            onPressed: widget.controller.enCours ? null : () async {
              await widget.controller.cloturer(dossier.id);
              await widget.onChange();
            },
            child: Text(l10n.disciplineCloturerBouton),
          ),
        ],
        if (dossier.statut == StatutDossierDisciplinaire.clos) ...[
          const SizedBox(height: AppDimensions.spacingSm),
          Text(l10n.disciplineDossierClosNote),
        ],
      ],
    );
  }

  Future<void> _prononcer() async {
    final decision = _decisionController.text.trim();
    if (decision.isEmpty) return;
    final duree = int.tryParse(_dureeController.text.trim());
    await widget.controller.prononcerDecision(
      dossierId: widget.dossier.id,
      decision: decision,
      dureeSanctionJours: duree,
      suspendreMinisteres: _suspendreMinisteres,
    );
    await widget.onChange();
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
