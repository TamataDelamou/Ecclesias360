import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/comite_controller.dart';
import '../domain/models/seance_comite.dart';

/// Écran 6 (Historique des PV), reflété ici comme liste des séances (statut
/// de quorum visible par ligne) — point d'entrée vers l'écran de séance qui
/// regroupe décisions, PV et tâches (RG-VII-02/03/05).
class SeancesComiteListScreen extends StatelessWidget {
  const SeancesComiteListScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ComiteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Séances du comité')),
      body: StreamBuilder<List<SeanceComite>>(
        stream: controller.watchSeances(noeudId),
        builder: (context, snapshot) {
          final seances = snapshot.data ?? const <SeanceComite>[];
          if (seances.isEmpty) {
            return const Center(child: Text('Aucune séance enregistrée.'));
          }
          return ListView.builder(
            itemCount: seances.length,
            itemBuilder: (context, index) {
              final seance = seances[index];
              return ListTile(
                title: Text(seance.ordreDuJour),
                subtitle: Text(seance.date.toIso8601String().split('T').first),
                trailing: Chip(
                  label: Text(
                    seance.quorumAtteint == null
                        ? 'Quorum non configuré'
                        : seance.quorumAtteint!
                            ? 'Quorum atteint'
                            : 'Quorum non atteint',
                  ),
                ),
                onTap: () => context.push(AppRoutes.comiteSeance(seance.id)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.comiteNouvelleSeance(noeudId)),
        tooltip: 'Nouvelle séance',
        child: const Icon(Icons.add),
      ),
    );
  }
}
