import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../organization/application/organisation_controller.dart';
import '../application/fidele_controller.dart';
import '../domain/models/sexe.dart';
import '../domain/models/statut_civil.dart';

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

    final succes = await controller.creerFidele(
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

    return Scaffold(
      appBar: AppBar(title: const Text('Créer un fidèle')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              key: const Key('champ_noeud'),
              initialValue: _noeudId,
              decoration: const InputDecoration(
                labelText: 'Nœud d\'appartenance',
                border: OutlineInputBorder(),
              ),
              items: noeuds
                  .map((noeud) => DropdownMenuItem(value: noeud.id, child: Text(noeud.nom)))
                  .toList(),
              onChanged: (valeur) => setState(() => _noeudId = valeur),
              validator: (valeur) => valeur == null ? 'Choisissez un nœud d\'appartenance.' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Le nom est requis.' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prenomsController,
              decoration: const InputDecoration(labelText: 'Prénoms', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Les prénoms sont requis.' : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _dateNaissance == null
                    ? 'Date de naissance'
                    : 'Date de naissance : ${_dateNaissance!.toIso8601String().split('T').first}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _choisirDateNaissance,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Sexe>(
              key: const Key('champ_sexe'),
              initialValue: _sexe,
              decoration: const InputDecoration(labelText: 'Sexe', border: OutlineInputBorder()),
              items: Sexe.values.map((s) => DropdownMenuItem(value: s, child: Text(s.code))).toList(),
              onChanged: (valeur) => setState(() => _sexe = valeur),
              validator: (valeur) => valeur == null ? 'Choisissez un sexe.' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<StatutCivil>(
              key: const Key('champ_statut_civil'),
              initialValue: _statutCivil,
              decoration: const InputDecoration(labelText: 'Statut civil', border: OutlineInputBorder()),
              items: StatutCivil.values
                  .map((s) => DropdownMenuItem(value: s, child: Text(s.code)))
                  .toList(),
              onChanged: (valeur) => setState(() => _statutCivil = valeur),
              validator: (valeur) => valeur == null ? 'Choisissez un statut civil.' : null,
            ),
            const SizedBox(height: 24),
            if (fideleController.erreur != null) ...[
              Text(fideleController.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: 16),
            ],
            FilledButton(
              onPressed: fideleController.enCours ? null : () => _soumettre(fideleController),
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }
}
