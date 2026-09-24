import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../parametres/presentation/role_libelle.dart';
import '../application/fidele_controller.dart';
import '../application/notes_pastorales_controller.dart';
import '../domain/models/note_pastorale.dart';
import 'notes_pastorales_screen.dart';

/// Ouverture d'une note pastorale (RG-II-11). Passe par
/// `NotesPastoralesController.consulter`, qui refuse un compte non habilité
/// (y compris par accès direct à la route) et journalise l'ouverture.
/// Lancée une seule fois (`initState`) : une reconstruction de l'écran n'est
/// pas une nouvelle consultation — même motif que la fiche d'un dossier
/// disciplinaire (Module X).
class NotePastoraleDetailScreen extends StatefulWidget {
  const NotePastoraleDetailScreen({required this.noteId, super.key});

  final String noteId;

  @override
  State<NotePastoraleDetailScreen> createState() => _NotePastoraleDetailScreenState();
}

class _NotePastoraleDetailScreenState extends State<NotePastoraleDetailScreen> {
  Acteur? _acteur;
  late Future<NotePastorale?> _consultation;

  @override
  void initState() {
    super.initState();
    _acteur = context.read<SessionController>().acteur;
    final acteur = _acteur;
    _consultation = acteur == null
        ? Future.error(AppError.notePastoraleAccesRefuse())
        : context.read<NotesPastoralesController>().consulter(acteur: acteur, noteId: widget.noteId);
  }

  Future<void> _modifier(NotePastorale note, Acteur acteur) async {
    final controller = context.read<NotesPastoralesController>();
    final contenu = await demanderContenuNote(
      context,
      titre: AppLocalizations.of(context)!.notesPastoralesModifier,
      initial: note.contenu,
    );
    if (contenu == null || !mounted) return;
    final modifiee = await controller.modifier(acteur: acteur, noteId: note.id, contenu: contenu);
    if (!mounted) return;
    if (modifiee != null) {
      // La note modifiée est déjà en main : pas de nouvelle consultation.
      setState(() => _consultation = Future.value(modifiee));
    } else if (controller.erreur != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(controller.erreur!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideles = context.watch<FideleController>();

    return FutureBuilder<NotePastorale?>(
      future: _consultation,
      builder: (context, snapshot) {
        if (snapshot.hasError) return EcranNotesPastoralesAccesReserve(titre: l10n.notesPastoralesDetailTitre);
        final acteur = _acteur;
        if (snapshot.connectionState != ConnectionState.done || acteur == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final note = snapshot.data;
        if (note == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.notesPastoralesDetailTitre)),
            body: Center(child: Text(l10n.notesPastoralesIntrouvable)),
          );
        }
        final estAuteur = acteur.fideleId == note.auteurFideleId;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.notesPastoralesDetailTitre),
            actions: [
              if (estAuteur)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: l10n.notesPastoralesModifier,
                  onPressed: () => _modifier(note, acteur),
                ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              Text(
                l10n.notesPastoralesAuteurDate(
                  fideles.findById(note.auteurFideleId)?.nomComplet ?? '—',
                  note.createdAt.toString().split('.').first,
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (note.updatedAt.isAfter(note.createdAt))
                Text(
                  l10n.notesPastoralesModifieeLe(note.updatedAt.toString().split('.').first),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: AppDimensions.spacingMd),
              SelectableText(note.contenu),
              const Divider(height: AppDimensions.spacingXxl),
              _JournalConsultations(acteur: acteur, noteId: note.id),
            ],
          ),
        );
      },
    );
  }
}

/// Journal des ouvertures de la note : lisible de qui lit la note (auteur,
/// pasteurs), jamais du fidèle concerné — vérifié dans le dépôt.
class _JournalConsultations extends StatelessWidget {
  const _JournalConsultations({required this.acteur, required this.noteId});

  final Acteur acteur;
  final String noteId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideles = context.watch<FideleController>();
    return StreamBuilder<List<ConsultationNotePastorale>>(
      stream: context.read<NotesPastoralesController>().watchConsultations(acteur: acteur, noteId: noteId),
      builder: (context, snapshot) {
        final consultations = snapshot.data ?? const <ConsultationNotePastorale>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.notesPastoralesJournalTitre, style: Theme.of(context).textTheme.titleMedium),
            if (consultations.isEmpty) Text(l10n.notesPastoralesJournalAucune),
            for (final c in consultations)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: const Icon(Icons.visibility_outlined),
                title: Text(
                  '${c.fideleId == null ? l10n.notesPastoralesCompteSansFiche : fideles.findById(c.fideleId!)?.nomComplet ?? '—'}'
                  ' · ${libelleRole(l10n, c.role)}',
                ),
                subtitle: Text(c.consulteLe.toString().split('.').first),
              ),
          ],
        );
      },
    );
  }
}
