import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/finances_controller.dart';
import '../domain/models/tresorier_noeud.dart';

/// Gestion des trésoriers désignés d'un nœud (RG-XI-02) — table latérale
/// `TresorierNoeud`, l'énum `Role` (Module XXIII) n'ayant pas de valeur
/// « trésorier ». Même motif d'écran que `MembresComiteScreen` (Module VII).
class TresoriersNoeudScreen extends StatelessWidget {
  const TresoriersNoeudScreen({required this.noeudId, super.key});

  final String noeudId;

  Future<void> _designer(BuildContext context, FinancesController controller, FideleController fideleController) async {
    final fideles = fideleController.fideles.where((f) => f.noeudId == noeudId).toList();
    if (fideles.isEmpty) return;

    String fideleId = fideles.first.id;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.financesTresorierDesignerTitre),
            content: DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: fideleId,
              decoration: InputDecoration(labelText: l10n.commonFidele),
              items: fideles.map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet))).toList(),
              onChanged: (valeur) => setState(() => fideleId = valeur ?? fideleId),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.financesTresorierDesignerBouton)),
            ],
          ),
        );
      },
    );

    if (confirme == true) {
      await controller.designerTresorier(fideleId: fideleId, noeudId: noeudId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FinancesController>();
    final fideleController = context.watch<FideleController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financesTresoriersTitre)),
      body: StreamBuilder<List<TresorierNoeud>>(
        stream: controller.watchTresoriers(noeudId),
        builder: (context, snapshot) {
          final tresoriers = snapshot.data ?? const <TresorierNoeud>[];
          if (tresoriers.isEmpty) {
            return Center(child: Text(l10n.financesTresoriersAucun));
          }
          return ListView.builder(
            itemCount: tresoriers.length,
            itemBuilder: (context, index) {
              final tresorier = tresoriers[index];
              final fidele = fideleController.findById(tresorier.fideleId);
              return ListTile(
                title: Text(fidele?.nomComplet ?? tresorier.fideleId),
                subtitle: Text(l10n.financesTresorierDepuis(tresorier.dateDebut.toIso8601String().split('T').first)),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: l10n.financesTresorierRetirerTooltip,
                  onPressed: () => controller.retirerTresorier(tresorier.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _designer(context, controller, fideleController),
        tooltip: l10n.financesTresorierDesignerTooltip,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
