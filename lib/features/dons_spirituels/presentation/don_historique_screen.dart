import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/don_spirituel_controller.dart';
import '../domain/models/don_fidele.dart';

/// Écran 4 (Historique d'évolution d'un don), RG-IV-02 — l'historique
/// n'est jamais écrasé, seulement complété ; la ligne la plus récente est
/// l'évaluation courante.
class DonHistoriqueScreen extends StatelessWidget {
  const DonHistoriqueScreen({required this.fideleId, required this.donId, super.key});

  final String fideleId;
  final String donId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DonSpirituelController>();
    final fideleController = context.watch<FideleController>();
    final don = controller.findById(donId);

    return Scaffold(
      appBar: AppBar(title: Text(don?.libelle ?? donId)),
      body: StreamBuilder<List<DonFidele>>(
        stream: controller.watchEvaluations(fideleId),
        builder: (context, snapshot) {
          final evaluations =
              (snapshot.data ?? const <DonFidele>[]).where((e) => e.donId == donId).toList();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.rate_review_outlined),
                        label: const Text('Nouvelle évaluation'),
                        onPressed: () => context.push(AppRoutes.donEvaluer(fideleId, donId)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.groups_outlined),
                      label: const Text('Suggestions'),
                      onPressed: () => context.push(AppRoutes.donMinisteresCompatibles(fideleId, donId)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: evaluations.isEmpty
                    ? const Center(child: Text('Aucune évaluation enregistrée.'))
                    : ListView.builder(
                        itemCount: evaluations.length,
                        itemBuilder: (context, index) {
                          final evaluation = evaluations[index];
                          final responsable = fideleController.findById(evaluation.responsableSuiviId);
                          return ListTile(
                            title: Text(evaluation.niveauMaturite.code),
                            subtitle: Text(
                              'Par ${responsable?.nomComplet ?? evaluation.responsableSuiviId} le '
                              '${evaluation.dateEvaluation.toIso8601String().split('T').first}'
                              '${evaluation.observations != null ? ' · ${evaluation.observations}' : ''}',
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
