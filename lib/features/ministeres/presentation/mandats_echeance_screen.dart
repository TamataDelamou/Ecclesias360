import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/ministere_controller.dart';
import '../domain/models/mandat_responsable.dart';

/// Écran 9 (Suivi des mandats arrivant à échéance), RG-III-02 — tous
/// ministères confondus, horizon de 30 jours.
class MandatsEcheanceScreen extends StatelessWidget {
  const MandatsEcheanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MinistereController>();
    final fideleController = context.watch<FideleController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mandats arrivant à échéance')),
      body: FutureBuilder<List<MandatResponsable>>(
        future: controller.mandatsArrivantAEcheance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final mandats = snapshot.data!;
          if (mandats.isEmpty) {
            return const Center(child: Text('Aucun mandat proche de son échéance.'));
          }
          return ListView.builder(
            itemCount: mandats.length,
            itemBuilder: (context, index) {
              final mandat = mandats[index];
              final fidele = fideleController.findById(mandat.fideleId);
              final ministere = controller.findById(mandat.ministereId);
              final echeance = mandat.dateFinPrevue?.toIso8601String().split('T').first ?? '—';
              return ListTile(
                leading: const Icon(Icons.warning_amber_outlined),
                title: Text(fidele?.nomComplet ?? mandat.fideleId),
                subtitle: Text('${ministere?.nom ?? mandat.ministereId} · échéance le $echeance'),
              );
            },
          );
        },
      ),
    );
  }
}
