import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.homeWelcome),
            const SizedBox(height: AppDimensions.spacingLg),
            FilledButton(
              onPressed: () => context.push(AppRoutes.organisation),
              child: const Text('Organisation'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.fideles),
              child: const Text('Fidèles'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.zonesGeographiques),
              child: const Text('Zones géographiques'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.roles),
              child: const Text('Rôles'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.mandatsEcheance),
              child: const Text('Mandats arrivant à échéance'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.donsReferentiel),
              child: const Text('Référentiel des dons spirituels'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.professions),
              child: const Text('Groupes professionnels'),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            FilledButton(
              onPressed: () => context.push(AppRoutes.groupesEglise),
              child: const Text('Groupes de l\'Église'),
            ),
          ],
        ),
      ),
    );
  }
}
