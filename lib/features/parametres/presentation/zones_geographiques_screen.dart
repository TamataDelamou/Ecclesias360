import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/zone_geographique_controller.dart';
import '../domain/models/statut_referentiel.dart';

/// Gestion des référentiels — zones géographiques (Module XXIII,
/// RG-XXIII-01/03). Écran Windows 3 (référentiels) réduit à ce seul
/// référentiel pour cette première itération.
class ZonesGeographiquesScreen extends StatelessWidget {
  const ZonesGeographiquesScreen({super.key});

  Future<void> _creerZone(BuildContext context, ZoneGeographiqueController controller) async {
    final libelleController = TextEditingController();
    String? parentId;
    final zonesActives = controller.zones.where((z) => z.statut == StatutReferentiel.actif).toList();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Créer une zone géographique'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: libelleController, decoration: const InputDecoration(labelText: 'Libellé')),
              DropdownButtonFormField<String?>(
                initialValue: parentId,
                decoration: const InputDecoration(labelText: 'Zone parente (optionnel)'),
                items: [
                  const DropdownMenuItem<String?>(value: null, child: Text('Aucune (racine)')),
                  ...zonesActives.map((z) => DropdownMenuItem(value: z.id, child: Text(z.libelle))),
                ],
                onChanged: (valeur) => setState(() => parentId = valeur),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Créer')),
          ],
        ),
      ),
    );

    if (confirme == true && libelleController.text.trim().isNotEmpty) {
      await controller.creer(libelle: libelleController.text.trim(), parentId: parentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ZoneGeographiqueController>();
    final zones = controller.zones;

    return Scaffold(
      appBar: AppBar(title: const Text('Zones géographiques')),
      body: zones.isEmpty
          ? const Center(child: Text('Aucune zone géographique enregistrée.'))
          : ListView.builder(
              itemCount: zones.length,
              itemBuilder: (context, index) {
                final zone = zones[index];
                final parent = zone.parentId == null ? null : controller.findById(zone.parentId!);
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 16.0 + zone.niveau * 16, right: 16),
                  title: Text(zone.libelle),
                  subtitle: Text(
                    [
                      if (parent != null) 'sous ${parent.libelle}',
                      zone.statut.code,
                    ].join(' · '),
                  ),
                  trailing: zone.statut == StatutReferentiel.actif
                      ? IconButton(
                          icon: const Icon(Icons.archive_outlined),
                          tooltip: 'Désactiver (RG-XXIII-03)',
                          onPressed: () => controller.desactiver(zone.id),
                        )
                      : null,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _creerZone(context, controller),
        tooltip: 'Créer une zone',
        child: const Icon(Icons.add),
      ),
    );
  }
}
