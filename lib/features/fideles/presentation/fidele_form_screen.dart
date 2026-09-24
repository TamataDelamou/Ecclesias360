import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../organization/application/organisation_controller.dart';
import '../application/fidele_controller.dart';
import '../domain/models/sexe.dart';
import '../domain/models/statut_civil.dart';
import '../domain/rules/fidele_acces_rules.dart';

/// Écran 3 (Création / édition fidèle) — création uniquement pour cette
/// première itération ; l'édition des coordonnées est un écran dédié
/// (RG-II-05 : historisation), le statut spirituel se modifie depuis la
/// fiche (écran 12 replié dans `FideleDetailScreen`).
class FideleFormScreen extends StatefulWidget {
  const FideleFormScreen({super.key});

  @override
  State<FideleFormScreen> createState() => _FideleFormScreenState();
}

class _FideleFormScreenState extends State<FideleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();
  DateTime? _dateNaissance;
  Sexe? _sexe;
  StatutCivil? _statutCivil;
  String? _noeudId;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomsController.dispose();
    super.dispose();
  }

  Future<void> _choisirDateNaissance() async {
    final maintenant = DateTime.now();
    final choisie = await showDatePicker(
      context: context,
      initialDate: DateTime(maintenant.year - 20),
      firstDate: DateTime(1900),
      lastDate: maintenant,
    );
    if (choisie != null) setState(() => _dateNaissance = choisie);
  }

  Future<void> _soumettre(FideleController controller) async {
    if (!_formKey.currentState!.validate() ||
        _dateNaissance == null ||
        _sexe == null ||
        _statutCivil == null ||
        _noeudId == null) {
      return;
    }
    final acteur = context.read<SessionController>().acteur;
    if (acteur == null) return;

    final succes = await controller.creerFidele(
      acteur: acteur,
      noeudId: _noeudId!,
      nom: _nomController.text.trim(),
      prenoms: _prenomsController.text.trim(),
      dateNaissance: _dateNaissance!,
      sexe: _sexe!,
      statutCivil: _statutCivil!,
    );
    if (succes && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final fideleController = context.watch<FideleController>();
    final noeuds = context.watch<OrganisationController>().nodes;
    final l10n = AppLocalizations.of(context)!;

    // Gardé aussi contre l'accès direct par la route (RG-SEC-04).
    if (!FideleAccesRules.peutGererFideles(context.watch<SessionController>().role)) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.fidelesTitre)),
        body: Center(child: Text(l10n.fidelesAccesReserve)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fidelesCreerAction)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          children: [
            DropdownButtonFormField<String>(
              key: const Key('champ_noeud'),
              initialValue: _noeudId,
              decoration: InputDecoration(
                labelText: l10n.fideleChampNoeud,
                border: const OutlineInputBorder(),
              ),
              items: noeuds
                  .map((noeud) => DropdownMenuItem(value: noeud.id, child: Text(noeud.nom)))
                  .toList(),
              onChanged: (valeur) => setState(() => _noeudId = valeur),
              validator: (valeur) => valeur == null ? l10n.fideleChampNoeudErreur : null,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            TextFormField(
              controller: _nomController,
              decoration: InputDecoration(labelText: l10n.fideleChampNom, border: const OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? l10n.fideleChampNomErreur : null,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            TextFormField(
              controller: _prenomsController,
              decoration: InputDecoration(labelText: l10n.fideleChampPrenoms, border: const OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? l10n.fideleChampPrenomsErreur : null,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _dateNaissance == null
                    ? l10n.fideleChampDateNaissance
                    : l10n.fideleDateNaissanceValeur(_dateNaissance!.toIso8601String().split('T').first),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _choisirDateNaissance,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            DropdownButtonFormField<Sexe>(
              key: const Key('champ_sexe'),
              initialValue: _sexe,
              decoration: InputDecoration(labelText: l10n.fideleChampSexe, border: const OutlineInputBorder()),
              items: Sexe.values.map((s) => DropdownMenuItem(value: s, child: Text(s.code))).toList(),
              onChanged: (valeur) => setState(() => _sexe = valeur),
              validator: (valeur) => valeur == null ? l10n.fideleChampSexeErreur : null,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            DropdownButtonFormField<StatutCivil>(
              key: const Key('champ_statut_civil'),
              initialValue: _statutCivil,
              decoration: InputDecoration(labelText: l10n.fideleChampStatutCivil, border: const OutlineInputBorder()),
              items: StatutCivil.values
                  .map((s) => DropdownMenuItem(value: s, child: Text(s.code)))
                  .toList(),
              onChanged: (valeur) => setState(() => _statutCivil = valeur),
              validator: (valeur) => valeur == null ? l10n.fideleChampStatutCivilErreur : null,
            ),
            const SizedBox(height: AppDimensions.spacingXl),
            if (fideleController.erreur != null) ...[
              Text(fideleController.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: AppDimensions.spacingLg),
            ],
            FilledButton(
              onPressed: fideleController.enCours ? null : () => _soumettre(fideleController),
              child: Text(l10n.commonCreer),
            ),
          ],
        ),
      ),
    );
  }
}
