import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/comite_controller.dart';

/// Écran 3 (Convocation de séance) + écran 4 (Saisie de séance / ordre du
/// jour), RG-VII-05 — la diffusion effective d\'une convocation (Module
/// XVII, communication) est différée, non construite ; cet écran couvre la
/// saisie et l\'enregistrement des présents.
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.comiteNouvelleSeanceTitre)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.comiteChampDate),
            subtitle: Text(_date.toIso8601String().split('T').first),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: _choisirDate,
          ),
          TextField(
            controller: _ordreDuJourController,
            decoration: InputDecoration(labelText: l10n.comiteChampOrdreDuJour),
            maxLines: 3,
          ),
          const SizedBox(height: AppDimensions.spacingLg),
          Text(l10n.comitePresentsTitre, style: Theme.of(context).textTheme.titleMedium),
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
          const SizedBox(height: AppDimensions.spacingLg),
          FilledButton(
            onPressed: () => _valider(controller),
            child: Text(l10n.comiteEnregistrerSeance),
          ),
          if (controller.erreur != null) ...[
            const SizedBox(height: AppDimensions.spacingLg),
            Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
    );
  }
}
