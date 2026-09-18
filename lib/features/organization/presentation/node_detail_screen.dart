import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/organisation_controller.dart';
import '../domain/models/statut_noeud.dart';

/// Écran 2 (Fiche d'un nœud) + écran 8 (Statistiques rapides du nœud).
class NodeDetailScreen extends StatelessWidget {
  const NodeDetailScreen({required this.nodeId, super.key});

  final String nodeId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrganisationController>();
    final noeud = controller.findById(nodeId);

    if (noeud == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nœud introuvable')),
        body: const Center(child: Text("Ce nœud n'existe pas (ou plus).")),
      );
    }

    final enfants = controller.enfantsDe(noeud.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(noeud.nom),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Historique des rattachements',
            onPressed: () => context.push(AppRoutes.organisationHistorique(noeud.id)),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Modifier',
            onPressed: () => context.push(AppRoutes.organisationModifierNoeud(noeud.id)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LigneInfo(label: 'Type', valeur: noeud.typeNoeud.code),
          _LigneInfo(label: 'Code interne', valeur: noeud.codeInterne),
          _LigneInfo(label: 'Statut', valeur: noeud.statut.code),
          if (noeud.categorieConfessionnelle != null)
            _LigneInfo(label: 'Catégorie confessionnelle', valeur: noeud.categorieConfessionnelle!.code),
          if (noeud.dateFondation != null)
            _LigneInfo(label: 'Date de fondation', valeur: noeud.dateFondation!.toIso8601String().split('T').first),
          const Divider(height: 32),
          Text('Statistiques rapides', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _LigneInfo(label: 'Profondeur dans la hiérarchie', valeur: noeud.depth.toString()),
          _LigneInfo(label: 'Nœuds enfants directs', valeur: enfants.length.toString()),
          const Divider(height: 32),
          if (noeud.statut == StatutNoeud.provisoire)
            FilledButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Valider ce nœud (le faire passer au statut actif)'),
              onPressed: () => controller.validerNoeud(noeud.id),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.people_outline),
            label: const Text('Responsables'),
            onPressed: () => context.push(AppRoutes.organisationResponsables(noeud.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.groups_outlined),
            label: const Text('Ministères'),
            onPressed: () => context.push(AppRoutes.ministeresDuNoeud(noeud.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.auto_awesome_outlined),
            label: const Text('Statistiques des dons spirituels'),
            onPressed: () => context.push(AppRoutes.donsStatistiques(noeud.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Ajouter un nœud enfant'),
            onPressed: () => context.push(AppRoutes.organisationNouveauSousNoeud(noeud.id)),
          ),
          const SizedBox(height: 8),
          if (noeud.statut != StatutNoeud.archive)
            OutlinedButton.icon(
              icon: const Icon(Icons.archive_outlined),
              label: const Text('Archiver'),
              onPressed: () => controller.archiverNoeud(noeud.id),
            ),
          if (controller.erreur != null) ...[
            const SizedBox(height: 16),
            Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
    );
  }
}

class _LigneInfo extends StatelessWidget {
  const _LigneInfo({required this.label, required this.valeur});

  final String label;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 200, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}
