import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/zone_geographique_controller.dart';
import '../domain/models/entree_journal_parametres.dart';

/// Écran Windows 9 du Module XXIII (« Journal d'audit des modifications »),
/// repris sur mobile en lecture seule : chaque modification d'un paramètre
/// avec son auteur, sa date et ses valeurs avant/après (RG-XXIII-06).
/// Réservé à l'administrateur (garde du routeur).
class JournalParametresScreen extends StatelessWidget {
  const JournalParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideles = context.watch<FideleController>();

    String libelleAction(ActionJournalParametres action) => switch (action) {
      ActionJournalParametres.creation => l10n.parametresJournalCreation,
      ActionJournalParametres.modification => l10n.parametresJournalModification,
      ActionJournalParametres.suppression => l10n.parametresJournalSuppression,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.parametresJournalTitre)),
      body: StreamBuilder<List<EntreeJournalParametres>>(
        stream: context.read<ZoneGeographiqueController>().watchJournal(),
        builder: (context, snapshot) {
          final entrees = snapshot.data ?? const <EntreeJournalParametres>[];
          if (entrees.isEmpty) return Center(child: Text(l10n.parametresJournalAucune));
          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            itemCount: entrees.length,
            separatorBuilder: (context, index) => const Divider(height: AppDimensions.spacingLg),
            itemBuilder: (context, index) {
              final entree = entrees[index];
              final auteur = entree.auteurFideleId == null
                  ? l10n.parametresJournalCompteSansFiche
                  : fideles.findById(entree.auteurFideleId!)?.nomComplet ?? '—';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${libelleAction(entree.action)} · ${entree.referentiel}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text('$auteur · ${entree.date.toString().split('.').first}'),
                  if (entree.ancienneValeur != null) Text(l10n.parametresJournalAvant(entree.ancienneValeur!)),
                  if (entree.nouvelleValeur != null) Text(l10n.parametresJournalApres(entree.nouvelleValeur!)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
