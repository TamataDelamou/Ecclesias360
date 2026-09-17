import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/organisation_controller.dart';
import '../domain/models/organisation_node.dart';

/// Écran 1 (mobile) / Explorateur hiérarchique (Windows) — arbre navigable,
/// et écran 7 (Recherche de nœud) intégré via la barre de recherche.
class HierarchyScreen extends StatefulWidget {
  const HierarchyScreen({super.key});

  @override
  State<HierarchyScreen> createState() => _HierarchyScreenState();
}

class _HierarchyScreenState extends State<HierarchyScreen> {
  final TextEditingController _rechercheController = TextEditingController();
  String _terme = '';

  @override
  void dispose() {
    _rechercheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrganisationController>();
    final racines = controller.enfantsDe(null);
    final resultatsRecherche = _terme.isEmpty ? null : controller.rechercher(_terme);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.church_outlined),
            tooltip: 'Annuaire des Églises',
            onPressed: () => context.push(AppRoutes.organisationAnnuaireEglises),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _rechercheController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Rechercher un nœud (nom ou code interne)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _terme = value),
            ),
          ),
          Expanded(
            child: resultatsRecherche != null
                ? _ListeResultatsRecherche(resultats: resultatsRecherche)
                : racines.isEmpty
                    ? const Center(child: Text('Aucun nœud — créez la racine (siège).'))
                    : ListView(
                        children: racines.map((noeud) => _NodeTile(node: noeud)).toList(),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.organisationNouveauNoeud),
        tooltip: 'Créer un nœud',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ListeResultatsRecherche extends StatelessWidget {
  const _ListeResultatsRecherche({required this.resultats});

  final List<OrganisationNode> resultats;

  @override
  Widget build(BuildContext context) {
    if (resultats.isEmpty) {
      return const Center(child: Text('Aucun résultat.'));
    }
    return ListView.builder(
      itemCount: resultats.length,
      itemBuilder: (context, index) {
        final noeud = resultats[index];
        return ListTile(
          title: Text(noeud.nom),
          subtitle: Text(noeud.codeInterne),
          onTap: () => context.push(AppRoutes.organisationNoeud(noeud.id)),
        );
      },
    );
  }
}

class _NodeTile extends StatelessWidget {
  const _NodeTile({required this.node});

  final OrganisationNode node;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrganisationController>();
    final enfants = controller.enfantsDe(node.id);

    if (enfants.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: 16.0 + node.depth * 16, right: 16),
        title: Text(node.nom),
        subtitle: Text(node.codeInterne),
        onTap: () => context.push(AppRoutes.organisationNoeud(node.id)),
      );
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 16.0 + node.depth * 16, right: 16),
      title: Text(node.nom),
      subtitle: Text(node.codeInterne),
      onExpansionChanged: (_) {},
      children: [
        ListTile(
          dense: true,
          leading: const Icon(Icons.open_in_new, size: 18),
          title: const Text('Voir la fiche'),
          onTap: () => context.push(AppRoutes.organisationNoeud(node.id)),
        ),
        ...enfants.map((enfant) => _NodeTile(node: enfant)),
      ],
    );
  }
}
