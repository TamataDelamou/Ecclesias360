import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/discipline_controller.dart';
import '../domain/models/dossier_disciplinaire.dart';
import '../domain/models/nature_faute.dart';
import '../domain/models/statut_dossier_disciplinaire.dart';
import '../domain/rules/discipline_rules.dart';
import 'acces_discipline.dart';

/// Écrans « Liste des dossiers » (scopée par nœud, RG-X-01) et « Historique
/// confidentiel d'un fidèle » (RG-X-05), regroupés sur un seul écran
/// réutilisable selon le paramètre fourni — même motif que
/// `MutationsListScreen` (module IX). Le nœud combine en outre l'écran
/// « Ouverture d'un dossier » via le bouton d'ajout.
///
/// RG-X-05 : seuls les dossiers que le compte courant peut consulter sont
/// listés (pasteur ou plus, ou membre de la commission assignée) ; jamais le
/// fidèle concerné à ce seul titre. L'acteur d'une ouverture est la session.
class DossiersDisciplinairesListScreen extends StatelessWidget {
  const DossiersDisciplinairesListScreen({this.noeudId, this.fideleId, super.key})
      : assert(
          (noeudId == null) != (fideleId == null),
          'DossiersDisciplinairesListScreen attend soit noeudId, soit fideleId, jamais les deux ni aucun.',
        );

  final String? noeudId;
  final String? fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DisciplineController>();
    final l10n = AppLocalizations.of(context)!;
    final parNoeud = noeudId != null;

    return StreamBuilder<List<NatureFaute>>(
      stream: controller.watchNaturesFaute(),
      builder: (context, naturesSnapshot) {
        final natures = naturesSnapshot.data ?? const <NatureFaute>[];
        final naturesParId = {for (final nature in natures) nature.id: nature.libelle};

        return AccesDisciplineBuilder(
          builder: (context, acces) => Scaffold(
            appBar: AppBar(title: Text(parNoeud ? l10n.disciplineTitre : l10n.disciplineHistoriqueTitre)),
            floatingActionButton: parNoeud && acces.peutOuvrir(noeudId!)
                ? FloatingActionButton(
                    onPressed: () => _ouvrirDossier(context, controller, noeudId!, natures),
                    tooltip: l10n.disciplineOuvrirTooltip,
                    child: const Icon(Icons.add),
                  )
                : null,
            body: !acces.aAcces
                ? Center(child: Text(l10n.disciplineAccesReserve))
                : StreamBuilder<List<DossierDisciplinaire>>(
                    stream: parNoeud ? controller.watchDossiers(noeudId!) : controller.watchDossiersDuFidele(fideleId!),
                    builder: (context, snapshot) {
                      final dossiers = (snapshot.data ?? const <DossierDisciplinaire>[])
                          .where(acces.peutConsulter)
                          .toList();
                      if (dossiers.isEmpty) {
                        return Center(
                          child: Text(parNoeud ? l10n.disciplineAucunDossier : l10n.disciplineAucunDossierFidele),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.all(AppDimensions.spacingLg),
                        itemCount: dossiers.length,
                        separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingSm),
                        itemBuilder: (context, index) {
                          final dossier = dossiers[index];
                          return StaggeredFadeIn(
                            index: index,
                            child: _DossierCard(
                              dossier: dossier,
                              natureLibelle: naturesParId[dossier.natureFauteId] ?? '—',
                              onTap: () => context.push(AppRoutes.dossierDisciplinaire(dossier.id)),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Future<void> _ouvrirDossier(
    BuildContext context,
    DisciplineController controller,
    String noeudId,
    List<NatureFaute> natures,
  ) async {
    final fideleController = context.read<FideleController>();
    final session = context.read<SessionController>();
    final fidelesDuNoeud = fideleController.fideles.where((f) => f.noeudId == noeudId).toList();
    if (fidelesDuNoeud.isEmpty || natures.isEmpty) return;

    String? fideleMisEnCauseId = fidelesDuNoeud.first.id;
    String? natureFauteId = natures.first.id;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.disciplineOuvrirTitre),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: fideleMisEnCauseId,
                    decoration: InputDecoration(labelText: l10n.disciplineChampFideleMisEnCause),
                    items: fidelesDuNoeud
                        .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                        .toList(),
                    onChanged: (valeur) => setState(() => fideleMisEnCauseId = valeur),
                  ),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: natureFauteId,
                    decoration: InputDecoration(labelText: l10n.disciplineChampNatureFaute),
                    items: natures.map((n) => DropdownMenuItem(value: n.id, child: Text(n.libelle))).toList(),
                    onChanged: (valeur) => setState(() => natureFauteId = valeur),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonCreer)),
            ],
          ),
        );
      },
    );

    if (confirme == true && fideleMisEnCauseId != null && natureFauteId != null && context.mounted) {
      final dossier = await controller.ouvrirDossier(
        fideleId: fideleMisEnCauseId!,
        noeudId: noeudId,
        natureFauteId: natureFauteId!,
        roleActeur: session.role,
        ouvertParFideleId: session.session?.fideleId,
      );
      if (dossier != null && context.mounted) {
        context.push(AppRoutes.dossierDisciplinaire(dossier.id));
      }
    }
  }
}

class _DossierCard extends StatelessWidget {
  const _DossierCard({required this.dossier, required this.natureLibelle, required this.onTap});

  final DossierDisciplinaire dossier;
  final String natureLibelle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();
    final fideleController = context.watch<FideleController>();
    final fideleNom = fideleController.findById(dossier.fideleId)?.nomComplet ?? '—';

    final (statutLabel, statutColor) = switch (dossier.statut) {
      StatutDossierDisciplinaire.enInstruction => (l10n.disciplineStatutEnInstruction, palette?.warning),
      StatutDossierDisciplinaire.sanctionne => (l10n.disciplineStatutSanctionne, Theme.of(context).colorScheme.error),
      StatutDossierDisciplinaire.clos => (l10n.disciplineStatutClos, palette?.success),
    };

    final maintenant = DateTime.now();
    final alerteFinDePeriode = dossier.statut == StatutDossierDisciplinaire.sanctionne &&
        dossier.dateReintegrationPrevue != null &&
        !maintenant.isBefore(dossier.dateReintegrationPrevue!);
    final alerteRevue = dossier.statut == StatutDossierDisciplinaire.sanctionne &&
        dossier.dureeSanctionJours == null &&
        dossier.dateDecision != null &&
        DisciplineRules.necessiteRevuePeriodique(
          dateDecision: dossier.dateDecision!,
          maintenant: maintenant,
          seuilJours: AppDefaults.disciplineRevuePeriodiqueJours,
        );

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(fideleNom),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$natureLibelle — ${dossier.dateOuverture.toIso8601String().split('T').first}'),
            if (alerteFinDePeriode)
              Text(
                l10n.disciplineAlerteFinDePeriode(dossier.dateReintegrationPrevue!.toIso8601String().split('T').first),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (alerteRevue)
              Text(l10n.disciplineAlerteRevuePeriodique, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ),
        isThreeLine: alerteFinDePeriode || alerteRevue,
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
