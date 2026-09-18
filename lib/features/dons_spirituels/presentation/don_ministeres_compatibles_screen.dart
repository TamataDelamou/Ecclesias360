import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ministeres/application/ministere_controller.dart';
import '../application/don_spirituel_controller.dart';
import '../domain/models/don_ministere_compatible.dart';

/// Écran 5 (Suggestions de ministères compatibles), RG-IV-03 — suggestion
/// uniquement, jamais d'affectation automatique : la validation humaine se
/// fait depuis le Module III. Aucune correspondance n'est pré-remplie
/// (jugement pastoral, hors périmètre technique) ; l'écran reflète la table
/// de correspondance telle qu'administrée.
class DonMinisteresCompatiblesScreen extends StatelessWidget {
  const DonMinisteresCompatiblesScreen({required this.fideleId, required this.donId, super.key});

  final String fideleId;
  final String donId;

  @override
  Widget build(BuildContext context) {
    final donController = context.watch<DonSpirituelController>();
    final ministereController = context.watch<MinistereController>();
    final don = donController.findById(donId);

    return Scaffold(
      appBar: AppBar(title: Text('Ministères compatibles — ${don?.libelle ?? donId}')),
      body: StreamBuilder<List<DonMinistereCompatible>>(
        stream: donController.watchCorrespondances(donId),
        builder: (context, snapshot) {
          final correspondances = snapshot.data ?? const <DonMinistereCompatible>[];
          if (correspondances.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aucune correspondance configurée pour ce don. '
                  "L'affectation à un ministère reste possible manuellement depuis le module Ministères.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: correspondances.length,
            itemBuilder: (context, index) {
              final type = ministereController.findTypeById(correspondances[index].typeMinistereId);
              return ListTile(
                leading: const Icon(Icons.groups_outlined),
                title: Text(type?.libelle ?? correspondances[index].typeMinistereId),
              );
            },
          );
        },
      ),
    );
  }
}
