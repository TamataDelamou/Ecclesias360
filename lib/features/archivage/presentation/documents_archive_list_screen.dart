import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/staggered_fade_in.dart';
import '../../../l10n/app_localizations.dart';
import '../application/archivage_controller.dart';
import '../domain/models/document_archive.dart';
import '../domain/models/niveau_confidentialite.dart';

/// Écrans « Bibliothèque documentaire » + « Recherche documentaire » (RG-VIII-04),
/// scopés par nœud — point d'entrée vers la fiche détaillée d'un document.
/// La recherche filtre localement le flux déjà observé (numéro/type), sans
/// aller-retour supplémentaire au dépôt.
class DocumentsArchiveListScreen extends StatefulWidget {
  const DocumentsArchiveListScreen({required this.noeudId, super.key});

  final String noeudId;

  @override
  State<DocumentsArchiveListScreen> createState() => _DocumentsArchiveListScreenState();
}

class _DocumentsArchiveListScreenState extends State<DocumentsArchiveListScreen> {
  final _rechercheController = TextEditingController();
  String _requete = '';

  @override
  void dispose() {
    _rechercheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ArchivageController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.archivageBibliothequeTitre),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: l10n.archivageCorbeilleTitre,
            onPressed: () => context.push(AppRoutes.documentsCorbeille(widget.noeudId)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            child: TextField(
              controller: _rechercheController,
              onChanged: (valeur) => setState(() => _requete = valeur.trim().toLowerCase()),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: l10n.archivageRechercheLabel,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMd)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<DocumentArchive>>(
              stream: controller.watchBibliotheque(noeudId: widget.noeudId),
              builder: (context, snapshot) {
                var documents = snapshot.data ?? const <DocumentArchive>[];
                if (_requete.isNotEmpty) {
                  documents = documents
                      .where(
                        (d) =>
                            d.numeroArchive.toLowerCase().contains(_requete) ||
                            d.typeDocument.toLowerCase().contains(_requete),
                      )
                      .toList(growable: false);
                }
                if (documents.isEmpty) {
                  return Center(child: Text(l10n.archivageAucunDocument));
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
                  itemCount: documents.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spacingSm),
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return StaggeredFadeIn(
                      index: index,
                      child: Card(
                        child: ListTile(
                          leading: Icon(
                            document.niveauConfidentialite == NiveauConfidentialite.restreint
                                ? Icons.lock_outline
                                : Icons.description_outlined,
                          ),
                          title: Text(document.numeroArchive),
                          subtitle: Text(document.typeDocument),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(AppRoutes.documentArchive(document.id)),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
