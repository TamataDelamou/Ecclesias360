import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/culte_controller.dart';
import '../domain/models/mode_presence.dart';

/// Écran « Nouveau culte » (RG-XII-01/02/05) — saisie unique, avec option de
/// série récurrente hebdomadaire.
class CulteFormScreen extends StatefulWidget {
  const CulteFormScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  State<CulteFormScreen> createState() => _CulteFormScreenState();
}

class _CulteFormScreenState extends State<CulteFormScreen> {
  final _typeController = TextEditingController();
  final _themeController = TextEditingController();
  final _occurrencesController = TextEditingController(text: '4');
  String? _predicateurId;
  DateTime? _dateHeure;
  ModePresence _modePresence = ModePresence.nominal;
  bool _recurrent = false;
  bool _typeInvalide = false;

  @override
  void dispose() {
    _typeController.dispose();
    _themeController.dispose();
    _occurrencesController.dispose();
    super.dispose();
  }

  Future<void> _choisirDateHeure() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dateHeure ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;
    final heure = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateHeure ?? DateTime.now()),
    );
    if (heure == null) return;
    setState(() => _dateHeure = DateTime(date.year, date.month, date.day, heure.hour, heure.minute));
  }

  Future<void> _valider(CulteController controller) async {
    final type = _typeController.text.trim();
    setState(() => _typeInvalide = type.isEmpty);
    if (type.isEmpty || _dateHeure == null) return;

    final theme = _themeController.text.trim().isEmpty ? null : _themeController.text.trim();
    final ok = _recurrent
        ? await controller.creerSerieRecurrente(
            noeudId: widget.noeudId,
            premiereDateHeure: _dateHeure!,
            typeCulte: type,
            theme: theme,
            predicateurId: _predicateurId,
            modePresence: _modePresence,
            nombreOccurrences: int.tryParse(_occurrencesController.text.trim()) ?? 1,
          )
        : await controller.creerCulte(
            noeudId: widget.noeudId,
            dateHeure: _dateHeure!,
            typeCulte: type,
            theme: theme,
            predicateurId: _predicateurId,
            modePresence: _modePresence,
          );
    if (ok && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CulteController>();
    final fideles = context.watch<FideleController>().fideles;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cultesNouveauTooltip)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          TextField(
            controller: _typeController,
            decoration: InputDecoration(
              labelText: l10n.culteChampType,
              errorText: _typeInvalide ? l10n.culteChampTypeErreur : null,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          TextField(
            controller: _themeController,
            decoration: InputDecoration(labelText: l10n.culteChampTheme),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          DropdownButtonFormField<String?>(
            initialValue: _predicateurId,
            decoration: InputDecoration(labelText: l10n.culteChampPredicateur),
            items: [
              DropdownMenuItem<String?>(value: null, child: Text(l10n.culteAucunPredicateur)),
              for (final fidele in fideles) DropdownMenuItem<String?>(value: fidele.id, child: Text(fidele.nomComplet)),
            ],
            onChanged: (valeur) => setState(() => _predicateurId = valeur),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.culteChampDateHeure),
            subtitle: Text(_dateHeure?.toString().split('.').first ?? l10n.culteDateHeureChoisir),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: _choisirDateHeure,
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          DropdownButtonFormField<ModePresence>(
            initialValue: _modePresence,
            decoration: InputDecoration(labelText: l10n.culteChampModePresence),
            items: [
              DropdownMenuItem(value: ModePresence.nominal, child: Text(l10n.culteModePresenceNominal)),
              DropdownMenuItem(value: ModePresence.global, child: Text(l10n.culteModePresenceGlobal)),
            ],
            onChanged: (valeur) => setState(() => _modePresence = valeur ?? _modePresence),
          ),
          const SizedBox(height: AppDimensions.spacingLg),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _recurrent,
            title: Text(l10n.culteChampRecurrent),
            onChanged: (coche) => setState(() => _recurrent = coche ?? false),
          ),
          if (_recurrent)
            TextField(
              controller: _occurrencesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l10n.culteChampNombreOccurrences),
            ),
          const SizedBox(height: AppDimensions.spacingLg),
          FilledButton(
            onPressed: controller.enCours ? null : () => _valider(controller),
            child: Text(l10n.commonAjouter),
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
