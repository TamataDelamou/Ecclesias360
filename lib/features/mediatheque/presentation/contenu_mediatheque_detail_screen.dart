import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../parametres/domain/models/role.dart';
import '../application/mediatheque_controller.dart';
import '../domain/models/commentaire.dart';
import '../domain/models/contenu_mediatheque.dart';
import '../domain/models/favori.dart';
import '../domain/models/statut_moderation_commentaire.dart';
import '../domain/rules/mediatheque_rules.dart';

/// Fiche détaillée d'un contenu (écran mobile 7) + favoris (écran 4,
/// bascule) + commentaires (écran 5) regroupés sur un seul écran. L'auteur
/// des favoris, commentaires et signalements est la fiche liée à la
/// session ; un compte sans fiche (utilisateur simple, RG-SEC-06bis) lit
/// sans agir.
class ContenuMediathequeDetailScreen extends StatefulWidget {
  const ContenuMediathequeDetailScreen({required this.contenuId, super.key});

  final String contenuId;

  @override
  State<ContenuMediathequeDetailScreen> createState() => _ContenuMediathequeDetailScreenState();
}

class _ContenuMediathequeDetailScreenState extends State<ContenuMediathequeDetailScreen> {
  bool _consultationEnregistree = false;
  final _commentaireController = TextEditingController();

  @override
  void dispose() {
    _commentaireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MediathequeController>();
    final session = context.watch<SessionController>();
    final fideleActifId = session.session?.fideleId;
    // Modération (RG-XIII-03) : pasteur ou plus.
    final estModerateur = session.peut(Role.pasteur);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mediathequeFicheTitre)),
      body: StreamBuilder<ContenuMediatheque?>(
        stream: controller.watchContenu(widget.contenuId),
        builder: (context, snapshot) {
          final contenu = snapshot.data;
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (contenu == null) return Center(child: Text(l10n.mediathequeContenuIntrouvable));

          if (!_consultationEnregistree) {
            _consultationEnregistree = true;
            WidgetsBinding.instance.addPostFrameCallback((_) => controller.enregistrerConsultation(contenu.id));
          }

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              Text(contenu.titre, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppDimensions.spacingSm),
              _LigneInfo(label: l10n.mediathequeChampType, valeur: contenu.typeContenu.code),
              _LigneInfo(label: l10n.mediathequeChampTheme, valeur: contenu.theme),
              if (contenu.motsCles.isNotEmpty)
                _LigneInfo(label: l10n.mediathequeChampMotsCles, valeur: contenu.motsCles.join(', ')),
              if (contenu.intervenant != null)
                _LigneInfo(label: l10n.mediathequeChampIntervenant, valeur: contenu.intervenant!),
              _LigneInfo(
                label: l10n.mediathequeChampDate,
                valeur: contenu.dateContenu.toIso8601String().split('T').first,
              ),
              if (contenu.fichier != null)
                _LigneInfo(label: l10n.mediathequeChampFichier, valeur: contenu.fichier!),
              _LigneInfo(
                label: l10n.mediathequeChampConsultations,
                valeur: contenu.compteurConsultations.toString(),
              ),
              const Divider(height: AppDimensions.spacingXxl),
              if (fideleActifId == null)
                Text(l10n.mediathequeLectureSeule)
              else
                StreamBuilder<List<Favori>>(
                  stream: controller.watchFavoris(fideleActifId),
                  builder: (context, favorisSnapshot) {
                    final favoris = favorisSnapshot.data ?? const <Favori>[];
                    final estFavori = favoris.any((f) => f.contenuId == contenu.id);
                    return OutlinedButton.icon(
                      icon: Icon(estFavori ? Icons.favorite : Icons.favorite_border),
                      label: Text(estFavori ? l10n.mediathequeRetirerFavori : l10n.mediathequeAjouterFavori),
                      onPressed: () => controller.toggleFavori(fideleId: fideleActifId, contenuId: contenu.id),
                    );
                  },
                ),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.mediathequeCommentairesTitre, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimensions.spacingSm),
              StreamBuilder<List<Commentaire>>(
                stream: controller.watchCommentaires(contenu.id),
                builder: (context, commentairesSnapshot) {
                  final commentaires = commentairesSnapshot.data ?? const <Commentaire>[];
                  final visibles = commentaires
                      .where(
                        (c) => MediathequeRules.commentaireVisible(
                          statut: c.statutModeration,
                          estAuteur: c.fideleId == fideleActifId,
                          estModerateur: estModerateur,
                        ),
                      )
                      .toList();
                  if (visibles.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSm),
                      child: Text(l10n.mediathequeAucunCommentaire),
                    );
                  }
                  return Column(
                    children: [
                      for (final commentaire in visibles)
                        Card(
                          child: ListTile(
                            title: Text(commentaire.texte),
                            subtitle: Text(
                              commentaire.statutModeration == StatutModerationCommentaire.enAttente
                                  ? l10n.mediathequeCommentaireEnAttente
                                  : commentaire.date.toIso8601String().split('.').first,
                            ),
                            // Signaler : action d'un fidèle enregistré, jamais sur son propre commentaire.
                            trailing: fideleActifId == null || commentaire.fideleId == fideleActifId
                                ? null
                                : IconButton(
                                    icon: const Icon(Icons.flag_outlined),
                                    tooltip: l10n.mediathequeSignalerCommentaire,
                                    onPressed: () => controller.signalerCommentaire(commentaire.id),
                                  ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              if (fideleActifId != null) ...[
                const SizedBox(height: AppDimensions.spacingSm),
                TextField(
                  controller: _commentaireController,
                  decoration: InputDecoration(labelText: l10n.mediathequeChampCommentaire),
                  maxLines: 2,
                ),
                const SizedBox(height: AppDimensions.spacingSm),
                FilledButton(
                  onPressed: () async {
                    final texte = _commentaireController.text.trim();
                    if (texte.isEmpty) return;
                    final ok = await controller.ajouterCommentaire(
                      contenuId: contenu.id,
                      fideleId: fideleActifId,
                      texte: texte,
                    );
                    if (ok) _commentaireController.clear();
                  },
                  child: Text(l10n.mediathequeCommentaireAjouterBouton),
                ),
              ],
              if (controller.erreur != null) ...[
                const SizedBox(height: AppDimensions.spacingLg),
                Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
            ],
          );
        },
      ),
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
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppDimensions.labelColumnWidthNarrow,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}
