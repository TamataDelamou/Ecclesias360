import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/don_spirituel_controller.dart';
import '../domain/models/don_fidele.dart';
import '../domain/rules/don_fidele_rules.dart';

/// Écran 1 (Liste des dons d'un fidèle), RG-IV-01 — un des neuf dons par
/// ligne, avec sa dernière évaluation si elle existe.
class DonsFideleListScreen extends StatelessWidget {
  const DonsFideleListScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DonSpirituelController>();
    final fideleController = context.watch<FideleController>();
    final fidele = fideleController.findById(fideleId);
    final dons = controller.dons;

    return Scaffold(
      appBar: AppBar(title: Text('Dons spirituels — ${fidele?.nomComplet ?? fideleId}')),
      body: StreamBuilder<List<DonFidele>>(
        stream: controller.watchEvaluations(fideleId),
        builder: (context, snapshot) {
          final evaluations = snapshot.data ?? const <DonFidele>[];
          return ListView.builder(
            itemCount: dons.length,
            itemBuilder: (context, index) {
              final don = dons[index];
              final evaluationsDuDon = evaluations.where((e) => e.donId == don.id).toList();
              final courante = DonFideleRules.evaluationCourante(evaluationsDuDon);
              return ListTile(
                title: Text(don.libelle),
                subtitle: Text(courante == null ? 'Non évalué' : courante.niveauMaturite.code),
                onTap: () => context.push(AppRoutes.donHistorique(fideleId, don.id)),
              );
            },
          );
        },
      ),
    );
  }
}
