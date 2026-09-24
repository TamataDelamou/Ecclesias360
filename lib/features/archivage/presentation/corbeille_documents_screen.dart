import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_defaults.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../discipline/presentation/acces_discipline.dart';
import '../../parametres/domain/models/role.dart';
import '../application/archivage_controller.dart';
import '../domain/models/document_archive.dart';
import '../domain/rules/archivage_rules.dart';
import 'acces_archivage.dart';

/// Écrans « Corbeille documentaire » + « Corbeille et purge » (RG-VIII-05).
class CorbeilleDocumentsScreen extends StatelessWidget {
  const CorbeilleDocumentsScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ArchivageController>();
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();

    // Gardé aussi contre l'accès direct par la route (RG-SEC-06).
    if (!peutOuvrirArchives(session)) {
      return EcranArchivesAccesReserve(titre: l10n.archivageCorbeilleTitre);
    }
    // RG-VIII-05 : purge réservée à un pasteur (policy documents_archive_purge).
    final peutPurger = session.peut(Role.pasteur);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.archivageCorbeilleTitre)),
      body: AccesDisciplineBuilder(
        builder: (context, acces) => StreamBuilder<List<DocumentArchive>>(
          stream: controller.watchCorbeille(noeudId: noeudId),
          builder: (context, snapshot) {
            // RG-VIII-03 / RG-X-05 : un document non consultable n'est pas listé.
            final documents = (snapshot.data ?? const <DocumentArchive>[])
                .where((d) => documentVisible(acces, d))
                .toList(growable: false);
            if (documents.isEmpty) {
              return Center(child: Text(l10n.archivageAucunDansCorbeille));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              itemCount: documents.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingSm),
              itemBuilder: (context, index) {
                final document = documents[index];
                final maintenant = DateTime.now();
                final purgeable =
                    document.dateMiseCorbeille != null &&
                    ArchivageRules.estPurgeable(
                      dateMiseCorbeille: document.dateMiseCorbeille!,
                      delaiPurgeJours: AppDefaults.archivageDelaiPurgeJoursParDefaut,
                      maintenant: maintenant,
                    );

                return StaggeredFadeIn(
                  index: index,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(document.numeroArchive, style: Theme.of(context).textTheme.titleSmall),
                          if (document.dateMiseCorbeille != null)
                            Text(
                              l10n.archivageMiseCorbeilleLe(document.dateMiseCorbeille!.toString().split('.').first),
                            ),
                          if (!purgeable && document.dateMiseCorbeille != null)
                            Text(
                              l10n.archivagePurgeableApres(
                                document.dateMiseCorbeille!
                                    .add(Duration(days: AppDefaults.archivageDelaiPurgeJoursParDefaut))
                                    .toString()
                                    .split(' ')
                                    .first,
                              ),
                            ),
                          const SizedBox(height: AppDimensions.spacingSm),
                          Wrap(
                            spacing: AppDimensions.spacingSm,
                            children: [
                              OutlinedButton.icon(
                                icon: const Icon(Icons.restore_from_trash_outlined),
                                label: Text(l10n.archivageRestaurerBouton),
                                onPressed: () => controller.restaurerDeCorbeille(document.id),
                              ),
                              if (peutPurger)
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.delete_forever_outlined),
                                  label: Text(l10n.archivagePurgerBouton),
                                  onPressed: purgeable ? () => _confirmerPurge(context, controller, document.id) : null,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmerPurge(BuildContext context, ArchivageController controller, String id) async {
    final roleActeur = context.read<SessionController>().role;
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.archivagePurgerConfirmationTitre),
          content: Text(l10n.archivagePurgerConfirmationMessage),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.archivagePurgerBouton)),
          ],
        );
      },
    );
    if (confirme == true) {
      await controller.purgerDefinitivement(
        id,
        delaiPurgeJours: AppDefaults.archivageDelaiPurgeJoursParDefaut,
        roleActeur: roleActeur,
      );
    }
  }
}
