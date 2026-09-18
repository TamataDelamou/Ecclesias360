import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/comite_controller.dart';
import '../domain/models/membre_comite.dart';

/// Écran 1 (Liste des membres du comité) + écran 2 (Fiche membre — fonction
/// et mandat, affichés en ligne), RG-VII-01.
class MembresComiteScreen extends StatelessWidget {
  const MembresComiteScreen({required this.noeudId, super.key});

  final String noeudId;

  Future<void> _nommer(BuildContext context, ComiteController controller, FideleController fideleController) async {
    final fideles = fideleController.fideles;
    if (fideles.isEmpty) return;

    String fideleId = fideles.first.id;
    final fonctionController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Nommer un membre du comité'),
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
                decoration: const InputDecoration(labelText: 'Fonction (ex. Pasteur, Diacre)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Nommer')),
          ],
        ),
      ),
    );

    if (confirme == true && fonctionController.text.trim().isNotEmpty) {
      await controller.nommerMembre(fideleId: fideleId, noeudId: noeudId, fonction: fonctionController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ComiteController>();
    final fideleController = context.watch<FideleController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Membres du comité')),
      body: StreamBuilder<List<MembreComite>>(
        stream: controller.watchMembres(noeudId),
        builder: (context, snapshot) {
          final membres = snapshot.data ?? const <MembreComite>[];
          if (membres.isEmpty) {
            return const Center(child: Text('Aucun membre nommé.'));
          }
          return ListView.builder(
            itemCount: membres.length,
            itemBuilder: (context, index) {
              final membre = membres[index];
              final fidele = fideleController.findById(membre.fideleId);
              final debut = membre.dateDebut.toIso8601String().split('T').first;
              return ListTile(
                title: Text(fidele?.nomComplet ?? membre.fideleId),
                subtitle: Text(
                  membre.mandatActif ? '${membre.fonction} — depuis le $debut' : '${membre.fonction} (mandat clos)',
                ),
                trailing: membre.mandatActif
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Clore le mandat',
                        onPressed: () => controller.clorerMandat(membre.id),
                      )
                    : null,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _nommer(context, controller, fideleController),
        tooltip: 'Nommer un membre',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
