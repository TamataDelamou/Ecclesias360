import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../archivage/presentation/acces_archivage.dart';
import '../../auth/application/session_controller.dart';
import '../../discipline/presentation/acces_discipline.dart';
import '../../finances/presentation/acces_finances.dart';
import '../../patrimoine/presentation/acces_patrimoine.dart';
import '../application/organisation_controller.dart';
import '../domain/rules/organisation_acces_rules.dart';
import 'acces_organisation.dart';
import '../domain/models/statut_noeud.dart';

/// Écran 2 (Fiche d'un nœud) + écran 8 (Statistiques rapides du nœud).
class NodeDetailScreen extends StatelessWidget {
  const NodeDetailScreen({required this.nodeId, super.key});

  final String nodeId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrganisationController>();
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();

    // RG-SEC-04/05 : son église, ou le rang de gestion (miroir de la policy
    // `organisation_nodes`) — vérifié avant l'existence ; un accès direct par
    // route ne contourne pas l'arbre.
    if (!OrganisationAccesRules.peutConsulterNoeud(
      role: session.role,
      noeudId: nodeId,
      noeudDuConsultant: noeudDuConsultant(context),
    )) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.organisationTitre)),
        body: Center(child: Text(l10n.organisationAccesReserve)),
      );
    }

    final noeud = controller.findById(nodeId);
    if (noeud == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nœud introuvable')),
        body: const Center(child: Text("Ce nœud n'existe pas (ou plus).")),
      );
    }

    final enfants = controller.enfantsDe(noeud.id);
    final gestion = OrganisationAccesRules.peutGererNoeuds(session.role);

    return Scaffold(
      appBar: AppBar(
        title: Text(noeud.nom),
        actions: [
          if (gestion) ...[
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
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          _LigneInfo(label: 'Type', valeur: noeud.typeNoeud.code),
          _LigneInfo(label: 'Code interne', valeur: noeud.codeInterne),
          _LigneInfo(label: 'Statut', valeur: noeud.statut.code),
          if (noeud.categorieConfessionnelle != null)
            _LigneInfo(label: 'Catégorie confessionnelle', valeur: noeud.categorieConfessionnelle!.code),
          if (noeud.dateFondation != null)
            _LigneInfo(label: 'Date de fondation', valeur: noeud.dateFondation!.toIso8601String().split('T').first),
          const Divider(height: AppDimensions.spacingXxl),
          Text('Statistiques rapides', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppDimensions.spacingSm),
          _LigneInfo(label: 'Profondeur dans la hiérarchie', valeur: noeud.depth.toString()),
          _LigneInfo(label: 'Nœuds enfants directs', valeur: enfants.length.toString()),
          const Divider(height: AppDimensions.spacingXxl),
          // RG-I-03 : validation au même seuil que la création de ce type.
          if (noeud.statut == StatutNoeud.provisoire && peutCreerOuValiderType(context, noeud.typeNoeud))
            FilledButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Valider ce nœud (le faire passer au statut actif)'),
              onPressed: () => controller.validerNoeud(noeud.id),
            ),
          const SizedBox(height: AppDimensions.spacingSm),
          if (gestion) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.people_outline),
              label: const Text('Responsables'),
              onPressed: () => context.push(AppRoutes.organisationResponsables(noeud.id)),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
          ],
          OutlinedButton.icon(
            icon: const Icon(Icons.groups_outlined),
            label: const Text('Ministères'),
            onPressed: () => context.push(AppRoutes.ministeresDuNoeud(noeud.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.auto_awesome_outlined),
            label: const Text('Statistiques des dons spirituels'),
            onPressed: () => context.push(AppRoutes.donsStatistiques(noeud.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.gavel_outlined),
            label: const Text('Membres du comité'),
            onPressed: () => context.push(AppRoutes.comiteMembres(noeud.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.event_note_outlined),
            label: const Text('Séances du comité'),
            onPressed: () => context.push(AppRoutes.comiteSeances(noeud.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.church_outlined),
            label: const Text('Cultes'),
            onPressed: () => context.push(AppRoutes.cultes(noeud.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          // Archives : périmètre, approché localement par le rang responsable.
          if (peutOuvrirArchives(context.watch<SessionController>())) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.folder_open_outlined),
              label: Text(l10n.archivageBibliothequeTitre),
              onPressed: () => context.push(AppRoutes.documentsArchive(noeud.id)),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
          ],
          OutlinedButton.icon(
            icon: const Icon(Icons.swap_horiz_outlined),
            label: Text(l10n.deplacementsTitre),
            onPressed: () => context.push(AppRoutes.mutationsDuNoeud(noeud.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          // RG-X-05 : module réservé (pasteur ou plus, ou membre d'une commission).
          AccesDisciplineBuilder(
            builder: (context, acces) => !acces.aAcces
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: AppDimensions.spacingSm),
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.balance_outlined),
                      label: Text(l10n.disciplineTitre),
                      onPressed: () => context.push(AppRoutes.discipline(noeud.id)),
                    ),
                  ),
          ),
          // RG-SEC-06 : finances réservées (pasteur ou plus, trésorier du nœud ;
          // projets : rang responsable ou trésorier).
          AccesFinancesBuilder(
            builder: (context, acces) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (acces.peutGererContributions(noeud.id)) ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.volunteer_activism_outlined),
                    label: Text(l10n.financesTitre),
                    onPressed: () => context.push(AppRoutes.financesDuNoeud(noeud.id)),
                  ),
                  const SizedBox(height: AppDimensions.spacingSm),
                ],
                if (acces.peutGererProjets(noeud.id)) ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.savings_outlined),
                    label: Text(l10n.financesProjetsTitre),
                    onPressed: () => context.push(AppRoutes.projetsDuNoeud(noeud.id)),
                  ),
                  const SizedBox(height: AppDimensions.spacingSm),
                ],
                // Comptabilité (Module XXI) : pasteur ou plus, ou trésorier du nœud.
                if (acces.peutConsulterComptabilite(noeud.id)) ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.account_balance_outlined),
                    label: Text(l10n.comptabiliteTitre),
                    onPressed: () => context.push(AppRoutes.comptabiliteDuNoeud(noeud.id)),
                  ),
                  const SizedBox(height: AppDimensions.spacingSm),
                ],
              ],
            ),
          ),
          // Patrimoine : périmètre, approché localement par le rang responsable.
          if (peutGererBiens(context.watch<SessionController>())) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.inventory_2_outlined),
              label: Text(l10n.patrimoineTitre),
              onPressed: () => context.push(AppRoutes.biensDuNoeud(noeud.id)),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
          ],
          if (gestion) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un nœud enfant'),
              onPressed: () => context.push(AppRoutes.organisationNouveauSousNoeud(noeud.id)),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
          ],
          if (gestion && noeud.statut != StatutNoeud.archive)
            OutlinedButton.icon(
              icon: const Icon(Icons.archive_outlined),
              label: const Text('Archiver'),
              onPressed: () => controller.archiverNoeud(noeud.id),
            ),
          if (controller.erreur != null) ...[
            const SizedBox(height: AppDimensions.spacingLg),
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
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: AppDimensions.labelColumnWidth, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}
