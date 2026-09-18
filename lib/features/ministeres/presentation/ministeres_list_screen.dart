import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../organization/application/organisation_controller.dart';
import '../application/ministere_controller.dart';
import '../domain/models/statut_ministere.dart';

/// Écran 1 (Liste des ministères d'un nœud), RG-III-01/04.
class MinisteresListScreen extends StatelessWidget {
  const MinisteresListScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MinistereController>();
    final organisationController = context.watch<OrganisationController>();
    final noeud = organisationController.findById(noeudId);
    final ministeres = controller.ministeresDuNoeud(noeudId);

    return Scaffold(
      appBar: AppBar(title: Text('Ministères — ${noeud?.nom ?? noeudId}')),
      body: ministeres.isEmpty
          ? const Center(child: Text('Aucun ministère créé pour ce nœud.'))
          : ListView.builder(
              itemCount: ministeres.length,
              itemBuilder: (context, index) {
                final ministere = ministeres[index];
                final type = controller.findTypeById(ministere.typeMinistereId);
                return ListTile(
                  title: Text(ministere.nom),
                  subtitle: Text(type?.libelle ?? ministere.typeMinistereId),
                  trailing: ministere.statut == StatutMinistere.actif
                      ? null
                      : Chip(label: Text(ministere.statut.code)),
                  onTap: () => context.push(AppRoutes.ministere(ministere.id)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.ministeresNouveau(noeudId)),
        tooltip: 'Créer un ministère',
        child: const Icon(Icons.add),
      ),
    );
  }
}
