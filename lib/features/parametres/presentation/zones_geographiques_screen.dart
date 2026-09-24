import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/zone_geographique_controller.dart';
import '../domain/models/statut_referentiel.dart';

/// Gestion des référentiels — zones géographiques (Module XXIII,
/// RG-XXIII-01/03/06). Écran Windows 3 (référentiels) réduit à ce seul
/// référentiel pour cette première itération. Réservé à l'administrateur
/// (garde du routeur) ; l'auteur de chaque modification est la session,
/// historisée par le dépôt.
class ZonesGeographiquesScreen extends StatelessWidget {
  const ZonesGeographiquesScreen({super.key});

  Future<void> _creerZone(BuildContext context, ZoneGeographiqueController controller) async {
    final acteur = context.read<SessionController>().acteur;
    final libelleController = TextEditingController();
    String? parentId;
    final zonesActives = controller.zones.where((z) => z.statut == StatutReferentiel.actif).toList();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.zonesCreerTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: libelleController,
                  decoration: InputDecoration(labelText: l10n.zonesChampLibelle),
                ),
                DropdownButtonFormField<String?>(
                  initialValue: parentId,
                  decoration: InputDecoration(labelText: l10n.zonesChampParent),
                  items: [
                    DropdownMenuItem<String?>(value: null, child: Text(l10n.zonesAucuneParente)),
                    ...zonesActives.map((z) => DropdownMenuItem(value: z.id, child: Text(z.libelle))),
                  ],
                  onChanged: (valeur) => setState(() => parentId = valeur),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonCreer)),
            ],
          ),
        );
      },
    );

    if (confirme == true && acteur != null && libelleController.text.trim().isNotEmpty) {
      await controller.creer(libelle: libelleController.text.trim(), parentId: parentId, acteur: acteur);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ZoneGeographiqueController>();
    final acteur = context.watch<SessionController>().acteur;
    final l10n = AppLocalizations.of(context)!;
    final zones = controller.zones;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.moduleZonesGeographiques)),
      body: zones.isEmpty
          ? Center(child: Text(l10n.zonesAucune))
          : ListView.builder(
              itemCount: zones.length,
              itemBuilder: (context, index) {
                final zone = zones[index];
                final parent = zone.parentId == null ? null : controller.findById(zone.parentId!);
                return ListTile(
                  contentPadding: EdgeInsets.only(
                    left: AppDimensions.spacingLg + zone.niveau * AppDimensions.spacingLg,
                    right: AppDimensions.spacingLg,
                  ),
                  title: Text(zone.libelle),
                  subtitle: Text(
                    [if (parent != null) l10n.zonesSousParent(parent.libelle), zone.statut.code].join(' · '),
                  ),
                  trailing: zone.statut == StatutReferentiel.actif && acteur != null
                      ? IconButton(
                          icon: const Icon(Icons.archive_outlined),
                          tooltip: l10n.zonesDesactiver,
                          onPressed: () => controller.desactiver(zone.id, acteur: acteur),
                        )
                      : null,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _creerZone(context, controller),
        tooltip: l10n.zonesCreerAction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
