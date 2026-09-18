import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/don_spirituel_controller.dart';
import '../domain/models/niveau_maturite.dart';

/// Écran 2 (Évaluation d'un don), RG-IV-01/02 — chaque validation ajoute
/// une nouvelle évaluation, signée par un responsable de suivi.
class DonEvaluationFormScreen extends StatefulWidget {
  const DonEvaluationFormScreen({required this.fideleId, required this.donId, super.key});

  final String fideleId;
  final String donId;

  @override
  State<DonEvaluationFormScreen> createState() => _DonEvaluationFormScreenState();
}

class _DonEvaluationFormScreenState extends State<DonEvaluationFormScreen> {
  NiveauMaturite _niveau = NiveauMaturite.emergent;
  String? _responsableSuiviId;
  final _observationsController = TextEditingController();

  @override
  void dispose() {
    _observationsController.dispose();
    super.dispose();
  }

  Future<void> _valider(DonSpirituelController controller) async {
    if (_responsableSuiviId == null) return;
    final ok = await controller.evaluer(
      fideleId: widget.fideleId,
      donId: widget.donId,
      niveauMaturite: _niveau,
      responsableSuiviId: _responsableSuiviId!,
      observations: _observationsController.text.trim().isEmpty ? null : _observationsController.text.trim(),
    );
    if (ok && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DonSpirituelController>();
    final fideleController = context.watch<FideleController>();
    final responsablesPossibles = fideleController.fideles;
    _responsableSuiviId ??= responsablesPossibles.isEmpty ? null : responsablesPossibles.first.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Évaluer le don')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<NiveauMaturite>(
            key: const Key('niveau_maturite_dropdown'),
            initialValue: _niveau,
            decoration: const InputDecoration(labelText: 'Niveau de maturité'),
            items: NiveauMaturite.values
                .map((n) => DropdownMenuItem(value: n, child: Text(n.code)))
                .toList(),
            onChanged: (valeur) => setState(() => _niveau = valeur ?? _niveau),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            key: const Key('responsable_suivi_dropdown'),
            initialValue: _responsableSuiviId,
            decoration: const InputDecoration(labelText: 'Responsable de suivi'),
            items: responsablesPossibles
                .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                .toList(),
            onChanged: (valeur) => setState(() => _responsableSuiviId = valeur),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _observationsController,
            decoration: const InputDecoration(labelText: 'Observations'),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _valider(controller),
            child: const Text('Enregistrer l\'évaluation'),
          ),
          if (controller.erreur != null) ...[
            const SizedBox(height: 16),
            Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
    );
  }
}
