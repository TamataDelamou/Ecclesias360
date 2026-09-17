import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/fidele_controller.dart';
import '../domain/models/fidele.dart';

/// Écran 1 (Liste des fidèles, filtrable) + écran 7 (Recherche avancée,
/// intégrée via la barre de recherche).
class FideleListScreen extends StatefulWidget {
  const FideleListScreen({super.key});

  @override
  State<FideleListScreen> createState() => _FideleListScreenState();
}

class _FideleListScreenState extends State<FideleListScreen> {
  final TextEditingController _rechercheController = TextEditingController();
  String _terme = '';

  @override
  void dispose() {
    _rechercheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FideleController>();
    final resultats = controller.rechercher(_terme);

    return Scaffold(
      appBar: AppBar(title: const Text('Fidèles')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _rechercheController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Rechercher un fidèle (nom ou prénoms)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _terme = value),
            ),
          ),
          Expanded(
            child: resultats.isEmpty
                ? const Center(child: Text('Aucun fidèle enregistré.'))
                : ListView.builder(
                    itemCount: resultats.length,
                    itemBuilder: (context, index) {
                      final fidele = resultats[index];
                      return _FideleTile(fidele: fidele);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.fidelesNouveau),
        tooltip: 'Créer un fidèle',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FideleTile extends StatelessWidget {
  const _FideleTile({required this.fidele});

  final Fidele fidele;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fidele.nomComplet),
      subtitle: Text('${fidele.statutSpirituel.code} · ${fidele.statut.code}'),
      onTap: () => context.push(AppRoutes.fidele(fidele.id)),
    );
  }
}
