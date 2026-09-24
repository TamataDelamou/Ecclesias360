import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/finances_controller.dart';
import '../domain/models/contribution.dart';
import '../domain/models/origine_contribution.dart';
import '../domain/models/statut_contribution.dart';
import '../domain/models/type_offrande.dart';
import 'acces_finances.dart';

/// Écrans « Saisie rapide d'offrande » + « Historique des contributions
/// d'un fidèle » + « Rapport rapide par type d'offrande », regroupés sur un
/// seul écran réutilisable selon le paramètre fourni — même motif que
/// `DossiersDisciplinairesListScreen` (Module X) / `MutationsListScreen`
/// (Module IX). Le nœud ajoute en outre le rapport par type d'offrande
/// (somme des contributions validées affichées) et l'accès à la gestion
/// des trésoriers (RG-XI-02).
///
/// RG-SEC-06 : un nœud n'est consulté que par un pasteur (ou plus) ou un
/// trésorier de ce nœud ; l'historique d'un fidèle, aussi par lui-même.
/// Chaque contribution listée est de plus filtrée (policy
/// `contributions_lecture`, 0019).
class ContributionsListScreen extends StatelessWidget {
  const ContributionsListScreen({this.noeudId, this.fideleId, super.key})
      : assert(
          (noeudId == null) != (fideleId == null),
          'ContributionsListScreen attend soit noeudId, soit fideleId, jamais les deux ni aucun.',
        );

