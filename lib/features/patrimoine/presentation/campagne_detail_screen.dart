import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/patrimoine_controller.dart';
import '../domain/models/bien.dart';
import '../domain/models/campagne_inventaire.dart';
import '../domain/models/categorie_bien.dart';
import '../domain/models/etat_bien.dart';
import '../domain/models/pointage_inventaire.dart';
import '../domain/models/statut_campagne_inventaire.dart';

/// Fiche d'une campagne d'inventaire (RG-XX-04, écran 5 du Cahier) : liste
/// des pointages terrain et bouton de clôture. La liste des biens du nœud,
/// nécessaire au choix du bien pointé dans la boîte de dialogue, provient
/// d'un `StreamBuilder` englobant plutôt que d'un `await stream.first` dans
/// le gestionnaire du bouton — piège déjà rencontré aux Modules X et XI
/// (voir AGENTS.md) : la donnée doit être disponible de façon synchrone au
/// moment du clic.
class CampagneDetailScreen extends StatelessWidget {
  const CampagneDetailScreen({required this.campagneId, super.key});

  final String campagneId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PatrimoineController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.patrimoineCampagneFicheTitre)),
      body: FutureBuilder<CampagneInventaire?>(
        future: controller.findCampagneById(campagneId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final campagne = snapshot.data;
          if (campagne == null) return Center(child: Text(l10n.patrimoineCampagneIntrouvable));
          return _CampagneDetailBody(campagne: campagne, controller: controller);
        },
      ),
    );
  }
}

class _CampagneDetailBody extends StatefulWidget {
  const _CampagneDetailBody({required this.campagne, required this.controller});

  final CampagneInventaire campagne;
  final PatrimoineController controller;

  @override
  State<_CampagneDetailBody> createState() => _CampagneDetailBodyState();
}

class _CampagneDetailBodyState extends State<_CampagneDetailBody> {
  late CampagneInventaire _campagne = widget.campagne;

  Future<void> _rafraichir() async {
    final campagne = await widget.controller.findCampagneById(_campagne.id);
    if (mounted && campagne != null) setState(() => _campagne = campagne);
  }

  Future<void> _cloturer(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.patrimoineCampagneCloturerTitre),
        content: Text(l10n.patrimoineCampagneCloturerConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.patrimoineCampagneCloturerBouton)),
        ],
      ),
    );
    if (confirme == true) {
      await widget.controller.cloturerCampagne(_campagne.id);
      await _rafraichir();
    }
  }

  Future<void> _ajouterPointage(BuildContext context, List<Bien> biens, Map<String, CategorieBien> categoriesParId) async {
    if (biens.isEmpty) return;

    String bienId = biens.first.id;
    EtatBien etatConstate = biens.first.etat;
    final quantiteController = TextEditingController();
    final commentaireController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) {
            final bienSelectionne = biens.firstWhere((b) => b.id == bienId);
            final estGestionStock = categoriesParId[bienSelectionne.categorieId]?.code == 'stocks';
            return AlertDialog(
              title: Text(l10n.patrimoineCampagneAjouterPointageTitre),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: bienId,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampBien),
                      items: biens.map((b) => DropdownMenuItem(value: b.id, child: Text(b.designation))).toList(),
                      onChanged: (valeur) => setState(() => bienId = valeur ?? bienId),
                    ),
                    DropdownButtonFormField<EtatBien>(
                      isExpanded: true,
                      initialValue: etatConstate,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampEtatConstate),
                      items: EtatBien.values
                          .map((e) => DropdownMenuItem(value: e, child: Text(_libelleEtat(l10n, e))))
                          .toList(),
                      onChanged: (valeur) => setState(() => etatConstate = valeur ?? etatConstate),
                    ),
                    if (estGestionStock)
                      TextField(
                        controller: quantiteController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: l10n.patrimoineChampQuantiteConstatee),
                      ),
                    TextField(
                      controller: commentaireController,
                      decoration: InputDecoration(labelText: l10n.patrimoineChampCommentaire),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(l10n.patrimoineCampagneAjouterPointageBouton),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirme == true) {
      await widget.controller.enregistrerPointage(
        campagneId: _campagne.id,
        bienId: bienId,
        etatConstate: etatConstate,
        quantiteConstatee: int.tryParse(quantiteController.text.trim()),
        commentaire: commentaireController.text.trim().isNotEmpty ? commentaireController.text.trim() : null,
      );
    }
  }

  String _libelleEtat(AppLocalizations l10n, EtatBien etat) => switch (etat) {
        EtatBien.neuf => l10n.patrimoineEtatNeuf,
        EtatBien.bon => l10n.patrimoineEtatBon,
        EtatBien.aReparer => l10n.patrimoineEtatAReparer,
        EtatBien.horsService => l10n.patrimoineEtatHorsService,
        EtatBien.cede => l10n.patrimoineEtatCede,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final estEnCours = _campagne.statut == StatutCampagneInventaire.enCours;

    return StreamBuilder<List<Bien>>(
      stream: widget.controller.watchBiens(_campagne.noeudId),
      builder: (context, biensSnapshot) {
        final biens = biensSnapshot.data ?? const <Bien>[];
        return StreamBuilder<List<CategorieBien>>(
          stream: widget.controller.watchCategoriesBien(),
          builder: (context, categoriesSnapshot) {
            final categories = categoriesSnapshot.data ?? const <CategorieBien>[];
            final categoriesParId = {for (final c in categories) c.id: c};

            return Scaffold(
              floatingActionButton: estEnCours
                  ? FloatingActionButton(
                      onPressed: () => _ajouterPointage(context, biens, categoriesParId),
                      tooltip: l10n.patrimoineCampagneAjouterPointageTooltip,
                      child: const Icon(Icons.add),
                    )
                  : null,
              body: ListView(
                padding: const EdgeInsets.all(AppDimensions.spacingLg),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_campagne.libelle, style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: AppDimensions.spacingSm),
                          Text(
                            estEnCours ? l10n.patrimoineCampagneEnCours : l10n.patrimoineCampagneCloturee,
                          ),
                          Text(l10n.patrimoineCampagneDemarreeLe(_campagne.dateDebut.toIso8601String().split('T').first)),
                          if (_campagne.dateCloture != null)
                            Text(
                              l10n.patrimoineCampagneClotureeLe(_campagne.dateCloture!.toIso8601String().split('T').first),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  if (estEnCours)
                    OutlinedButton(onPressed: () => _cloturer(context), child: Text(l10n.patrimoineCampagneCloturerBouton)),
                  const SizedBox(height: AppDimensions.spacingMd),
                  Text(l10n.patrimoineCampagnePointagesTitre, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppDimensions.spacingSm),
                  StreamBuilder<List<PointageInventaire>>(
                    stream: widget.controller.watchPointages(_campagne.id),
                    builder: (context, pointagesSnapshot) {
                      final pointages = pointagesSnapshot.data ?? const <PointageInventaire>[];
                      if (pointages.isEmpty) {
                        return Text(l10n.patrimoineCampagnePointagesAucun);
                      }
                      final biensParId = {for (final b in biens) b.id: b};
                      return Column(
                        children: [
                          for (final pointage in pointages)
                            Card(
                              child: ListTile(
                                title: Text(biensParId[pointage.bienId]?.designation ?? '—'),
                                subtitle: Text(_libelleEtat(l10n, pointage.etatConstate)),
                                trailing: pointage.ecartDetecte
                                    ? Icon(Icons.warning_amber_outlined, color: Theme.of(context).colorScheme.error)
                                    : const Icon(Icons.check_circle_outline),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
