import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/error/app_error.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/archivage_controller.dart';
import '../domain/models/document_archive.dart';
import '../domain/models/niveau_confidentialite.dart';
import '../domain/models/statut_document_archive.dart';
import '../domain/models/version_document.dart';

/// Écrans « Consultation d'un document » + « Historique des versions »
/// (RG-VIII-02) combinés. La navigation croisée vers l'objet métier d'origine
/// (RG-VIII-04) reste une simple mention (module/objet) pour cette itération :
/// une redirection cliquable suppose un registre de routes par module
/// producteur, non construit tant que peu de producteurs existent.
///
/// RG-VIII-03 / RG-SEC-06 : la lecture passe par `ArchivageController.consulter`,
/// qui refuse un document non consultable (y compris par accès direct à la
/// route) et journalise la lecture d'une pièce disciplinaire. Lancée une
/// seule fois (`initState`) : une reconstruction de l'écran n'est pas une
/// nouvelle consultation.
class DocumentArchiveDetailScreen extends StatefulWidget {
  const DocumentArchiveDetailScreen({required this.documentId, super.key});

  final String documentId;

  @override
  State<DocumentArchiveDetailScreen> createState() => _DocumentArchiveDetailScreenState();
}

class _DocumentArchiveDetailScreenState extends State<DocumentArchiveDetailScreen> {
  late final Future<DocumentArchive?> _consultation;

  @override
  void initState() {
    super.initState();
    final session = context.read<SessionController>().session;
    _consultation = session == null
        ? Future.error(AppError.documentArchiveAccesRefuse())
        : context.read<ArchivageController>().consulter(
            documentId: widget.documentId,
            authUserId: session.authUserId,
            fideleId: session.fideleId,
            role: session.role,
          );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ArchivageController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.archivageDetailTitre)),
      body: FutureBuilder<DocumentArchive?>(
        future: _consultation,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text(l10n.archivageAccesReserve));
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final document = snapshot.data;
          if (document == null) return Center(child: Text(l10n.archivageDocumentIntrouvable));

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              Text(document.numeroArchive, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppDimensions.spacingSm),
              Wrap(
                spacing: AppDimensions.spacingSm,
                children: [
                  Chip(label: Text(document.typeDocument)),
                  Chip(
                    avatar: Icon(
                      document.niveauConfidentialite == NiveauConfidentialite.restreint
                          ? Icons.lock_outline
                          : Icons.lock_open_outlined,
                      size: 18,
                    ),
                    label: Text(
                      document.niveauConfidentialite == NiveauConfidentialite.restreint
                          ? l10n.archivageNiveauRestreint
                          : l10n.archivageNiveauStandard,
                    ),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.spacingXxl),
              Text(l10n.archivageOrigineLabel, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimensions.spacingXs),
              Text('${document.moduleOrigine} · ${document.objetIdOrigine}'),
              const Divider(height: AppDimensions.spacingXxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.archivageVersionsTitre, style: Theme.of(context).textTheme.titleMedium),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text(l10n.archivageNouvelleVersionBouton),
                    onPressed: () => _ajouterVersion(context, controller, document.id),
                  ),
                ],
              ),
              _VersionsList(controller: controller, documentId: document.id),
              const Divider(height: AppDimensions.spacingXxl),
              if (document.statut == StatutDocumentArchive.actif)
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.archivageMettreEnCorbeilleBouton),
                  onPressed: () async {
                    await controller.mettreEnCorbeille(document.id);
                    if (context.mounted) context.pop();
                  },
                )
              else
                OutlinedButton.icon(
                  icon: const Icon(Icons.restore_from_trash_outlined),
                  label: Text(l10n.archivageRestaurerBouton),
                  onPressed: () async {
                    await controller.restaurerDeCorbeille(document.id);
                    if (context.mounted) context.pop();
                  },
                ),
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

  Future<void> _ajouterVersion(BuildContext context, ArchivageController controller, String documentId) async {
    final fichierController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.archivageNouvelleVersionTitre),
          content: TextField(
            controller: fichierController,
            decoration: InputDecoration(labelText: l10n.archivageChampReferenceFichier),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
          ],
        );
      },
    );

    if (confirme == true && fichierController.text.trim().isNotEmpty) {
      await controller.nouvelleVersion(documentId: documentId, fichier: fichierController.text.trim());
    }
  }
}

class _VersionsList extends StatelessWidget {
  const _VersionsList({required this.controller, required this.documentId});

  final ArchivageController controller;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<VersionDocument>>(
      stream: controller.watchVersions(documentId),
      builder: (context, snapshot) {
        final versions = snapshot.data ?? const <VersionDocument>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < versions.length; i++)
              StaggeredFadeIn(
                index: i,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Text('${versions[i].numeroVersion}')),
                  title: Text(l10n.archivageVersionLabel(versions[i].numeroVersion)),
                  subtitle: Text(versions[i].fichier),
                ),
              ),
          ],
        );
      },
    );
  }
}
