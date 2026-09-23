import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../domain/models/role.dart';
import 'role_libelle.dart';

/// Écran Paramètres — point d'entrée du 4e onglet de la navigation
/// principale (voir `core/widgets/app_shell.dart`). Regroupe les réglages
/// déjà livrés (Module XXIII) ; à étoffer au fil des modules (profil,
/// préférences RG-II-10, sélecteur de thème non tranché — voir AGENTS.md).
class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();
    final compte = session.session;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.parametresTitre)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          if (compte != null)
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_circle_outlined),
                    title: Text(l10n.authCompteConnecte(compte.identifiant)),
                    subtitle: Text(libelleRole(l10n, compte.role)),
                  ),
                  if (session.peut(Role.administrateur)) ...[
                    const Divider(height: AppDimensions.dividerHairline),
                    ListTile(
                      leading: const Icon(Icons.link_outlined),
                      title: Text(l10n.authLiaisonsTitre),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(AppRoutes.liaisonsComptes),
                    ),
                  ],
                  const Divider(height: AppDimensions.dividerHairline),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(l10n.authDeconnexion),
                    onTap: session.enCours ? null : session.deconnecter,
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppDimensions.spacingLg),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.public_outlined),
                  title: Text(l10n.moduleZonesGeographiques),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.zonesGeographiques),
                ),
                const Divider(height: AppDimensions.dividerHairline),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined),
                  title: Text(l10n.moduleRoles),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.roles),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
