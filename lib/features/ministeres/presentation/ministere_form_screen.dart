import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../application/ministere_controller.dart';

/// Écran 3 (Création / édition ministère), RG-III-01/04.
class MinistereFormScreen extends StatefulWidget {
  const MinistereFormScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  State<MinistereFormScreen> createState() => _MinistereFormScreenState();
}

class _MinistereFormScreenState extends State<MinistereFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _typePersonnaliseController = TextEditingController();
  String? _typeMinistereId;

  @override
  void dispose() {
    _nomController.dispose();
    _typePersonnaliseController.dispose();
    super.dispose();
  }

  Future<void> _ajouterTypePersonnalise(MinistereController controller) async {
    final libelle = _typePersonnaliseController.text.trim();
    if (libelle.isEmpty) return;
    final code = libelle.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    final ok = await controller.creerTypePersonnalise(libelle: libelle, code: code);
    if (ok && mounted) {
      final nouveauType = controller.types.firstWhere((t) => t.code == code);
      setState(() {
        _typeMinistereId = nouveauType.id;
        _typePersonnaliseController.clear();
      });
    }
  }

  Future<void> _valider(MinistereController controller) async {
    if (!(_formKey.currentState?.validate() ?? false) || _typeMinistereId == null) return;
    final ok = await controller.creerMinistere(
      noeudId: widget.noeudId,
      typeMinistereId: _typeMinistereId!,
      nom: _nomController.text.trim(),
    );
    if (ok && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MinistereController>();
    final types = controller.types;

    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau ministère')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom du ministère'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Le nom est requis.' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: const Key('ministere_type_dropdown'),
              initialValue: _typeMinistereId,
              decoration: const InputDecoration(labelText: 'Type de ministère'),
              items: types
                  .map((t) => DropdownMenuItem(value: t.id, child: Text(t.libelle)))
                  .toList(),
              onChanged: (valeur) => setState(() => _typeMinistereId = valeur),
              validator: (v) => v == null ? 'Le type est requis.' : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _typePersonnaliseController,
                    decoration: const InputDecoration(labelText: 'Ajouter un type personnalisé'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Ajouter ce type au catalogue',
                  onPressed: () => _ajouterTypePersonnalise(controller),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => _valider(controller),
              child: const Text('Créer le ministère'),
            ),
            if (controller.erreur != null) ...[
              const SizedBox(height: 16),
              Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
    );
  }
}
