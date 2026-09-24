import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/patrimoine_controller.dart';
import '../domain/models/bien.dart';
import '../domain/models/categorie_bien.dart';
import '../domain/models/etat_bien.dart';
import 'acces_patrimoine.dart';

/// Écran « Inventaire des biens (liste) » du Cahier (RG-XX-01), enrichi de
/// la section « Stocks et seuils d'alerte » (RG-XX-05) — même motif de
/// combinaison qu'un rapport intégré à une liste (ex. rapport par type
/// d'offrande du Module XI). L'accès aux campagnes d'inventaire (RG-XX-04)
/// se fait par une icône de la barre d'app, même motif que l'accès aux
/// trésoriers depuis l'écran Contributions du Module XI.
class BiensListScreen extends StatelessWidget {
  const BiensListScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PatrimoineController>();
    final l10n = AppLocalizations.of(context)!;
    if (!peutGererBiens(context.watch<SessionController>())) {
      return EcranPatrimoineAccesReserve(titre: l10n.patrimoineTitre);
    }

    return StreamBuilder<List<CategorieBien>>(
      stream: controller.watchCategoriesBien(),
      builder: (context, categoriesSnapshot) {
        final categories = categoriesSnapshot.data ?? const <CategorieBien>[];
        final categoriesParId = {for (final c in categories) c.id: c};

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.patrimoineTitre),
            actions: [
              IconButton(
                icon: const Icon(Icons.fact_check_outlined),
                tooltip: l10n.patrimoineCampagnesTitre,
                onPressed: () => context.push(AppRoutes.campagnesInventaireDuNoeud(noeudId)),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _ajouterBien(context, controller, categories),
            tooltip: l10n.patrimoineAjouterTooltip,
            child: const Icon(Icons.add),
          ),
          body: StreamBuilder<List<Bien>>(
            stream: controller.watchBiens(noeudId),
            builder: (context, biensSnapshot) {
              final biens = biensSnapshot.data ?? const <Bien>[];
              if (biens.isEmpty) {
                return Center(child: Text(l10n.patrimoineAucunBien));
              }
              return FutureBuilder<List<Bien>>(
                // Recalculé à chaque émission de la liste des biens (même
                // motif que le solde de projet, Module XI) : les alertes de
                // seuil ne se rafraîchissent en direct que quand la liste
                // des biens elle-même change, pas à chaque mouvement de
                // stock isolé — limitation cosmétique documentée (AGENTS.md).
                future: controller.biensSousSeuilAlerte(noeudId),
                builder: (context, alerteSnapshot) {
                  final biensSousSeuil = alerteSnapshot.data ?? const <Bien>[];
                  return ListView(
                    padding: const EdgeInsets.all(AppDimensions.spacingLg),
                    children: [
                      if (biensSousSeuil.isNotEmpty) ...[
                        _AlerteSeuilCard(biens: biensSousSeuil, categoriesParId: categoriesParId),
                        const SizedBox(height: AppDimensions.spacingMd),
                      ],
                      for (var i = 0; i < biens.length; i++) ...[
                        if (i > 0) const SizedBox(height: AppDimensions.spacingSm),
                        StaggeredFadeIn(
                          index: i,
                          child: _BienCard(
                            bien: biens[i],
                            categorieLibelle: categoriesParId[biens[i].categorieId]?.libelle ?? '—',
                            onTap: () => context.push(AppRoutes.bien(biens[i].id)),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _ajouterBien(BuildContext context, PatrimoineController controller, List<CategorieBien> categories) async {
    if (categories.isEmpty) return;

    final idInventaireController = TextEditingController();
    final designationController = TextEditingController();
    final valeurAcquisitionController = TextEditingController();
    final valeurVenaleController = TextEditingController();
    final seuilAlerteController = TextEditingController();
    String categorieId = categories.first.id;
    DateTime dateAcquisition = DateTime.now();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) {
            final categorieSelectionnee = categories.firstWhere((c) => c.id == categorieId);
            final estGestionStock = categorieSelectionnee.code == 'stocks';
            return AlertDialog(
              title: Text(l10n.patrimoineAjouterTitre),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: idInventaireController,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampIdInventaire),
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: categorieId,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampCategorie),
                      items: categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.libelle))).toList(),
                      onChanged: (valeur) => setState(() => categorieId = valeur ?? categorieId),
                    ),
                    TextField(
                      controller: designationController,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampDesignation),
                    ),
                    TextField(
                      controller: valeurAcquisitionController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampValeurAcquisition),
                    ),
                    TextField(
                      controller: valeurVenaleController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampValeurVenale),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.patrimoineChampDateAcquisition),
                      subtitle: Text(dateAcquisition.toIso8601String().split('T').first),
                      trailing: const Icon(Icons.calendar_today_outlined),
                      onTap: () async {
                        final choisie = await showDatePicker(
                          context: context,
                          initialDate: dateAcquisition,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );
                        if (choisie != null) setState(() => dateAcquisition = choisie);
                      },
                    ),
                    if (estGestionStock)
                      TextField(
                        controller: seuilAlerteController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: l10n.patrimoineChampSeuilAlerteStock),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
                FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
              ],
            );
          },
        );
      },
    );

    final valeurAcquisition = int.tryParse(valeurAcquisitionController.text.trim());
    final valeurVenale = int.tryParse(valeurVenaleController.text.trim());
    if (confirme == true &&
        idInventaireController.text.trim().isNotEmpty &&
        designationController.text.trim().isNotEmpty &&
        valeurAcquisition != null &&
        valeurVenale != null &&
        context.mounted) {
      final bien = await controller.ajouterBien(
        idInventaire: idInventaireController.text.trim(),
        categorieId: categorieId,
        noeudId: noeudId,
        designation: designationController.text.trim(),
        valeurAcquisition: valeurAcquisition,
        valeurVenale: valeurVenale,
        devise: 'GNF',
        dateAcquisition: dateAcquisition,
        seuilAlerteStock: int.tryParse(seuilAlerteController.text.trim()),
      );
      if (bien != null && context.mounted) {
        context.push(AppRoutes.bien(bien.id));
      }
    }
  }
}

