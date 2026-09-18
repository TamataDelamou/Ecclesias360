import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/profession_controller.dart';
import '../domain/models/profession_fidele.dart';
import '../domain/models/sollicitation.dart';
import '../domain/models/statut_verification.dart';

/// Écran 2 (Fiche compétence d'un fidèle) + écran 3 (Déclaration d'une
/// profession) + réponse aux sollicitations reçues (RG-V-01/03).
class FideleCompetencesScreen extends StatelessWidget {
  const FideleCompetencesScreen({required this.fideleId, super.key});

  final String fideleId;

  Future<void> _declarer(BuildContext context, ProfessionController controller) async {
    final professions = controller.professions;
    if (professions.isEmpty) return;

    String professionId = professions.first.id;
    final anneesController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Déclarer une profession'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: professionId,
                decoration: const InputDecoration(labelText: 'Métier'),
                items: professions
                    .map((p) => DropdownMenuItem(value: p.id, child: Text(p.libelle)))
                    .toList(),
                onChanged: (valeur) => setState(() => professionId = valeur ?? professionId),
              ),
              TextField(
                controller: anneesController,
                decoration: const InputDecoration(labelText: "Années d'expérience"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Déclarer')),
          ],
        ),
      ),
    );

    if (confirme == true) {
      await controller.declarerProfession(
        fideleId: fideleId,
        professionId: professionId,
        anneesExperience: int.tryParse(anneesController.text.trim()),
      );
    }
  }

  Future<void> _repondre(BuildContext context, ProfessionController controller, String sollicitationId) async {
    final reponseController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Répondre à la sollicitation'),
        content: TextField(controller: reponseController, decoration: const InputDecoration(labelText: 'Réponse')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Envoyer')),
        ],
      ),
    );
    if (confirme == true && reponseController.text.trim().isNotEmpty) {
      await controller.repondreSollicitation(sollicitationId, reponseController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProfessionController>();
    final fideleController = context.watch<FideleController>();
    final fidele = fideleController.findById(fideleId);

    return Scaffold(
      appBar: AppBar(title: Text('Compétences — ${fidele?.nomComplet ?? fideleId}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Professions déclarées', style: Theme.of(context).textTheme.titleMedium),
          StreamBuilder<List<ProfessionFidele>>(
            stream: controller.watchDeclarations(fideleId),
            builder: (context, snapshot) {
              final declarations = snapshot.data ?? const <ProfessionFidele>[];
              if (declarations.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Aucune profession déclarée.'),
                );
              }
              return Column(
                children: [
                  for (final declaration in declarations)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(controller.findById(declaration.professionId)?.libelle ?? declaration.professionId),
                      subtitle: Text(
                        declaration.statutVerification == StatutVerification.verifie
                            ? 'Vérifié'
                            : 'Déclaré (non vérifié)',
                      ),
                      trailing: declaration.statutVerification == StatutVerification.declare
                          ? TextButton(
                              onPressed: () => controller.verifierDeclaration(declaration.id),
                              child: const Text('Vérifier'),
                            )
                          : null,
                    ),
                ],
              );
            },
          ),
          TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Déclarer une profession'),
            onPressed: () => _declarer(context, controller),
          ),
          const Divider(height: 32),
          Text('Sollicitations reçues', style: Theme.of(context).textTheme.titleMedium),
          StreamBuilder<List<Sollicitation>>(
            stream: controller.watchSollicitations(fideleId),
            builder: (context, snapshot) {
              final sollicitations = snapshot.data ?? const <Sollicitation>[];
              if (sollicitations.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Aucune sollicitation reçue.'),
                );
              }
              return Column(
                children: [
                  for (final sollicitation in sollicitations)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(sollicitation.objet),
                      subtitle: Text(sollicitation.reponse ?? 'En attente de réponse'),
                      trailing: sollicitation.reponse == null
                          ? TextButton(
                              onPressed: () => _repondre(context, controller, sollicitation.id),
                              child: const Text('Répondre'),
                            )
                          : null,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
