import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/don_spirituel_controller.dart';

/// Écran 3 (Référentiel des neuf dons), RG-IV-04 — fixe, non modifiable
/// dans cette itération.
class DonsReferentielScreen extends StatelessWidget {
  const DonsReferentielScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DonSpirituelController>();
    final dons = controller.dons;

    return Scaffold(
      appBar: AppBar(title: const Text('Référentiel des dons spirituels')),
      body: ListView.builder(
        itemCount: dons.length,
        itemBuilder: (context, index) {
          final don = dons[index];
          return ListTile(
            title: Text(don.libelle),
            subtitle: Text(don.descriptionBiblique),
          );
        },
      ),
    );
  }
}
