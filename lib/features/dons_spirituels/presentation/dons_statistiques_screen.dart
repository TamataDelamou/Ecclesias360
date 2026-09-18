import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/don_spirituel_controller.dart';
import '../domain/models/don_fidele.dart';
import '../domain/rules/don_fidele_rules.dart';

/// Écran 6 (Statistiques de répartition, vue locale), RG-IV-01 — nombre de
/// fidèles du nœud dont l'évaluation courante concerne chaque don.
class DonsStatistiquesScreen extends StatelessWidget {
  const DonsStatistiquesScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final donController = context.watch<DonSpirituelController>();
    final fideleController = context.watch<FideleController>();
    final fideleIds = fideleController.fideles.where((f) => f.noeudId == noeudId).map((f) => f.id).toSet();
    final dons = donController.dons;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques de répartition des dons')),
      body: StreamBuilder<List<DonFidele>>(
        stream: donController.watchToutesEvaluations(),
        builder: (context, snapshot) {
          final evaluations = snapshot.data ?? const <DonFidele>[];
          final repartition = DonFideleRules.repartitionParDon(evaluations, fideleIds: fideleIds);
          return ListView.builder(
            itemCount: dons.length,
            itemBuilder: (context, index) {
              final don = dons[index];
              return ListTile(
                title: Text(don.libelle),
                trailing: Text('${repartition[don.id] ?? 0}'),
              );
            },
          );
        },
      ),
    );
  }
}
