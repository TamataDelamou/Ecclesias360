import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/mediatheque_controller.dart';
import '../domain/models/contenu_mediatheque.dart';
import '../domain/models/favori.dart';

/// Écran « Favoris » (écran mobile 4, RG-XIII-04) : contenus marqués en
/// favori par un fidèle. Le dépôt n'indexant les favoris que par
/// `fideleId`, chaque contenu est résolu individuellement via
/// `watchContenu` (liste de favoris toujours courte en pratique).
class FavorisMediathequeScreen extends StatelessWidget {
  const FavorisMediathequeScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MediathequeController>();
    final l10n = AppLocalizations.of(context)!;
    // Les favoris d'un fidèle ne sont visibles que de lui (policy
    // `favoris_proprietaire`, 0019).
    if (context.watch<SessionController>().session?.fideleId != fideleId) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.mediathequeFavorisTitre)),
        body: Center(child: Text(l10n.mediathequeFavorisReserves)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mediathequeFavorisTitre)),
      body: StreamBuilder<List<Favori>>(
        stream: controller.watchFavoris(fideleId),
        builder: (context, snapshot) {
          final favoris = snapshot.data ?? const <Favori>[];
          if (favoris.isEmpty) {
            return Center(child: Text(l10n.mediathequeFavorisAucun));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            itemCount: favoris.length,
            itemBuilder: (context, index) => StreamBuilder<ContenuMediatheque?>(
              stream: controller.watchContenu(favoris[index].contenuId),
              builder: (context, contenuSnapshot) {
                final contenu = contenuSnapshot.data;
                if (contenu == null) return const SizedBox.shrink();
                return Card(
                  child: ListTile(
                    title: Text(contenu.titre),
                    subtitle: Text(contenu.theme),
                    onTap: () => context.push(AppRoutes.mediathequeContenu(contenu.id)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