  final String? noeudId;
  final String? fideleId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final noeudDuFidele = fideleId == null ? null : context.watch<FideleController>().findById(fideleId!)?.noeudId;
    return AccesFinancesBuilder(
      builder: (context, acces) {
        final autorise = noeudId != null
            ? acces.peutGererContributions(noeudId!)
            : acces.peutConsulterFidele(fideleIdConsulte: fideleId!, noeudDuFidele: noeudDuFidele);
        if (!autorise) {
          return EcranFinancesAccesReserve(titre: noeudId != null ? l10n.financesTitre : l10n.financesHistoriqueTitre);
        }
        return _construire(context, acces);
      },
    );
  }

  Widget _construire(BuildContext context, AccesFinances acces) {
    final controller = context.read<FinancesController>();
    final l10n = AppLocalizations.of(context)!;
    final parNoeud = noeudId != null;

    return StreamBuilder<List<TypeOffrande>>(
      stream: controller.watchTypesOffrande(),
      builder: (context, typesSnapshot) {
        final types = typesSnapshot.data ?? const <TypeOffrande>[];
        final typesParId = {for (final type in types) type.id: type.libelle};

        return Scaffold(
          appBar: AppBar(
            title: Text(parNoeud ? l10n.financesTitre : l10n.financesHistoriqueTitre),
            actions: [
              if (parNoeud && acces.peutDesignerTresoriers)
                IconButton(
                  icon: const Icon(Icons.badge_outlined),
                  tooltip: l10n.financesTresoriersTitre,
                  onPressed: () => context.push(AppRoutes.tresoriersDuNoeud(noeudId!)),
                ),
            ],
          ),
          floatingActionButton: parNoeud
              ? FloatingActionButton(
                  onPressed: () => _saisirContribution(context, controller, noeudId!, types),
                  tooltip: l10n.financesSaisirTooltip,
                  child: const Icon(Icons.add),
                )
              : null,
          body: StreamBuilder<List<Contribution>>(
            stream: parNoeud ? controller.watchContributions(noeudId!) : controller.watchContributionsDuFidele(fideleId!),
            builder: (context, snapshot) {
              final contributions = (snapshot.data ?? const <Contribution>[]).where(acces.peutConsulter).toList();
              if (contributions.isEmpty) {
                return Center(child: Text(parNoeud ? l10n.financesAucuneContribution : l10n.financesAucuneContributionFidele));
              }
              return ListView(
                padding: const EdgeInsets.all(AppDimensions.spacingLg),
                children: [
                  if (parNoeud) _RapportParType(contributions: contributions, typesParId: typesParId),
                  if (parNoeud) const SizedBox(height: AppDimensions.spacingMd),
                  for (var i = 0; i < contributions.length; i++) ...[
                    if (i > 0) const SizedBox(height: AppDimensions.spacingSm),
                    StaggeredFadeIn(
                      index: i,
                      child: _ContributionCard(
                        contribution: contributions[i],
                        typeLibelle: typesParId[contributions[i].typeOffrandeId] ?? '—',
                        onTap: () => context.push(AppRoutes.contribution(contributions[i].id)),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _saisirContribution(
    BuildContext context,
    FinancesController controller,
    String noeudId,
    List<TypeOffrande> types,
  ) async {
    if (types.isEmpty) return;
    final fideleController = context.read<FideleController>();
    final fidelesDuNoeud = fideleController.fideles.where((f) => f.noeudId == noeudId).toList();

    String? fideleId = fidelesDuNoeud.isNotEmpty ? fidelesDuNoeud.first.id : null;
    final donateurAnonymeController = TextEditingController();
    String typeOffrandeId = types.first.id;
    final montantController = TextEditingController();
    String modePaiement = 'especes';

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.financesSaisirTitre),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String?>(
                    isExpanded: true,
                    initialValue: fideleId,
                    decoration: InputDecoration(labelText: l10n.financesChampDonateur),
                    items: [
                      DropdownMenuItem<String?>(value: null, child: Text(l10n.financesDonateurAnonyme)),
                      for (final f in fidelesDuNoeud) DropdownMenuItem<String?>(value: f.id, child: Text(f.nomComplet)),
                    ],
                    onChanged: (valeur) => setState(() => fideleId = valeur),
                  ),
                  if (fideleId == null)
                    TextField(
                      controller: donateurAnonymeController,
                      decoration: InputDecoration(labelText: l10n.financesChampLibelleDonateurAnonyme),
                    ),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: typeOffrandeId,
                    decoration: InputDecoration(labelText: l10n.financesChampTypeOffrande),
                    items: types.map((t) => DropdownMenuItem(value: t.id, child: Text(t.libelle))).toList(),
                    onChanged: (valeur) => setState(() => typeOffrandeId = valeur ?? typeOffrandeId),
                  ),
                  TextField(
                    controller: montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: l10n.financesChampMontant,
                      suffixText: AppDefaults.financesDeviseParDefaut,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: modePaiement,
                    decoration: InputDecoration(labelText: l10n.financesChampModePaiement),
                    items: [
                      DropdownMenuItem(value: 'especes', child: Text(l10n.financesModePaiementEspeces)),
                      DropdownMenuItem(value: 'mobile_money', child: Text(l10n.financesModePaiementMobileMoney)),
                      DropdownMenuItem(value: 'virement', child: Text(l10n.financesModePaiementVirement)),
                    ],
                    onChanged: (valeur) => setState(() => modePaiement = valeur ?? modePaiement),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.financesSaisirBouton)),
            ],
          ),
        );
      },
    );

    final montant = int.tryParse(montantController.text.trim());
    if (confirme == true && montant != null && montant > 0 && context.mounted) {
      final contribution = await controller.saisirContribution(
        fideleId: fideleId,
        libelleDonateurAnonyme: fideleId == null && donateurAnonymeController.text.trim().isNotEmpty
            ? donateurAnonymeController.text.trim()
            : null,
        typeOffrandeId: typeOffrandeId,
        montant: montant,
        devise: AppDefaults.financesDeviseParDefaut,
        noeudId: noeudId,
        modePaiement: modePaiement,
        origine: OrigineContribution.mobile,
      );
      if (contribution != null && context.mounted) {
        context.push(AppRoutes.contribution(contribution.id));
      }
    }
  }
}

class _RapportParType extends StatelessWidget {
  const _RapportParType({required this.contributions, required this.typesParId});

  final List<Contribution> contributions;
  final Map<String, String> typesParId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totauxParType = <String, int>{};
    for (final contribution in contributions) {
      if (contribution.statut != StatutContribution.validee) continue;
      totauxParType.update(
        contribution.typeOffrandeId,
        (total) => total + contribution.montant,
        ifAbsent: () => contribution.montant,
      );
    }
    if (totauxParType.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.financesRapportParTypeTitre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            for (final entree in totauxParType.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(typesParId[entree.key] ?? '—'),
                    Text('${entree.value} ${AppDefaults.financesDeviseParDefaut}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ContributionCard extends StatelessWidget {
  const _ContributionCard({required this.contribution, required this.typeLibelle, required this.onTap});

  final Contribution contribution;
  final String typeLibelle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();
    final fideleController = context.watch<FideleController>();
    final donateurNom = contribution.fideleId != null
        ? (fideleController.findById(contribution.fideleId!)?.nomComplet ?? '—')
        : (contribution.libelleDonateurAnonyme ?? l10n.financesDonateurAnonyme);

    final (statutLabel, statutColor) = switch (contribution.statut) {
      StatutContribution.enAttente => (l10n.financesStatutEnAttente, palette?.warning),
      StatutContribution.validee => (l10n.financesStatutValidee, palette?.success),
      StatutContribution.rejetee => (l10n.financesStatutRejetee, Theme.of(context).colorScheme.error),
    };

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(donateurNom),
        subtitle: Text('$typeLibelle — ${contribution.dateSaisie.toIso8601String().split('T').first}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${contribution.montant} ${contribution.devise}'),
            Chip(
              label: Text(statutLabel),
              backgroundColor: statutColor?.withValues(alpha: 0.16),
              labelStyle: TextStyle(color: statutColor, fontSize: 11),
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
