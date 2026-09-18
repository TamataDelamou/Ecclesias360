import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/groupe_controller.dart';
import '../domain/models/appartenance_groupe.dart';
import '../domain/models/origine_appartenance.dart';

/// Vue complémentaire depuis la fiche fidèle : groupes de l'Église
/// auxquels il appartient (RG-VI-02, non exclusif).
class FideleGroupesScreen extends StatelessWidget {
  const FideleGroupesScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GroupeController>();
    final fideleController = context.watch<FideleController>();
    final fidele = fideleController.findById(fideleId);

    return Scaffold(
      appBar: AppBar(title: Text('Groupes — ${fidele?.nomComplet ?? fideleId}')),
      body: StreamBuilder<List<AppartenanceGroupe>>(
        stream: controller.watchAppartenances(fideleId),
        builder: (context, snapshot) {
          final appartenances = snapshot.data ?? const <AppartenanceGroupe>[];
          if (appartenances.isEmpty) {
            return const Center(child: Text('Aucun groupe.'));
          }
          return ListView.builder(
            itemCount: appartenances.length,
            itemBuilder: (context, index) {
              final appartenance = appartenances[index];
              final groupe = controller.findById(appartenance.groupeId);
              return ListTile(
                title: Text(groupe?.libelle ?? appartenance.groupeId),
                subtitle: Text(
                  appartenance.origine == OrigineAppartenance.auto ? 'Automatique' : 'Manuel',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
