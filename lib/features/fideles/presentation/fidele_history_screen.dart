import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/fidele_controller.dart';
import '../domain/models/historique_fidele.dart';

/// Écran 6 (Historique des modifications, RG-II-05).
class FideleHistoryScreen extends StatelessWidget {
  const FideleHistoryScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FideleController>();
    final fidele = controller.findById(fideleId);

    return Scaffold(
      appBar: AppBar(title: Text('Historique — ${fidele?.nomComplet ?? fideleId}')),
      body: StreamBuilder<List<HistoriqueFidele>>(
        stream: controller.watchHistorique(fideleId),
        builder: (context, snapshot) {
          final entrees = snapshot.data ?? const <HistoriqueFidele>[];
          if (entrees.isEmpty) {
            return const Center(child: Text('Aucune modification historisée.'));
          }
          return ListView.separated(
            itemCount: entrees.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entree = entrees[index];
              return ListTile(
                title: Text('${entree.champModifie} : ${entree.ancienneValeur ?? '—'} → ${entree.nouvelleValeur ?? '—'}'),
                subtitle: Text(entree.date.toIso8601String()),
              );
            },
          );
        },
      ),
    );
  }
}
