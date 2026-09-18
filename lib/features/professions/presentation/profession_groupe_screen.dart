import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/profession_controller.dart';
import '../domain/models/profession_fidele.dart';
import '../domain/models/statut_verification.dart';

/// Fiche d'un groupe professionnel (écran 1) + écran 5 (Sollicitation d'un
/// groupe), RG-V-01/03 — seuls les fidèles à déclaration vérifiée sont
/// sollicités.
class ProfessionGroupeScreen extends StatelessWidget {
  const ProfessionGroupeScreen({required this.professionId, super.key});

  final String professionId;

  Future<void> _solliciter(BuildContext context, ProfessionController controller) async {
    final objetController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Solliciter ce groupe'),
        content: TextField(
          controller: objetController,
          decoration: const InputDecoration(labelText: 'Objet de la sollicitation'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Solliciter')),
        ],
      ),
    );

    if (confirme == true && objetController.text.trim().isNotEmpty) {
      await controller.solliciterGroupe(professionId: professionId, objet: objetController.text.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sollicitation envoyée aux fidèles à déclaration vérifiée.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProfessionController>();
    final fideleController = context.watch<FideleController>();
    final profession = controller.findById(professionId);

    return Scaffold(
      appBar: AppBar(title: Text(profession?.libelle ?? professionId)),
      body: StreamBuilder<List<ProfessionFidele>>(
        stream: controller.watchDeclarationsParProfession(professionId),
        builder: (context, snapshot) {
          final declarations = snapshot.data ?? const <ProfessionFidele>[];
          if (declarations.isEmpty) {
            return const Center(child: Text('Aucun fidèle n\'a déclaré ce métier.'));
          }
          return ListView.builder(
            itemCount: declarations.length,
            itemBuilder: (context, index) {
              final declaration = declarations[index];
              final fidele = fideleController.findById(declaration.fideleId);
              return ListTile(
                title: Text(fidele?.nomComplet ?? declaration.fideleId),
                subtitle: Text(
                  declaration.statutVerification == StatutVerification.verifie
                      ? 'Vérifié'
                      : 'Déclaré (non vérifié)',
                ),
                trailing: declaration.anneesExperience != null
                    ? Text('${declaration.anneesExperience} ans')
                    : null,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _solliciter(context, controller),
        icon: const Icon(Icons.campaign_outlined),
        label: const Text('Solliciter ce groupe'),
      ),
    );
  }
}
