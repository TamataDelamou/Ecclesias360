import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/mediatheque_controller.dart';
import '../domain/models/commentaire.dart';
import '../domain/models/signalement_commentaire.dart';
import '../domain/models/statut_moderation_commentaire.dart';
import '../domain/rules/mediatheque_rules.dart';

/// RG-XIII-03 — modération des commentaires : ceux qui attendent une
/// validation (modération a priori), ceux masqués ou signalés depuis la
/// dernière décision, avec les auteurs des signalements pour contexte.
/// Approuver publie, rejeter masque ; la décision trace la fiche de la
/// session. Réservé au modérateur (rang pasteur), y compris par la route.
class ModerationCommentairesScreen extends StatelessWidget {
  const ModerationCommentairesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();
    if (!MediathequeRules.peutModerer(session.role)) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.mediathequeModerationTitre)),
        body: Center(child: Text(l10n.mediathequeModerationReservee)),
      );
    }
    final controller = context.watch<MediathequeController>();
    final acteur = session.acteur;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mediathequeModerationTitre)),
      body: StreamBuilder<List<Commentaire>>(
        stream: controller.watchCommentairesAModerer(),
        builder: (context, snapshot) {
          final commentaires = snapshot.data ?? const <Commentaire>[];
          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              // Une décision trace une personne du registre (RG-XIII-03).
              if (acteur?.fideleId == null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
                  child: Text(l10n.mediathequeModerationSansFiche),
                ),
              if (commentaires.isEmpty) Center(child: Text(l10n.mediathequeModerationAucun)),
              for (final commentaire in commentaires)
                _CarteModeration(
                  commentaire: commentaire,
                  onDecision: acteur == null || acteur.fideleId == null
                      ? null
                      : (statut) => controller.modererCommentaire(
                          id: commentaire.id,
                          nouveauStatut: statut,
                          acteur: acteur,
                        ),
                ),
              if (controller.erreur != null)
                Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          );
        },
      ),
    );
  }
}

class _CarteModeration extends StatelessWidget {
  const _CarteModeration({required this.commentaire, required this.onDecision});

  final Commentaire commentaire;
  final void Function(StatutModerationCommentaire statut)? onDecision;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideles = context.watch<FideleController>();
    String nom(String id) => fideles.findById(id)?.nomComplet ?? '—';
    final etat = switch (commentaire.statutModeration) {
      StatutModerationCommentaire.enAttente => l10n.mediathequeCommentaireEnAttente,
      StatutModerationCommentaire.masque => l10n.mediathequeModerationMasque,
      StatutModerationCommentaire.publie => l10n.mediathequeModerationPublieSignale,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(commentaire.texte, style: Theme.of(context).textTheme.titleSmall),
            Text('${l10n.mediathequeModerationAuteur(nom(commentaire.fideleId))} · $etat'),
            StreamBuilder<List<SignalementCommentaire>>(
              stream: context.read<MediathequeController>().watchSignalements(commentaire.id),
              builder: (context, snapshot) {
                final signalements = snapshot.data ?? const <SignalementCommentaire>[];
                if (signalements.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimensions.spacingXs),
                    for (final s in signalements)
                      Text(
                        s.motif == null
                            ? l10n.mediathequeModerationSignalePar(nom(s.fideleId))
                            : l10n.mediathequeModerationSignaleParMotif(nom(s.fideleId), s.motif!),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Wrap(
              spacing: AppDimensions.spacingSm,
              children: [
                FilledButton(
                  onPressed: onDecision == null ? null : () => onDecision!(StatutModerationCommentaire.publie),
                  child: Text(l10n.mediathequeModerationApprouver),
                ),
                OutlinedButton(
                  onPressed: onDecision == null ? null : () => onDecision!(StatutModerationCommentaire.masque),
                  child: Text(l10n.mediathequeModerationRejeter),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
