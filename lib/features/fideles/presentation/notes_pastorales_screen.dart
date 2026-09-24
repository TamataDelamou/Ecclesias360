import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/fidele_controller.dart';
import '../application/notes_pastorales_controller.dart';
import '../domain/models/note_pastorale.dart';
import '../domain/rules/note_pastorale_rules.dart';

/// Écran 13 du Module II — notes pastorales privées d'un fidèle (RG-II-11).
///
/// La liste ne montre que l'auteur et les dates : le contenu n'apparaît qu'à
/// l'ouverture d'une note, qui est journalisée. Réservé à un pasteur (ou
/// plus), jamais sur sa propre fiche — vérifié ici avant l'existence du
/// fidèle (qui n'est pas révélée) et, surtout, dans le dépôt : un accès
/// direct par la route reçoit un refus du flux lui-même.
class NotesPastoralesScreen extends StatelessWidget {
  const NotesPastoralesScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final acteur = context.watch<SessionController>().acteur;
    if (acteur == null ||
        !NotePastoraleRules.peutOuvrirNotesDuFidele(
          role: acteur.role,
          acteurFideleId: acteur.fideleId,
          fideleConcerneId: fideleId,
        )) {
      return EcranNotesPastoralesAccesReserve(titre: l10n.notesPastoralesTitre);
    }
    final controller = context.read<NotesPastoralesController>();
    final fideles = context.watch<FideleController>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notesPastoralesTitre)),
      floatingActionButton: acteur.fideleId == null
          ? null
          : FloatingActionButton(
              tooltip: l10n.notesPastoralesRediger,
              onPressed: () => _rediger(context, controller, acteur),
              child: const Icon(Icons.edit_note),
            ),
      body: StreamBuilder<List<NotePastoraleResume>>(
        stream: controller.watchNotesDuFidele(acteur: acteur, fideleId: fideleId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text(l10n.notesPastoralesAccesReserve));
          final notes = snapshot.data ?? const <NotePastoraleResume>[];
          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              Text(l10n.notesPastoralesConfidentialite, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: AppDimensions.spacingMd),
              if (notes.isEmpty) Text(l10n.notesPastoralesAucune),
              for (final note in notes)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: Text(
                      l10n.notesPastoralesAuteurDate(
                        fideles.findById(note.auteurFideleId)?.nomComplet ?? '—',
                        note.createdAt.toString().split('.').first,
                      ),
                    ),
                    subtitle: note.updatedAt.isAfter(note.createdAt)
                        ? Text(l10n.notesPastoralesModifieeLe(note.updatedAt.toString().split('.').first))
                        : null,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(AppRoutes.notePastorale(note.id)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _rediger(BuildContext context, NotesPastoralesController controller, Acteur acteur) async {
    final contenu = await demanderContenuNote(context, titre: AppLocalizations.of(context)!.notesPastoralesRediger);
    if (contenu == null || !context.mounted) return;
    final note = await controller.rediger(acteur: acteur, fideleId: fideleId, contenu: contenu);
    if (!context.mounted) return;
    if (note == null && controller.erreur != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(controller.erreur!)));
    }
  }
}

/// Dialogue de saisie du contenu d'une note (rédaction ou modification).
Future<String?> demanderContenuNote(BuildContext context, {required String titre, String initial = ''}) async {
  final champ = TextEditingController(text: initial);
  final confirme = await showDialog<bool>(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return AlertDialog(
        title: Text(titre),
        content: TextField(
          controller: champ,
          minLines: 3,
          maxLines: 8,
          decoration: InputDecoration(labelText: l10n.notesPastoralesChampContenu),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonEnregistrer)),
        ],
      );
    },
  );
  final texte = champ.text.trim();
  return confirme == true && texte.isNotEmpty ? texte : null;
}

/// Écran affiché à un compte non habilité (RG-II-11).
class EcranNotesPastoralesAccesReserve extends StatelessWidget {
  const EcranNotesPastoralesAccesReserve({required this.titre, super.key});

  final String titre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: Center(child: Text(AppLocalizations.of(context)!.notesPastoralesAccesReserve)),
    );
  }
}