class _AlerteSeuilCard extends StatelessWidget {
  const _AlerteSeuilCard({required this.biens, required this.categoriesParId});

  final List<Bien> biens;
  final Map<String, CategorieBien> categoriesParId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();
    return Card(
      color: palette?.warning.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.patrimoineAlerteSeuilTitre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            for (final bien in biens)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('${bien.designation} (${categoriesParId[bien.categorieId]?.libelle ?? '—'})'),
              ),
          ],
        ),
      ),
    );
  }
}

class _BienCard extends StatelessWidget {
  const _BienCard({required this.bien, required this.categorieLibelle, required this.onTap});

  final Bien bien;
  final String categorieLibelle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<EcclesiasPaletteColors>();

    final (etatLabel, etatColor) = switch (bien.etat) {
      EtatBien.neuf => (l10n.patrimoineEtatNeuf, palette?.success),
      EtatBien.bon => (l10n.patrimoineEtatBon, palette?.success),
      EtatBien.aReparer => (l10n.patrimoineEtatAReparer, palette?.warning),
      EtatBien.horsService => (l10n.patrimoineEtatHorsService, Theme.of(context).colorScheme.error),
      EtatBien.cede => (l10n.patrimoineEtatCede, palette?.textSecondary),
    };

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(bien.designation),
        subtitle: Text('$categorieLibelle — ${bien.idInventaire}'),
        trailing: Chip(
          label: Text(etatLabel),
          backgroundColor: etatColor?.withValues(alpha: 0.16),
          labelStyle: TextStyle(color: etatColor, fontSize: 11),
          side: BorderSide.none,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
