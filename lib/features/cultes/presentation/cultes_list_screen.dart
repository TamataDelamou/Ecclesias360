import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../application/culte_controller.dart';
import '../domain/models/culte.dart';

/// Écrans « Liste des cultes » + « Cultes récurrents » (RG-XII-01/05),
/// scopés par nœud — point d'entrée vers la fiche détaillée d'un culte.
class CultesListScreen extends StatelessWidget {
  const CultesListScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CulteController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cultesTitre)),
      body: StreamBuilder<List<Culte>>(
        stream: controller.watchCultes(noeudId),
        builder: (context, snapshot) {
          final cultes = snapshot.data ?? const <Culte>[];
          if (cultes.isEmpty) {
            return Center(child: Text(l10n.cultesAucun));
          }
          return ListView.builder(
            itemCount: cultes.length,
            itemBuilder: (context, index) {
              final culte = cultes[index];
              return ListTile(
                title: Text(culte.theme?.trim().isNotEmpty == true ? culte.theme! : culte.typeCulte),
                subtitle: Text(
                  '${culte.typeCulte} · ${culte.dateHeure.toIso8601String().split('T').first}',
                ),
                trailing: Chip(label: Text(culte.statut.code)),
                onTap: () => context.push(AppRoutes.culte(culte.id)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.cultesNouveau(noeudId)),
        tooltip: l10n.cultesNouveauTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
