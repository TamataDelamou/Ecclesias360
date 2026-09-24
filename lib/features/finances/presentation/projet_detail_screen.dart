import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/finances_controller.dart';
import '../domain/models/depense_projet.dart';
import '../domain/models/projet.dart';
import 'acces_finances.dart';

/// Fiche projet (RG-XI-03) : solde recalculé (jamais stocké), dépenses avec
/// dérogation tracée au besoin. Le valideur d'une dépense est la fiche liée
/// à la session, jamais choisi dans une liste ; accès réservé (policy
/// `projets_acces`, 0019) au rang responsable et au trésorier du nœud.
class ProjetDetailScreen extends StatelessWidget {
  const ProjetDetailScreen({required this.projetId, super.key});

  final String projetId;

  Future<void> _ajouterDepense(
    BuildContext context,
    FinancesController controller,
    Projet projet,
    String valideParFideleId,
  ) async {
    final libelleController = TextEditingController();
    final montantController = TextEditingController();
    bool derogationTracee = false;
    final motifDerogationController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.financesDepenseAjouterTitre),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: libelleController, decoration: InputDecoration(labelText: l10n.financesChampLibelleDepense)),
                  TextField(
                    controller: montantController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.financesChampMontant, suffixText: projet.devise),
                  ),
                  CheckboxListTile(
                    value: derogationTracee,
                    title: Text(l10n.financesChampDerogationTracee),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (valeur) => setState(() => derogationTracee = valeur ?? false),
                  ),
                  if (derogationTracee)
                    TextField(
                      controller: motifDerogationController,
                      decoration: InputDecoration(labelText: l10n.financesChampMotif),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );

    final montant = int.tryParse(montantController.text.trim());
    if (confirme == true && montant != null && montant > 0 && libelleController.text.trim().isNotEmpty) {
      await controller.ajouterDepenseProjet(
        projetId: projetId,
        montant: montant,
        libelle: libelleController.text.trim(),
        valideParFideleId: valideParFideleId,
        derogationTracee: derogationTracee,
        motifDerogation: derogationTracee && motifDerogationController.text.trim().isNotEmpty
            ? motifDerogationController.text.trim()
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FinancesController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financesProjetDetailTitre)),
      body: FutureBuilder<Projet?>(
        future: controller.findProjetById(projetId),
        builder: (context, projetSnapshot) {
          final projet = projetSnapshot.data;
          if (!projetSnapshot.hasData) return const SizedBox.shrink();
          if (projet == null) return Center(child: Text(l10n.financesProjetIntrouvable));

          return AccesFinancesBuilder(
            builder: (context, acces) => !acces.peutGererProjets(projet.noeudId)
                ? Center(child: Text(l10n.financesAccesReserve))
                : StreamBuilder<List<DepenseProjet>>(
            stream: controller.watchDepensesProjet(projetId),
            builder: (context, depensesSnapshot) {
              final depenses = depensesSnapshot.data ?? const <DepenseProjet>[];
              // Recalculé à chaque émission du flux des dépenses (RG-XI-03,
              // jamais une colonne stockée) : un nouveau `Future` est
              // reconstruit ici à chaque rafraîchissement, ce qui déclenche
              // bien un nouvel appel plutôt qu'une valeur figée à l'ouverture.
              return FutureBuilder<int>(
                future: controller.soldeProjet(projetId),
                builder: (context, soldeSnapshot) {
                  final solde = soldeSnapshot.data ?? 0;
                  return ListView(
                    padding: const EdgeInsets.all(AppDimensions.spacingLg),
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimensions.spacingMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(projet.nom, style: Theme.of(context).textTheme.headlineSmall),
                              const SizedBox(height: AppDimensions.spacingSm),
                              Text(l10n.financesProjetSoldeSurBudget(solde, projet.budgetPrevisionnel, projet.devise)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingMd),
                      if (acces.fideleId == null)
                        Text(l10n.authFicheLieeRequise)
                      else
                        FilledButton(
                          onPressed: () => _ajouterDepense(context, controller, projet, acces.fideleId!),
                          child: Text(l10n.financesDepenseAjouterBouton),
                        ),
                      const SizedBox(height: AppDimensions.spacingMd),
                      Text(l10n.financesDepensesTitre, style: Theme.of(context).textTheme.titleMedium),
                      if (depenses.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSm),
                          child: Text(l10n.financesDepensesAucune),
                        )
                      else
                        for (final depense in depenses)
                          Card(
                            child: ListTile(
                              title: Text(depense.libelle),
                              subtitle: Text(
                                depense.derogationTracee
                                    ? l10n.financesDepenseDerogation(depense.date.toIso8601String().split('T').first)
                                    : depense.date.toIso8601String().split('T').first,
                                style: depense.derogationTracee ? TextStyle(color: Theme.of(context).colorScheme.error) : null,
                              ),
                              trailing: Text('${depense.montant} ${projet.devise}'),
                            ),
                          ),
                    ],
                  );
                },
              );
            },
          ),
          );
        },
      ),
    );
  }
}
