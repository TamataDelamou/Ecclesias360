import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/ministere_controller.dart';
import '../domain/models/statut_ministere.dart';

/// Écran 2 (Fiche ministère), RG-III-01/04/05.
class MinistereDetailScreen extends StatelessWidget {
  const MinistereDetailScreen({required this.ministereId, super.key});

  final String ministereId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MinistereController>();
    final ministere = controller.findById(ministereId);

    if (ministere == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ministère introuvable')),
        body: const Center(child: Text("Ce ministère n'existe pas (ou plus).")),
      );
    }

    final type = controller.findTypeById(ministere.typeMinistereId);

    return Scaffold(
      appBar: AppBar(title: Text(ministere.nom)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LigneInfo(label: 'Type', valeur: type?.libelle ?? ministere.typeMinistereId),
          _LigneInfo(label: 'Statut', valeur: ministere.statut.code),
          _LigneInfo(
            label: 'Date de création',
            valeur: ministere.dateCreation.toIso8601String().split('T').first,
          ),
          const Divider(height: 32),
          OutlinedButton.icon(
            icon: const Icon(Icons.people_outline),
            label: const Text('Membres affectés'),
            onPressed: () => context.push(AppRoutes.ministereMembres(ministere.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.history),
            label: const Text('Historique des responsables'),
            onPressed: () => context.push(AppRoutes.ministereHistoriqueResponsables(ministere.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.event_note_outlined),
            label: const Text("Journal d'activités"),
            onPressed: () => context.push(AppRoutes.ministereJournal(ministere.id)),
          ),
          if (ministere.statut != StatutMinistere.archive) ...[
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.archive_outlined),
              label: const Text('Archiver'),
              onPressed: () => controller.archiverMinistere(ministere.id),
            ),
          ],
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
          SizedBox(width: 160, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}
