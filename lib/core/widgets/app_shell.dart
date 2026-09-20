import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';
import '../../l10n/app_localizations.dart';

/// Coquille de navigation principale — reprend la disposition de la
/// maquette (`dashboard_screen.dart` : barre de navigation basse) pour les
/// destinations globales sans paramètre requis. Les écrans imbriqués
/// (fiche fidèle, détail de nœud, séance de comité...) restent en
/// navigation empilée (`context.push`) hors de cette coquille — seuls les
/// 4 écrans racines y apparaissent (voir `core/router/app_router.dart`).
class AppShell extends StatelessWidget {
  const AppShell({required this.child, required this.location, super.key});

  final Widget child;
  final String location;

  static const _destinations = [
    _Destination(route: AppRoutes.home, icon: Icons.home_outlined, selectedIcon: Icons.home),
    _Destination(
      route: AppRoutes.organisation,
      icon: Icons.account_tree_outlined,
      selectedIcon: Icons.account_tree,
    ),
    _Destination(route: AppRoutes.fideles, icon: Icons.people_outline, selectedIcon: Icons.people),
    _Destination(
      route: AppRoutes.parametres,
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  int get _indexActif {
    for (var i = _destinations.length - 1; i >= 0; i--) {
      final route = _destinations[i].route;
      if (route == AppRoutes.home ? location == route : location.startsWith(route)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = [l10n.navAccueil, l10n.moduleOrganisation, l10n.fidelesTitre, l10n.parametresTitre];

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexActif,
        onDestinationSelected: (index) {
          if (index == _indexActif) return;
          context.go(_destinations[index].route);
        },
        destinations: [
          for (var i = 0; i < _destinations.length; i++)
            NavigationDestination(
              icon: Icon(_destinations[i].icon),
              selectedIcon: Icon(_destinations[i].selectedIcon),
              label: labels[i],
            ),
        ],
      ),
    );
  }
}

class _Destination {
  const _Destination({required this.route, required this.icon, required this.selectedIcon});

  final String route;
  final IconData icon;
  final IconData selectedIcon;
}
