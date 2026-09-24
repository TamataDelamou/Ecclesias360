import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../parametres/application/capacites_controller.dart';
import '../application/organisation_controller.dart';
import '../domain/models/organisation_node.dart';
import '../domain/models/type_noeud.dart';
import '../domain/rules/organisation_acces_rules.dart';
import 'acces_organisation.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final role = context.watch<SessionController>().role;
    final sonEglise = noeudDuConsultant(context);
    // RG-SEC-04/05 : l'arbre complet au rang de gestion ; en dessous, sa seule
    // église (policy `organisation_nodes`), jamais ses nœuds enfants ; rien
    // pour un utilisateur simple (RG-SEC-06bis).
    final voitTout = OrganisationAccesRules.voitToutLArbre(role);
    bool visible(OrganisationNode n) =>
        OrganisationAccesRules.peutConsulterNoeud(role: role, noeudId: n.id, noeudDuConsultant: sonEglise);
    final racines = voitTout ? controller.enfantsDe(null) : const <OrganisationNode>[];
    final eglisePropre = voitTout || sonEglise == null ? null : controller.findById(sonEglise);
    final resultatsRecherche =
        _terme.isEmpty ? null : controller.rechercher(_terme).where(visible).toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation'),
        actions: [
          if (capaciteAccordee(context, Capacites.consulterAnnuaireEglises))
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
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
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
                : eglisePropre != null
                    ? ListView(
                        children: [
                          ListTile(
                            title: Text(eglisePropre.nom),
                            subtitle: Text(eglisePropre.codeInterne),
                            onTap: () => context.push(AppRoutes.organisationNoeud(eglisePropre.id)),
                          ),
                        ],
                      )
                    : !voitTout
                    ? Center(child: Text(l10n.organisationAccesReserve))
                    : racines.isEmpty
                    ? const Center(child: Text('Aucun nœud — créez la racine (siège).'))
                    : ListView(
                        children: racines.map((noeud) => _NodeTile(node: noeud)).toList(),
                      ),
          ),
        ],
      ),
      // La racine (siège) est un nœud de niveau supérieur (RG-I-03).
      floatingActionButton: peutCreerOuValiderType(context, TypeNoeud.siege)
          ? FloatingActionButton(
              onPressed: () => context.push(AppRoutes.organisationNouveauNoeud),
              tooltip: 'Créer un nœud',
              child: const Icon(Icons.add),
            )
          : null,
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
        contentPadding: EdgeInsets.only(
          left: AppDimensions.spacingLg + node.depth * AppDimensions.treeIndentPerDepth,
          right: AppDimensions.spacingLg,
        ),
        title: Text(node.nom),
        subtitle: Text(node.codeInterne),
        onTap: () => context.push(AppRoutes.organisationNoeud(node.id)),
      );
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(
          left: AppDimensions.spacingLg + node.depth * AppDimensions.treeIndentPerDepth,
          right: AppDimensions.spacingLg,
        ),
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
