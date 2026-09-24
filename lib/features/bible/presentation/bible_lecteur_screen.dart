import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/bible_controller.dart';
import '../domain/models/livre_biblique.dart';
import 'bible_versions_sheet.dart';

/// Écran 1 du Module XXIV — lecture (Version / Livre / Chapitre / Verset).
/// Accessible sans compte (RG-SEC-06bis amendé). Navigation (dossier de
/// reconstruction §4) : bouton retour explicite, nom du livre cliquable vers
/// ses chapitres, tiroir latéral des chapitres du livre courant.
class BibleLecteurScreen extends StatefulWidget {
  const BibleLecteurScreen({this.reference, super.key});

  /// Passage à ouvrir (lien depuis la recherche ou le verset du jour).
  final ReferenceBiblique? reference;

  @override
  State<BibleLecteurScreen> createState() => _BibleLecteurScreenState();
}

class _BibleLecteurScreenState extends State<BibleLecteurScreen> {
  final _cleScaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final controller = context.read<BibleController>();
    final reference = widget.reference;
    controller.initialiser(reference: reference).then((_) {
      if (reference != null && controller.pret && controller.reference != reference) controller.allerA(reference);
    });
  }

  /// Bouton retour explicite : page précédente si elle existe, sinon
  /// l'accueil (connecté) ou l'écran de connexion (lecture sans compte).
  void _retour() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(context.read<SessionController>().estConnecte ? AppRoutes.home : AppRoutes.connexion);
    }
  }

  Future<void> _choisirChapitre(BibleController controller, LivreBiblique livre) async {
    final l10n = AppLocalizations.of(context)!;
    final choix = await showModalBottomSheet<Object>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ChapitresSheet(livre: livre, l10n: l10n),
    );
    if (!mounted) return;
    if (choix is int) {
      await controller.allerA(ReferenceBiblique(bookId: livre.bookId, chapitre: choix));
    } else if (choix == _ChapitresSheet.changerDeLivre) {
      final autre = await showModalBottomSheet<LivreBiblique>(
        context: context,
        isScrollControlled: true,
        builder: (context) => _LivresSheet(livres: controller.livres, l10n: l10n),
      );
      if (autre != null && mounted) await _choisirChapitre(controller, autre);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<BibleController>();
    final livre = controller.livreCourant;
    final reference = controller.reference;

    return Scaffold(
      key: _cleScaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const BackButtonIcon(), tooltip: l10n.bibleRetour, onPressed: _retour),
        title: livre == null || reference == null
            ? Text(l10n.bibleTitre)
            : InkWell(
                key: const ValueKey('bible-titre-livre'),
                onTap: () => _choisirChapitre(controller, livre),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text('${livre.nom} ${reference.chapitre}', overflow: TextOverflow.ellipsis)),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
        actions: [
          if (controller.version != null)
            TextButton(
              onPressed: () => afficherVersionsBibliques(context),
              child: Text(controller.version!.nom),
            ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: l10n.bibleRechercheTitre,
            onPressed: () => context.push(AppRoutes.bibleRecherche),
          ),
          IconButton(
            icon: const Icon(Icons.format_list_numbered),
            tooltip: l10n.bibleAfficherChapitres,
            onPressed: () => _cleScaffold.currentState?.openDrawer(),
          ),
        ],
      ),
      drawer: livre == null
          ? null
          : Drawer(
              child: SafeArea(
                child: ListView(
                  children: [
                    ListTile(title: Text(livre.nom, style: Theme.of(context).textTheme.titleMedium)),
                    for (var c = 1; c <= livre.nbChapitres; c++)
                      ListTile(
                        title: Text(l10n.bibleChapitre(c)),
                        selected: reference?.chapitre == c,
                        onTap: () {
                          Navigator.of(context).pop();
                          controller.allerA(ReferenceBiblique(bookId: livre.bookId, chapitre: c));
                        },
                      ),
                  ],
                ),
              ),
            ),
      body: _corps(context, controller, l10n),
      bottomNavigationBar: controller.pret
          ? BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    tooltip: l10n.bibleChapitrePrecedent,
                    onPressed: controller.chapitrePrecedent,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    tooltip: l10n.bibleChapitreSuivant,
                    onPressed: controller.chapitreSuivant,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _corps(BuildContext context, BibleController controller, AppLocalizations l10n) {
    if (controller.erreur != null && !controller.pret) {
      return Center(child: Text(l10n.bibleChargementErreur(controller.erreur!)));
    }
    if (!controller.pret) return const Center(child: CircularProgressIndicator());
    final surligne = controller.reference?.verset;
    final theme = Theme.of(context);
    return ListView.builder(
      key: ValueKey(controller.reference),
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      itemCount: controller.versets.length,
      itemBuilder: (context, index) {
        final verset = controller.versets[index];
        return Container(
          color: verset.verset == surligne ? theme.colorScheme.primaryContainer : null,
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${verset.verset} ',
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                ),
                TextSpan(text: verset.texte, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChapitresSheet extends StatelessWidget {
  const _ChapitresSheet({required this.livre, required this.l10n});

  static const changerDeLivre = 'changer-de-livre';

  final LivreBiblique livre;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(livre.nom, style: Theme.of(context).textTheme.titleMedium)),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(changerDeLivre),
                  child: Text(l10n.bibleChangerDeLivre),
                ),
              ],
            ),
            Flexible(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 6,
                children: [
                  for (var c = 1; c <= livre.nbChapitres; c++)
                    TextButton(onPressed: () => Navigator.of(context).pop(c), child: Text('$c')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LivresSheet extends StatelessWidget {
  const _LivresSheet({required this.livres, required this.l10n});

  final List<LivreBiblique> livres;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (context, defilement) => ListView(
        controller: defilement,
        children: [
          ListTile(title: Text(l10n.bibleLivresTitre, style: Theme.of(context).textTheme.titleMedium)),
          for (final livre in livres)
            ListTile(
              title: Text(livre.nom),
              trailing: Text(livre.abreviation),
              onTap: () => Navigator.of(context).pop(livre),
            ),
        ],
      ),
    );
  }
}
