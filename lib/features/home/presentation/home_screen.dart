import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';

/// Écran d'accueil — tableau de bord (reprend la composition de la
/// maquette `dashboard_screen.dart` : en-tête de bienvenue puis grille de
/// tuiles de modules), limité aux destinations réelles sans paramètre
/// requis. Les modules imbriqués (Comité, Ministères, Dons d'un fidèle...)
/// se rejoignent depuis leur écran parent (Organisation, fiche fidèle) et
/// n'ont donc pas leur place ici.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final modules = <_Module>[
      _Module(l10n.moduleOrganisation, Icons.account_tree_outlined, AppRoutes.organisation),
      _Module(l10n.fidelesTitre, Icons.people_outline, AppRoutes.fideles),
      _Module(l10n.moduleZonesGeographiques, Icons.public_outlined, AppRoutes.zonesGeographiques),
      _Module(l10n.moduleRoles, Icons.admin_panel_settings_outlined, AppRoutes.roles),
      _Module(l10n.moduleMandatsEcheance, Icons.event_available_outlined, AppRoutes.mandatsEcheance),
      _Module(l10n.moduleDonsReferentiel, Icons.auto_awesome_outlined, AppRoutes.donsReferentiel),
      _Module(l10n.moduleProfessions, Icons.work_outline, AppRoutes.professions),
      _Module(l10n.moduleGroupesEglise, Icons.groups_2_outlined, AppRoutes.groupesEglise),
      _Module(l10n.propositionsThemeTitre, Icons.forum_outlined, AppRoutes.propositionsTheme),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          Text(l10n.homeWelcome, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppDimensions.spacingXl),
          Text(l10n.dashboardModulesTitre, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppDimensions.spacingMd),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: modules.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppDimensions.spacingMd,
              crossAxisSpacing: AppDimensions.spacingMd,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) => _ModuleTile(module: modules[index]),
          ),
        ],
      ),
    );
  }
}

class _Module {
  const _Module(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.module});

  final _Module module;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        onTap: () => context.push(module.route),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacingSm),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Icon(module.icon, color: colorScheme.primary),
              ),
              const SizedBox(height: AppDimensions.spacingSm),
              Text(
                module.label,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
