import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/finances_controller.dart';
import '../domain/models/echeance_engagement.dart';
import '../domain/models/engagement.dart';
import '../domain/models/origine_contribution.dart';
import '../domain/models/periodicite_engagement.dart';
import '../domain/models/statut_echeance.dart';
import '../domain/models/type_engagement.dart';
import '../domain/models/type_offrande.dart';
import 'acces_finances.dart';

/// Écran « Engagements et échéances » (RG-XI-04), scopé à un fidèle.
class EngagementsListScreen extends StatelessWidget {
  const EngagementsListScreen({required this.fideleId, super.key});

  final String fideleId;

  Future<void> _creerEngagement(BuildContext context, FinancesController controller) async {
    TypeEngagement type = TypeEngagement.dimeEngagement;
    final montantController = TextEditingController();
    PeriodiciteEngagement periodicite = PeriodiciteEngagement.mensuelle;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.financesEngagementCreerTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<TypeEngagement>(
                  isExpanded: true,
                  initialValue: type,
                  decoration: InputDecoration(labelText: l10n.financesChampTypeEngagement),
                  items: [
                    DropdownMenuItem(value: TypeEngagement.dimeEngagement, child: Text(l10n.financesTypeEngagementDime)),
                    DropdownMenuItem(value: TypeEngagement.promesseDon, child: Text(l10n.financesTypeEngagementPromesseDon)),
                  ],
                  onChanged: (valeur) => setState(() => type = valeur ?? type),
                ),
                TextField(
                  controller: montantController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.financesChampMontantPrevu,
                    suffixText: AppDefaults.financesDeviseParDefaut,
                  ),
                ),
                DropdownButtonFormField<PeriodiciteEngagement>(
                  isExpanded: true,
                  initialValue: periodicite,
                  decoration: InputDecoration(labelText: l10n.financesChampPeriodicite),
                  items: [
                    DropdownMenuItem(value: PeriodiciteEngagement.hebdomadaire, child: Text(l10n.financesPeriodiciteHebdomadaire)),
                    DropdownMenuItem(value: PeriodiciteEngagement.mensuelle, child: Text(l10n.financesPeriodiciteMensuelle)),
                    DropdownMenuItem(value: PeriodiciteEngagement.trimestrielle, child: Text(l10n.financesPeriodiciteTrimestrielle)),
                    DropdownMenuItem(value: PeriodiciteEngagement.annuelle, child: Text(l10n.financesPeriodiciteAnnuelle)),
                  ],
                  onChanged: (valeur) => setState(() => periodicite = valeur ?? periodicite),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonCreer)),
            ],
          ),
        );
      },
    );

    final montant = int.tryParse(montantController.text.trim());
    if (confirme == true && montant != null && montant > 0) {
      await controller.creerEngagement(
        fideleId: fideleId,
        type: type,
        montantPrevu: montant,
        periodicite: periodicite,
        dateDebut: DateTime.now(),
      );
    }
  }

  /// RG-XI-04 — honore une échéance en saisissant, dans la foulée, la
  /// contribution correspondante (même montant que l'engagement, premier
  /// type d'offrande disponible faute de sélection dédiée dans ce lot,
  /// **déjà chargé au moment du clic** — ne jamais `await` un flux Drift
  /// dans un gestionnaire de clic, voir AGENTS.md, entrée Module X) et en
  /// la liant à l'échéance. La contribution suit son cycle normal
  /// (`enAttente` puis validation comptable, RG-XI-02) : honorer une
  /// échéance ne la valide pas automatiquement.
  Future<void> _honorer(
    BuildContext context,
    FinancesController controller,
    Engagement engagement,
    EcheanceEngagement echeance,
    String typeOffrandeId,
  ) async {
    final fideleController = context.read<FideleController>();
    final noeudId = fideleController.findById(engagement.fideleId)?.noeudId;
    if (noeudId == null) return;
    // RG-XI-02 : la contribution qui honore l'échéance est une saisie, tracée.
    final saisieParFideleId = context.read<SessionController>().session?.fideleId;
    if (saisieParFideleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.authFicheLieeRequise)),
      );
      return;
    }

    final contribution = await controller.saisirContribution(
      saisieParFideleId: saisieParFideleId,
      fideleId: engagement.fideleId,
      typeOffrandeId: typeOffrandeId,
      montant: engagement.montantPrevu,
      devise: AppDefaults.financesDeviseParDefaut,
      noeudId: noeudId,
      modePaiement: 'especes',
      origine: OrigineContribution.mobile,
    );
    if (contribution != null) {
      await controller.honorerEcheance(id: echeance.id, contributionId: contribution.id);
    }
  }

  /// Accès réservé (policy `engagements_acces`, 0019) au fidèle lui-même,
  /// à un pasteur (ou plus) et au trésorier de son nœud.
  @override
  Widget build(BuildContext context) {
    final noeudDuFidele = context.watch<FideleController>().findById(fideleId)?.noeudId;
    return AccesFinancesBuilder(
      builder: (context, acces) => acces.peutConsulterFidele(fideleIdConsulte: fideleId, noeudDuFidele: noeudDuFidele)
          ? _construire(context)
          : EcranFinancesAccesReserve(titre: AppLocalizations.of(context)!.financesEngagementsTitre),
    );
  }

  Widget _construire(BuildContext context) {
    final controller = context.read<FinancesController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financesEngagementsTitre)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _creerEngagement(context, controller),
        tooltip: l10n.financesEngagementCreerTooltip,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<TypeOffrande>>(
        stream: controller.watchTypesOffrande(),
        builder: (context, typesSnapshot) {
          final types = typesSnapshot.data ?? const <TypeOffrande>[];

          return StreamBuilder<List<Engagement>>(
            stream: controller.watchEngagements(fideleId),
            builder: (context, snapshot) {
              final engagements = snapshot.data ?? const <Engagement>[];
              if (engagements.isEmpty) {
                return Center(child: Text(l10n.financesEngagementsAucun));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppDimensions.spacingLg),
                itemCount: engagements.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingMd),
                itemBuilder: (context, index) {
                  final engagement = engagements[index];
                  final typeLabel = engagement.type == TypeEngagement.dimeEngagement
                      ? l10n.financesTypeEngagementDime
                      : l10n.financesTypeEngagementPromesseDon;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$typeLabel — ${engagement.montantPrevu} ${AppDefaults.financesDeviseParDefaut}'),
                          Text(l10n.financesEngagementPeriodicite(_periodiciteLabel(l10n, engagement.periodicite))),
                          const SizedBox(height: AppDimensions.spacingSm),
                          StreamBuilder<List<EcheanceEngagement>>(
                            stream: controller.watchEcheances(engagement.id),
                            builder: (context, echeancesSnapshot) {
                              final echeances = echeancesSnapshot.data ?? const <EcheanceEngagement>[];
                              if (echeances.isEmpty) return const SizedBox.shrink();
                              return Column(
                                children: [
                                  for (final echeance in echeances)
                                    _EcheanceTile(
                                      echeance: echeance,
                                      onHonorer: types.isEmpty
                                          ? null
                                          : () => _honorer(context, controller, engagement, echeance, types.first.id),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _periodiciteLabel(AppLocalizations l10n, PeriodiciteEngagement periodicite) => switch (periodicite) {
        PeriodiciteEngagement.hebdomadaire => l10n.financesPeriodiciteHebdomadaire,
        PeriodiciteEngagement.mensuelle => l10n.financesPeriodiciteMensuelle,
        PeriodiciteEngagement.trimestrielle => l10n.financesPeriodiciteTrimestrielle,
        PeriodiciteEngagement.annuelle => l10n.financesPeriodiciteAnnuelle,
      };
}

class _EcheanceTile extends StatelessWidget {
  const _EcheanceTile({required this.echeance, required this.onHonorer});

  final EcheanceEngagement echeance;
  final VoidCallback? onHonorer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();

    final (statutLabel, statutColor) = switch (echeance.statut) {
      StatutEcheance.enAttente => (l10n.financesEcheanceEnAttente, palette?.warning),
      StatutEcheance.honoree => (l10n.financesEcheanceHonoree, palette?.success),
      StatutEcheance.enRetard => (l10n.financesEcheanceEnRetard, Theme.of(context).colorScheme.error),
    };

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(echeance.dateEcheance.toIso8601String().split('T').first),
      trailing: echeance.statut == StatutEcheance.enAttente
          ? TextButton(onPressed: onHonorer, child: Text(l10n.financesEcheanceHonorerBouton))
          : Chip(
              label: Text(statutLabel),
              backgroundColor: statutColor?.withValues(alpha: 0.16),
              labelStyle: TextStyle(color: statutColor, fontSize: 11),
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
            ),
    );
  }
}
