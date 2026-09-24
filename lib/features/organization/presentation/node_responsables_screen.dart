import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/organisation_controller.dart';
import '../domain/models/node_responsable.dart';
import '../domain/rules/organisation_acces_rules.dart';

/// Écran 4 (Liste des responsables d'un nœud) + écran 5 (Affectation d'un
/// responsable), RG-I-05.
class NodeResponsablesScreen extends StatelessWidget {
  const NodeResponsablesScreen({required this.nodeId, super.key});

  final String nodeId;

  Future<void> _affecter(BuildContext context, OrganisationController controller, FideleController fideleController) async {
    final fideles = fideleController.fideles;
    if (fideles.isEmpty) return;

    String fideleId = fideles.first.id;
    final fonctionController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Affecter un responsable'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: fideleId,
                decoration: const InputDecoration(labelText: 'Fidèle'),
                items: fideles
                    .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                    .toList(),
                onChanged: (valeur) => setState(() => fideleId = valeur ?? fideleId),
              ),
              TextField(
                controller: fonctionController,
                decoration: const InputDecoration(labelText: 'Fonction (ex. Pasteur, Trésorier)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Affecter')),
          ],
        ),
      ),
    );

    final acteur = context.mounted ? context.read<SessionController>().acteur : null;
    if (confirme == true && acteur != null && fonctionController.text.trim().isNotEmpty) {
      await controller.affecterResponsable(
        acteur: acteur,
        noeudId: nodeId,
        fideleId: fideleId,
        fonction: fonctionController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gardé aussi contre l'accès direct par la route (RG-SEC-04) : liste au rang
    // de gestion, désignation au rang pasteur (policy node_responsables).
    final role = context.watch<SessionController>().role;
    if (!OrganisationAccesRules.peutGererNoeuds(role)) {
      return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.organisationTitre)),
        body: Center(child: Text(AppLocalizations.of(context)!.organisationAccesReserve)),
      );
    }
    final designe = OrganisationAccesRules.peutDesignerResponsables(role);
    final controller = context.read<OrganisationController>();
    final fideleController = context.watch<FideleController>();
    final noeud = controller.findById(nodeId);

    return Scaffold(
      appBar: AppBar(title: Text('Responsables — ${noeud?.nom ?? nodeId}')),
      body: StreamBuilder<List<NodeResponsable>>(
        stream: controller.watchResponsables(nodeId),
        builder: (context, snapshot) {
          final responsables = snapshot.data ?? const <NodeResponsable>[];
          if (responsables.isEmpty) {
            return const Center(child: Text('Aucun responsable affecté.'));
          }
          return ListView.builder(
            itemCount: responsables.length,
            itemBuilder: (context, index) {
              final responsable = responsables[index];
              final fidele = fideleController.findById(responsable.fideleId);
              final actif = responsable.dateFin == null;
              return ListTile(
                title: Text(fidele?.nomComplet ?? responsable.fideleId),
                subtitle: Text(
                  actif ? responsable.fonction : '${responsable.fonction} (mandat terminé)',
                ),
                trailing: actif && designe
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Mettre fin au mandat',
                        onPressed: () {
                          final acteur = context.read<SessionController>().acteur;
                          if (acteur != null) controller.retirerResponsable(responsable.id, acteur: acteur);
                        },
                      )
                    : null,
              );
            },
          );
        },
      ),
      floatingActionButton: designe
          ? FloatingActionButton(
              onPressed: () => _affecter(context, controller, fideleController),
              tooltip: 'Affecter un responsable',
              child: const Icon(Icons.person_add),
            )
          : null,
    );
  }
}
