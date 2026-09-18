import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../application/fidele_controller.dart';
import '../domain/models/lien_familial.dart';
import '../domain/models/statut_fidele.dart';
import '../domain/models/statut_spirituel.dart';
import '../domain/models/tuteur.dart';
import '../domain/models/type_lien.dart';
import '../domain/rules/fidele_rules.dart';

const List<StatutSpirituel> _chaineProgression = [
  StatutSpirituel.visiteur,
  StatutSpirituel.nouveauConverti,
  StatutSpirituel.baptise,
  StatutSpirituel.membreActif,
];

List<StatutSpirituel> _prochainesCibles(StatutSpirituel actuel) {
  final index = _chaineProgression.indexOf(actuel);
  if (index == -1) return const [];
  return [
    if (index + 1 < _chaineProgression.length) _chaineProgression[index + 1],
    StatutSpirituel.membreDecede,
    StatutSpirituel.membreTransfere,
  ];
}

/// Écran 2 (Fiche fidèle) + écran 4 (Cheminement spirituel) + écran 5
/// (Liens familiaux) + écran 12 (Statuts spirituels — actions de
/// transition) regroupés sur un seul écran de synthèse.
class FideleDetailScreen extends StatelessWidget {
  const FideleDetailScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FideleController>();
    final fidele = controller.findById(fideleId);

    if (fidele == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Fidèle introuvable')),
        body: const Center(child: Text("Ce fidèle n'existe pas (ou plus).")),
      );
    }

    final estMineur = FideleRules.estMineur(fidele.dateNaissance);

    return Scaffold(
      appBar: AppBar(
        title: Text(fidele.nomComplet),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Modifier les coordonnées',
            onPressed: () => _modifierCoordonnees(context, controller, fidele.id,
                telephone: fidele.telephone, email: fidele.email, adresse: fidele.adresse),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Historique des modifications',
            onPressed: () => context.push(AppRoutes.fideleHistorique(fidele.id)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LigneInfo(label: 'Sexe', valeur: fidele.sexe.code),
          _LigneInfo(label: 'Statut civil', valeur: fidele.statutCivil.code),
          _LigneInfo(
            label: 'Date de naissance',
            valeur: fidele.dateNaissance.toIso8601String().split('T').first,
          ),
          if (estMineur) const _LigneInfo(label: 'Mineur', valeur: 'oui'),
          if (fidele.telephone != null) _LigneInfo(label: 'Téléphone', valeur: fidele.telephone!),
          if (fidele.email != null) _LigneInfo(label: 'Email', valeur: fidele.email!),
          if (fidele.adresse != null) _LigneInfo(label: 'Adresse', valeur: fidele.adresse!),
          const Divider(height: 32),
          Text('Cheminement spirituel', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _LigneInfo(label: 'Statut actuel', valeur: fidele.statutSpirituel.code),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _prochainesCibles(fidele.statutSpirituel)
                .map(
                  (cible) => OutlinedButton(
                    onPressed: () =>
                        controller.modifierStatutSpirituel(fideleId: fidele.id, cible: cible),
                    child: Text('→ ${cible.code}'),
                  ),
                )
                .toList(),
          ),
          if (fidele.statutSpirituel == StatutSpirituel.membreEnDiscipline)
            const Text(
              'Ce statut ne peut être modifié que depuis le module Discipline (RG-II-03).',
            ),
          if (estMineur) ...[
            const Divider(height: 32),
            Text('Tuteur légal (RG-II-06)', style: Theme.of(context).textTheme.titleMedium),
            _TuteursSection(controller: controller, mineurId: fidele.id),
          ],
          const Divider(height: 32),
          Text('Liens familiaux', style: Theme.of(context).textTheme.titleMedium),
          _LiensFamiliauxSection(controller: controller, fideleId: fidele.id),
          const Divider(height: 32),
          OutlinedButton.icon(
            icon: const Icon(Icons.auto_awesome_outlined),
            label: const Text('Dons spirituels'),
            onPressed: () => context.push(AppRoutes.donsFidele(fidele.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.work_outline),
            label: const Text('Compétences professionnelles'),
            onPressed: () => context.push(AppRoutes.fideleCompetences(fidele.id)),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.groups_2_outlined),
            label: const Text('Groupes de l\'Église'),
            onPressed: () => context.push(AppRoutes.fideleGroupes(fidele.id)),
          ),
          const SizedBox(height: 8),
          if (fidele.statut != StatutFidele.inactif)
            OutlinedButton.icon(
              icon: const Icon(Icons.archive_outlined),
              label: const Text('Archiver (RG-II-08)'),
              onPressed: () => controller.archiverFidele(fidele.id),
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

Future<void> _modifierCoordonnees(
  BuildContext context,
  FideleController controller,
  String fideleId, {
  String? telephone,
  String? email,
  String? adresse,
}) async {
  final telephoneController = TextEditingController(text: telephone);
  final emailController = TextEditingController(text: email);
  final adresseController = TextEditingController(text: adresse);

  final confirme = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Modifier les coordonnées'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: telephoneController, decoration: const InputDecoration(labelText: 'Téléphone')),
          TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: adresseController, decoration: const InputDecoration(labelText: 'Adresse')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(false), child: const Text('Annuler')),
        FilledButton(onPressed: () => context.pop(true), child: const Text('Enregistrer')),
      ],
    ),
  );

  if (confirme == true) {
    await controller.modifierCoordonnees(
      fideleId: fideleId,
      telephone: telephoneController.text.trim(),
      email: emailController.text.trim(),
      adresse: adresseController.text.trim(),
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

class _TuteursSection extends StatelessWidget {
  const _TuteursSection({required this.controller, required this.mineurId});

  final FideleController controller;
  final String mineurId;

  Future<void> _ajouterTuteurTiers(BuildContext context) async {
    final nomController = TextEditingController();
    final lienController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un tuteur (tiers)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomController, decoration: const InputDecoration(labelText: 'Nom du tuteur')),
            TextField(controller: lienController, decoration: const InputDecoration(labelText: 'Lien (ex. père)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: const Text('Annuler')),
          FilledButton(onPressed: () => context.pop(true), child: const Text('Ajouter')),
        ],
      ),
    );
    if (confirme == true && nomController.text.trim().isNotEmpty && lienController.text.trim().isNotEmpty) {
      await controller.ajouterTuteur(
        mineurId: mineurId,
        lien: lienController.text.trim(),
        tuteurTiersNom: nomController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tuteur>>(
      stream: controller.watchTuteurs(mineurId),
      builder: (context, snapshot) {
        final tuteurs = snapshot.data ?? const <Tuteur>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final tuteur in tuteurs)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(tuteur.tuteurTiersNom ?? tuteur.tuteurFideleId ?? '—'),
                subtitle: Text(tuteur.lien),
              ),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un tuteur'),
              onPressed: () => _ajouterTuteurTiers(context),
            ),
          ],
        );
      },
    );
  }
}

