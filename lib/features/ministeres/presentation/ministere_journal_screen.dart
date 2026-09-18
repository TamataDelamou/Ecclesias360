import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/ministere_controller.dart';
import '../domain/models/activite_ministere.dart';

/// Écran 7 (Journal d'activités du ministère), RG-III-05.
class MinistereJournalScreen extends StatelessWidget {
  const MinistereJournalScreen({required this.ministereId, super.key});

  final String ministereId;

  Future<void> _ajouterActivite(BuildContext context, MinistereController controller) async {
    TypeActiviteMinistere type = TypeActiviteMinistere.reunion;
    final descriptionController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Ajouter une activité'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<TypeActiviteMinistere>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: TypeActiviteMinistere.values
                    .map((t) => DropdownMenuItem(value: t, child: Text(t.code)))
                    .toList(),
                onChanged: (valeur) => setState(() => type = valeur ?? type),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Ajouter')),
          ],
        ),
      ),
    );

    if (confirme == true && descriptionController.text.trim().isNotEmpty) {
      await controller.ajouterActivite(
        ministereId: ministereId,
        type: type,
        description: descriptionController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MinistereController>();
    final ministere = controller.findById(ministereId);

    return Scaffold(
      appBar: AppBar(title: Text("Journal d'activités — ${ministere?.nom ?? ministereId}")),
      body: StreamBuilder<List<ActiviteMinistere>>(
        stream: controller.watchActivites(ministereId),
        builder: (context, snapshot) {
          final activites = snapshot.data ?? const <ActiviteMinistere>[];
          if (activites.isEmpty) {
            return const Center(child: Text('Aucune activité enregistrée.'));
          }
          return ListView.builder(
            itemCount: activites.length,
            itemBuilder: (context, index) {
              final activite = activites[index];
              return ListTile(
                title: Text(activite.description),
                subtitle: Text('${activite.type.code} · ${activite.date.toIso8601String().split('T').first}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _ajouterActivite(context, controller),
        tooltip: 'Ajouter une activité',
        child: const Icon(Icons.add),
      ),
    );
  }
}
