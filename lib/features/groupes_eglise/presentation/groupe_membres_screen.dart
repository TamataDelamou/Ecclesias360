import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/groupe_controller.dart';
import '../domain/models/appartenance_groupe.dart';
import '../domain/models/origine_appartenance.dart';
import '../domain/models/type_regle_groupe.dart';

/// Écran 2 (Membres d'un groupe) + écran 4 (Affectation manuelle) + écran 5
/// (Statistiques démographiques du groupe, en en-tête), RG-VI-01/02.
class GroupeMembresScreen extends StatelessWidget {
  const GroupeMembresScreen({required this.groupeId, super.key});

  final String groupeId;

  Future<void> _affecter(BuildContext context, GroupeController controller, FideleController fideleController) async {
    final fideles = fideleController.fideles;
    if (fideles.isEmpty) return;

    String fideleId = fideles.first.id;
    final motifController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Affecter manuellement'),
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
                controller: motifController,
                decoration: const InputDecoration(
                  labelText: 'Motif de dérogation (si le fidèle ne correspond pas aux critères)',
                ),
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

    if (confirme == true) {
      final motif = motifController.text.trim();
      await controller.affecterManuellement(
        fideleId: fideleId,
        groupeId: groupeId,
        motifDerogation: motif.isEmpty ? null : motif,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GroupeController>();
    final fideleController = context.watch<FideleController>();
    final groupe = controller.findById(groupeId);
    final estAuto = groupe?.typeRegle == TypeRegleGroupe.auto;

    return Scaffold(
      appBar: AppBar(
        title: Text('Membres — ${groupe?.libelle ?? groupeId}'),
        actions: [
          if (estAuto)
            IconButton(
              icon: const Icon(Icons.rule),
              tooltip: 'Règles automatiques',
              onPressed: () => context.push(AppRoutes.groupeRegles(groupeId)),
            ),
        ],
      ),
      body: StreamBuilder<List<AppartenanceGroupe>>(
        stream: controller.watchMembres(groupeId),
        builder: (context, snapshot) {
          final membres = snapshot.data ?? const <AppartenanceGroupe>[];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text('${membres.length} membre(s)', style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    if (estAuto)
                      OutlinedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Recalculer'),
                        onPressed: () => controller.recalculerAppartenancesAuto(groupeId),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: membres.isEmpty
                    ? const Center(child: Text('Aucun membre dans ce groupe.'))
                    : ListView.builder(
                        itemCount: membres.length,
                        itemBuilder: (context, index) {
                          final membre = membres[index];
                          final fidele = fideleController.findById(membre.fideleId);
                          return ListTile(
                            title: Text(fidele?.nomComplet ?? membre.fideleId),
                            subtitle: Text(
                              membre.origine == OrigineAppartenance.auto
                                  ? 'Automatique'
                                  : membre.motifDerogation != null
                                      ? 'Manuel — dérogation : ${membre.motifDerogation}'
                                      : 'Manuel',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.close),
                              tooltip: 'Retirer',
                              onPressed: () => controller.retirerAppartenance(membre.id),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _affecter(context, controller, fideleController),
        tooltip: 'Affecter manuellement',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
