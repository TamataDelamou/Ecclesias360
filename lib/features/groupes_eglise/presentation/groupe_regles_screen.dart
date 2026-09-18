import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/groupe_controller.dart';
import '../domain/models/type_regle_groupe.dart';

/// Écran 3 (Règles d'appartenance automatique), RG-VI-01 — lecture seule :
/// le paramétrage des critères est différé (comme les autres référentiels,
/// bloqué par l'absence de session/rôle courant réel, RG-SEC-01).
class GroupeReglesScreen extends StatelessWidget {
  const GroupeReglesScreen({required this.groupeId, super.key});

  final String groupeId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GroupeController>();
    final groupe = controller.findById(groupeId);

    if (groupe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Groupe introuvable')),
        body: const Center(child: Text("Ce groupe n'existe pas (ou plus).")),
      );
    }

    if (groupe.typeRegle != TypeRegleGroupe.auto || groupe.criteres == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Règles — ${groupe.libelle}')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "Ce groupe est purement manuel : aucune règle automatique, "
              "l'appartenance est affectée fidèle par fidèle.",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final criteres = groupe.criteres!;
    final lignes = <String>[
      if (criteres.sexe != null) 'Sexe : ${criteres.sexe}',
      if (criteres.statutCivil != null) 'Statut civil : ${criteres.statutCivil}',
      if (criteres.statutSpirituel != null) 'Statut spirituel : ${criteres.statutSpirituel}',
      if (criteres.ageMin != null) 'Âge minimum : ${criteres.ageMin}',
      if (criteres.ageMax != null) 'Âge maximum : ${criteres.ageMax}',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Règles — ${groupe.libelle}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tous les critères ci-dessous doivent correspondre (ET logique) pour une '
            'appartenance automatique.',
          ),
          const SizedBox(height: 16),
          for (final ligne in lignes) Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text(ligne)),
        ],
      ),
    );
  }
}