class _LiensFamiliauxSection extends StatelessWidget {
  const _LiensFamiliauxSection({required this.controller, required this.fideleId});

  final FideleController controller;
  final String fideleId;

  Future<void> _ajouterLien(BuildContext context) async {
    final autresFideles = controller.fideles.where((f) => f.id != fideleId).toList();
    if (autresFideles.isEmpty) return;

    String? autreId = autresFideles.first.id;
    TypeLien type = TypeLien.conjoint;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Ajouter un lien familial'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: autreId,
                items: autresFideles
                    .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                    .toList(),
                onChanged: (valeur) => setState(() => autreId = valeur),
              ),
              DropdownButtonFormField<TypeLien>(
                initialValue: type,
                items: TypeLien.values
                    .map((t) => DropdownMenuItem(value: t, child: Text(t.code)))
                    .toList(),
                onChanged: (valeur) => setState(() => type = valeur ?? TypeLien.conjoint),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => context.pop(false), child: const Text('Annuler')),
            FilledButton(onPressed: () => context.pop(true), child: const Text('Ajouter')),
          ],
        ),
      ),
    );

    if (confirme == true && autreId != null) {
      await controller.ajouterLienFamilial(fideleId1: fideleId, fideleId2: autreId!, typeLien: type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LienFamilial>>(
      stream: controller.watchLiensFamiliaux(fideleId),
      builder: (context, snapshot) {
        final liens = snapshot.data ?? const <LienFamilial>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final lien in liens)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  controller.findById(lien.fideleId1 == fideleId ? lien.fideleId2 : lien.fideleId1)?.nomComplet ??
                      '—',
                ),
                subtitle: Text(lien.typeLien.code),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.retirerLienFamilial(lien.id),
                ),
              ),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un lien'),
              onPressed: () => _ajouterLien(context),
            ),
          ],
        );
      },
    );
  }
}
