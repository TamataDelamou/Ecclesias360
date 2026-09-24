import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../finances/presentation/acces_finances.dart';
import '../application/comptabilite_controller.dart';
import '../domain/models/compte_comptable.dart';
import '../domain/models/ecriture_comptable.dart';
import '../domain/models/periode_comptable.dart';

/// Écrans mobile 1/2/3 du Cahier (RG-XXI-01/02/03/06), combinés en un seul
/// écran à onglets — même motif de combinaison que d'autres modules
/// (ex. Contributions du Module XI). Purement consultatif : conformément à
/// RG-XXI-02 (« sans ressaisie manuelle »), aucune écriture comptable
/// n'est jamais saisie depuis mobile, toutes proviennent automatiquement
/// des Modules XI et XX. L'écran mobile 4 (« Justificatifs numérisés »)
/// n'est pas construit : `piece_justificative_id` n'est qu'un simple
/// identifiant texte (voir `ComptabiliteRepository`), aucune infra de
/// numérisation/capture n'existe dans le dépôt — même limite documentée
/// que l'écran 8 du Module II et les pièces du Module X.
class ComptabiliteScreen extends StatelessWidget {
  const ComptabiliteScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ComptabiliteController>();
    final l10n = AppLocalizations.of(context)!;

    // RG-SEC-06 : gardé aussi contre l'accès direct par la route, pas
    // seulement par le masquage du bouton de la fiche de nœud.
    return AccesFinancesBuilder(
      builder: (context, acces) {
        if (!acces.peutConsulterComptabilite(noeudId)) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.comptabiliteTitre)),
            body: Center(child: Text(l10n.comptabiliteAccesReserve)),
          );
        }
        return _ComptabiliteOnglets(controller: controller, noeudId: noeudId);
      },
    );
  }
}

class _ComptabiliteOnglets extends StatelessWidget {
  const _ComptabiliteOnglets({required this.controller, required this.noeudId});

  final ComptabiliteController controller;
  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.comptabiliteTitre),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.comptabiliteOngletCaisse),
              Tab(text: l10n.comptabiliteOngletEcritures),
              Tab(text: l10n.comptabiliteOngletRapport),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _CaisseTab(controller: controller, noeudId: noeudId),
            _EcrituresTab(controller: controller, noeudId: noeudId),
            _RapportTab(controller: controller, noeudId: noeudId),
          ],
        ),
      ),
    );
  }
}

class _CaisseTab extends StatelessWidget {
  const _CaisseTab({required this.controller, required this.noeudId});

  final ComptabiliteController controller;
  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder<int>(
      future: controller.soldeCaisseDuJour(noeudId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Card(
            margin: const EdgeInsets.all(AppDimensions.spacingLg),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingXl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.comptabiliteSoldeCaisseDuJour, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppDimensions.spacingSm),
                  Text(
                    '${snapshot.data} ${AppDefaults.financesDeviseParDefaut}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EcrituresTab extends StatelessWidget {
  const _EcrituresTab({required this.controller, required this.noeudId});

  final ComptabiliteController controller;
  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<CompteComptable>>(
      stream: controller.watchPlanComptable(),
      builder: (context, comptesSnapshot) {
        final comptesParId = {for (final c in comptesSnapshot.data ?? const <CompteComptable>[]) c.id: c};

        return StreamBuilder<List<EcritureComptable>>(
          stream: controller.watchEcritures(noeudId),
          builder: (context, snapshot) {
            final ecritures = snapshot.data ?? const <EcritureComptable>[];
            if (ecritures.isEmpty) {
              return Center(child: Text(l10n.comptabiliteAucuneEcriture));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.spacingMd),
              itemCount: ecritures.length,
              itemBuilder: (context, index) {
                final ecriture = ecritures[index];
                final compte = comptesParId[ecriture.compteId];
                final estDebit = ecriture.debit > 0;
                return Card(
                  child: ListTile(
                    title: Text(compte?.libelle ?? ecriture.compteId),
                    subtitle: Text(ecriture.libelle ?? ecriture.date.toString()),
                    trailing: Text(
                      estDebit
                          ? '${l10n.comptabiliteDebit} ${ecriture.debit}'
                          : '${l10n.comptabiliteCredit} ${ecriture.credit}',
                      style: TextStyle(
                        color: estDebit ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _RapportTab extends StatelessWidget {
  const _RapportTab({required this.controller, required this.noeudId});

  final ComptabiliteController controller;
  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder<PeriodeComptable?>(
      future: controller.periodeCouranteOuverteOuNull(),
      builder: (context, periodeSnapshot) {
        if (!periodeSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final periode = periodeSnapshot.data;
        if (periode == null) {
          return Center(child: Text(l10n.comptabiliteAucunePeriodeOuverte));
        }
        return FutureBuilder<({int recettes, int depenses})>(
          future: controller.rapportFinancierRapide(noeudId: noeudId, periodeId: periode.id),
          builder: (context, rapportSnapshot) {
            if (!rapportSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final rapport = rapportSnapshot.data!;
            final soldeNet = rapport.recettes - rapport.depenses;
            return ListView(
              padding: const EdgeInsets.all(AppDimensions.spacingMd),
              children: [
                Card(
                  child: ListTile(
                    title: Text(l10n.comptabiliteRapportRecettes),
                    trailing: Text('${rapport.recettes} ${AppDefaults.financesDeviseParDefaut}'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(l10n.comptabiliteRapportDepenses),
                    trailing: Text('${rapport.depenses} ${AppDefaults.financesDeviseParDefaut}'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(l10n.comptabiliteRapportSoldeNet),
                    trailing: Text(
                      '$soldeNet ${AppDefaults.financesDeviseParDefaut}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
