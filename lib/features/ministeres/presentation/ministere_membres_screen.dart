import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/ministere_controller.dart';
import '../domain/models/affectation_ministere.dart';
import '../domain/models/role_affectation.dart';
import '../domain/models/statut_affectation.dart';

/// Écran 4 (Membres affectés) + écran 5 (Affectation d'un fidèle),
/// RG-III-01.
class MinistereMembresScreen extends StatelessWidget {
  const MinistereMembresScreen({required this.ministereId, super.key});

  final String ministereId;

  Future<void> _affecter(
    BuildContext context,
    MinistereController controller,
    FideleController fideleController,
  ) async {
    final fideles = fideleController.fideles;
    if (fideles.isEmpty) return;

    String fideleId = fideles.first.id;
    RoleAffectation role = RoleAffectation.membre;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Affecter un fidèle'),
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
              DropdownButtonFormField<RoleAffectation>(
                key: const Key('affectation_role_dropdown'),
                initialValue: role,
                decoration: const InputDecoration(labelText: 'Rôle'),
                items: RoleAffectation.values
                    .map((r) => DropdownMenuItem(value: r, child: Text(r.code)))
                    .toList(),
                onChanged: (valeur) => setState(() => role = valeur ?? role),
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
      await controller.affecter(ministereId: ministereId, fideleId: fideleId, role: role);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MinistereController>();
    final fideleController = context.watch<FideleController>();
    final ministere = controller.findById(ministereId);

    return Scaffold(
      appBar: AppBar(title: Text('Membres — ${ministere?.nom ?? ministereId}')),
      body: StreamBuilder<List<AffectationMinistere>>(
        stream: controller.watchAffectations(ministereId),
        builder: (context, snapshot) {
          final affectations = (snapshot.data ?? const <AffectationMinistere>[])
              .where((a) => a.statut != StatutAffectation.terminee)
              .toList();
          if (affectations.isEmpty) {
            return const Center(child: Text('Aucun membre affecté.'));
          }
          return ListView.builder(
            itemCount: affectations.length,
            itemBuilder: (context, index) {
              final affectation = affectations[index];
              final fidele = fideleController.findById(affectation.fideleId);
              return ListTile(
                title: Text(fidele?.nomComplet ?? affectation.fideleId),
                subtitle: Text(
                  affectation.statut == StatutAffectation.suspendue
                      ? '${affectation.role.code} (suspendu)'
                      : affectation.role.code,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Retirer',
                  onPressed: () => controller.retirerAffectation(affectation.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _affecter(context, controller, fideleController),
        tooltip: 'Affecter un fidèle',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
