import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/bible_controller.dart';
import '../domain/models/livre_biblique.dart';

/// Carte « Verset du jour » (Module XXIV, `VersetDuJourRules`) : lue dans la
/// version courante ; un appui ouvre le passage dans le lecteur.
class VersetDuJourCarte extends StatefulWidget {
  const VersetDuJourCarte({super.key});

  @override
  State<VersetDuJourCarte> createState() => _VersetDuJourCarteState();
}

class _VersetDuJourCarteState extends State<VersetDuJourCarte> {
  late final Future<VersetBiblique?> _verset;

  @override
  void initState() {
    super.initState();
    final controller = context.read<BibleController>();
    _verset = controller.initialiser().then((_) => controller.versetDuJour(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.read<BibleController>();
    return FutureBuilder<VersetBiblique?>(
      future: _verset,
      builder: (context, snapshot) {
        final verset = snapshot.data;
        if (verset == null) return const SizedBox.shrink();
        final reference = '${controller.nomDuLivre(verset.bookId)} ${verset.chapitre}:${verset.verset}';
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            onTap: () => context.push(
              AppRoutes.bibleLecture(ReferenceBiblique(bookId: verset.bookId, chapitre: verset.chapitre, verset: verset.verset)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.bibleVersetDuJour, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: AppDimensions.spacingSm),
                  Text(verset.texte, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: AppDimensions.spacingXs),
                  Text(reference, style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
