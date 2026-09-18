import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../fideles/application/fidele_controller.dart';
import '../application/comite_controller.dart';

/// Écran 3 (Convocation de séance) + écran 4 (Saisie de séance / ordre du
/// jour), RG-VII-05 — la diffusion effective d'une convocation (Module
/// XVII, communication) est différée, non construite ; cet écran couvre la
/// saisie et l'enregistrement des présents.
class SeanceFormScreen extends StatefulWidget {
  const SeanceFormScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  State<SeanceFormScreen> createState() => _SeanceFormScreenState();
}

class _SeanceFormScreenState extends State<SeanceFormScreen> {
  final _ordreDuJourController = TextEditingController();
  DateTime _date = DateTime.now();
  final Set<String> _presents = {};

  @override
  void dispose() {
    _ordreDuJourController.dispose();
    super.dispose();
  }

  Future<void> _choisirDate() async {
    final choisie = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (choisie != null) setState(() => _date = choisie);
  }

  Future<void> _valider(ComiteController controller) async {
    if (_ordreDuJourController.text.trim().isEmpty) return;
    final ok = await controller.creerSeance(
      noeudId: widget.noeudId,
      date: _date,
      ordreDuJour: _ordreDuJourController.text.trim(),
      presentsFideleIds: _presents.toList(),
    );
    if (ok && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ComiteController>();
    final fideleController = context.watch<FideleController>();
    final fideles = fideleController.fideles;

    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle séance')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Date'),
            subtitle: Text(_date.toIso8601String().split('T').first),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: _choisirDate,
          ),
          TextField(
            controller: _ordreDuJourController,
            decoration: const InputDecoration(labelText: 'Ordre du jour'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Text('Présents', style: Theme.of(context).textTheme.titleMedium),
          for (final fidele in fideles)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _presents.contains(fidele.id),
              title: Text(fidele.nomComplet),
              onChanged: (coche) => setState(() {
                if (coche == true) {
                  _presents.add(fidele.id);
                } else {
                  _presents.remove(fidele.id);
                }
              }),
            ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _valider(controller),
            child: const Text('Enregistrer la séance'),
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
