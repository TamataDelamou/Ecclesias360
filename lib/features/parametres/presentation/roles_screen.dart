import 'package:flutter/material.dart';

import '../data/referential/roles_referential.dart';
import '../domain/models/role.dart';

/// Écran 4 mobile (Consultation des rôles, lecture seule). L'édition des
/// rôles et permissions (écran Windows 4) attend un concept de session/rôle
/// courant, non construit avant le déploiement de l'authentification
/// groupée (RG-SEC-01, voir AGENTS.md §10).
class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rôles')),
      body: FutureBuilder<RolesReferential>(
        future: RolesReferential.charger(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: Role.values
                .map(
                  (role) => ListTile(
                    leading: CircleAvatar(child: Text('${role.rang}')),
                    title: Text(role.code),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
