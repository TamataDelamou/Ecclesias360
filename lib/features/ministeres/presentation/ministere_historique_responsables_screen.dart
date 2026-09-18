import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/ministere_controller.dart';
import '../domain/models/mandat_responsable.dart';

/// Écran 6 (Historique des responsables), RG-III-02/05. Les mandats clos
/// forment l'historique ; le mandat sans `dateFinReelle` est le responsable
/// en fonction.
class MinistereHistoriqueResponsablesScreen extends StatelessWidget {
  const MinistereHistoriqueResponsablesScreen({required this.ministereId, super.key});

  final String ministereId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MinistereController>();
    final fideleController = context.watch<FideleController>();
    final ministere = controller.findById(ministereId);

    return Scaffold(
      appBar: AppBar(title: Text('Historique des responsables — ${ministere?.nom ?? ministereId}')),
      body: StreamBuilder<List<MandatResponsable>>(
        stream: controller.watchMandats(ministereId),
        builder: (context, snapshot) {
          final mandats = snapshot.data ?? const <MandatResponsable>[];
          if (mandats.isEmpty) {
            return const Center(child: Text('Aucun mandat de responsable enregistré.'));
          }
          return ListView.builder(
            itemCount: mandats.length,
            itemBuilder: (context, index) {
              final mandat = mandats[index];
              final fidele = fideleController.findById(mandat.fideleId);
              final debut = mandat.dateDebut.toIso8601String().split('T').first;
              final fin = mandat.dateFinReelle?.toIso8601String().split('T').first;
              return ListTile(
                leading: Icon(mandat.estActif ? Icons.check_circle_outline : Icons.history),
                title: Text(fidele?.nomComplet ?? mandat.fideleId),
                subtitle: Text(mandat.estActif ? 'En fonction depuis le $debut' : 'Du $debut au $fin'),
              );
            },
          );
        },
      ),
    );
  }
}
