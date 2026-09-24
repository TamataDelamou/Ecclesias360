import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/bible_controller.dart';
import '../domain/models/version_biblique.dart';

/// Écran 11 du Module XXIV — versions et téléchargement hors ligne
/// (RG-XXIV-01) : la version embarquée est toujours disponible ; les autres
/// se téléchargent à la demande puis se lisent sans connexion. Chaque
/// version affiche son édition exacte et sa licence.
Future<void> afficherVersionsBibliques(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _VersionsSheet(),
    );

class _VersionsSheet extends StatelessWidget {
  const _VersionsSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<BibleController>();
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          Text(l10n.bibleVersionsTitre, style: Theme.of(context).textTheme.titleMedium),
          if (controller.erreur != null && controller.pret)
            Padding(
              padding: const EdgeInsets.only(top: AppDimensions.spacingSm),
              child: Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          for (final version in controller.versions) _VersionTile(version: version),
        ],
      ),
    );
  }
}

class _VersionTile extends StatelessWidget {
  const _VersionTile({required this.version});

  final VersionBiblique version;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<BibleController>();
    final courante = controller.version?.code == version.code;
    final disponible = controller.estDisponible(version);
    final progression = controller.progression(version.code);

    final Widget action;
    if (progression != null) {
      action = SizedBox(
        width: 48,
        child: CircularProgressIndicator(value: progression == 0 ? null : progression),
      );
    } else if (disponible) {
      action = courante ? const Icon(Icons.check) : const Icon(Icons.chevron_right);
    } else {
      action = TextButton(
        onPressed: () => controller.installer(version),
        child: Text(l10n.bibleVersionTelecharger((version.taille / 1024 / 1024).toStringAsFixed(1))),
      );
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      selected: courante,
      title: Text(version.nom),
      subtitle: Text(
        '${version.embarquee ? l10n.bibleVersionEmbarquee : disponible ? l10n.bibleVersionDisponible : l10n.bibleVersionADemande}\n'
        '${l10n.bibleEditionLicence(version.edition, version.licence)}',
      ),
      isThreeLine: true,
      trailing: action,
      onTap: disponible && !courante
          ? () async {
              await controller.changerVersion(version);
              if (context.mounted) Navigator.of(context).pop();
            }
          : null,
    );
  }
}
