import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/groupe_controller.dart';
import '../domain/models/type_regle_groupe.dart';

/// Écran 1 (Liste des groupes), RG-VI-01.
class GroupesEgliseListScreen extends StatelessWidget {
  const GroupesEgliseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GroupeController>();
    final groupes = controller.groupes;

    return Scaffold(
      appBar: AppBar(title: const Text('Groupes de l\'Église')),
      body: ListView.builder(
        itemCount: groupes.length,
        itemBuilder: (context, index) {
          final groupe = groupes[index];
          return ListTile(
            title: Text(groupe.libelle),
            trailing: Chip(
              label: Text(groupe.typeRegle == TypeRegleGroupe.auto ? 'Automatique' : 'Manuel'),
            ),
            onTap: () => context.push(AppRoutes.groupeMembres(groupe.id)),
          );
        },
      ),
    );
  }
}
