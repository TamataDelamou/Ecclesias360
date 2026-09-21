import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/mediatheque_controller.dart';
import '../domain/models/contenu_mediatheque.dart';
import '../domain/models/type_contenu_mediatheque.dart';

IconData _iconePourType(TypeContenuMediatheque type) {
  switch (type) {
    case TypeContenuMediatheque.audio:
      return Icons.headphones_outlined;
    case TypeContenuMediatheque.video:
      return Icons.play_circle_outline;
    case TypeContenuMediatheque.podcast:
      return Icons.podcasts_outlined;
    case TypeContenuMediatheque.ebook:
      return Icons.menu_book_outlined;
    case TypeContenuMediatheque.magazine:
      return Icons.newspaper_outlined;
    case TypeContenuMediatheque.document:
      return Icons.description_outlined;
  }
}

/// Écran « Catalogue médiathèque » (écran mobile 1) + « Recherche
/// thématique » (écran mobile 6) combinés : un champ de recherche filtre
/// le catalogue par thème (RG-XIII-01) ; sans recherche active, la liste
/// complète des contenus publiés est affichée (`watchCatalogue`).
class MediathequeCatalogueScreen extends StatefulWidget {
  const MediathequeCatalogueScreen({super.key});

  @override
  State<MediathequeCatalogueScreen> createState() => _MediathequeCatalogueScreenState();
}

class _MediathequeCatalogueScreenState extends State<MediathequeCatalogueScreen> {
  final _rechercheController = TextEditingController();
  String _motCle = '';

  @override
  void dispose() {
    _rechercheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MediathequeController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mediathequeCatalogueTitre),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimensions.spacingXxl),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
            child: TextField(
              controller: _rechercheController,
              decoration: InputDecoration(
                labelText: l10n.mediathequeRechercheTheme,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _motCle.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() {
                          _rechercheController.clear();
                          _motCle = '';
                        }),
                      ),
              ),
              onSubmitted: (valeur) => setState(() => _motCle = valeur.trim()),
            ),
          ),
        ),
      ),
      body: _motCle.isEmpty
          ? StreamBuilder<List<ContenuMediatheque>>(
              stream: controller.watchCatalogue(),
              builder: (context, snapshot) => _ListeContenus(
                contenus: snapshot.data ?? const <ContenuMediatheque>[],
                messageVide: l10n.mediathequeAucunContenu,
              ),
            )
          : FutureBuilder<List<ContenuMediatheque>>(
              future: controller.rechercherParTheme(_motCle),
              builder: (context, snapshot) => _ListeContenus(
                contenus: snapshot.data ?? const <ContenuMediatheque>[],
                messageVide: l10n.mediathequeAucunResultat,
              ),
            ),
    );
  }
}

class _ListeContenus extends StatelessWidget {
  const _ListeContenus({required this.contenus, required this.messageVide});

  final List<ContenuMediatheque> contenus;
  final String messageVide;

  @override
  Widget build(BuildContext context) {
    if (contenus.isEmpty) {
      return Center(child: Text(messageVide));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      itemCount: contenus.length,
      itemBuilder: (context, index) {
        final contenu = contenus[index];
        return Card(
          child: ListTile(
            leading: Icon(_iconePourType(contenu.typeContenu)),
            title: Text(contenu.titre),
            subtitle: Text(contenu.theme),
            trailing: Text(contenu.dateContenu.toIso8601String().split('T').first),
            onTap: () => context.push(AppRoutes.mediathequeContenu(contenu.id)),
          ),
        );
      },
    );
  }
}
