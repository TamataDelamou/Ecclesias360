import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/profession_controller.dart';
import '../domain/models/profession.dart';

/// Écran 1 (Liste des groupes professionnels) + écran 4 (Recherche par
/// métier), RG-V-02 — référentiel hiérarchisé catégorie / métier.
class ProfessionsListScreen extends StatefulWidget {
  const ProfessionsListScreen({super.key});

  @override
  State<ProfessionsListScreen> createState() => _ProfessionsListScreenState();
}

class _ProfessionsListScreenState extends State<ProfessionsListScreen> {
  String _terme = '';

  Future<void> _ajouterProfession(ProfessionController controller) async {
    final categorieController = TextEditingController();
    final libelleController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un métier'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: categorieController, decoration: const InputDecoration(labelText: 'Catégorie')),
            TextField(controller: libelleController, decoration: const InputDecoration(labelText: 'Métier')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Ajouter')),
        ],
      ),
    );

    if (confirme == true &&
        categorieController.text.trim().isNotEmpty &&
        libelleController.text.trim().isNotEmpty) {
      final libelle = libelleController.text.trim();
      final code = libelle.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
      await controller.creerProfession(code: code, categorie: categorieController.text.trim(), libelle: libelle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfessionController>();
    final terme = _terme.trim().toLowerCase();
    final professions = controller.professions.where((p) {
      if (terme.isEmpty) return true;
      return p.libelle.toLowerCase().contains(terme) || p.categorie.toLowerCase().contains(terme);
    }).toList()
      ..sort((a, b) => a.categorie == b.categorie ? a.libelle.compareTo(b.libelle) : a.categorie.compareTo(b.categorie));

    return Scaffold(
      appBar: AppBar(title: const Text('Groupes professionnels')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Rechercher par métier ou catégorie'),
              onChanged: (valeur) => setState(() => _terme = valeur),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: professions.length,
              itemBuilder: (context, index) {
                final Profession profession = professions[index];
                final estNouvelleCategorie = index == 0 || professions[index - 1].categorie != profession.categorie;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (estNouvelleCategorie)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Text(
                          profession.categorie,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ListTile(
                      title: Text(profession.libelle),
                      onTap: () => context.push(AppRoutes.professionGroupe(profession.id)),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _ajouterProfession(controller),
        tooltip: 'Ajouter un métier',
        child: const Icon(Icons.add),
      ),
    );
  }
}
