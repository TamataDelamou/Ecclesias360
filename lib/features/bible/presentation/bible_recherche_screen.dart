import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/bible_controller.dart';
import '../domain/models/livre_biblique.dart';
import '../domain/rules/bible_reference_rules.dart';

/// Écran 2 du Module XXIV — recherche par mot-clé (RG-XXIV-05), sur l'index
/// local de la version courante, hors connexion. Une saisie qui est une
/// référence (« Jn 3:16 ») propose d'y aller directement. L'écran l'indique
/// explicitement : une future recherche élargie (en ligne) devra rester
/// visuellement distincte.
class BibleRechercheScreen extends StatefulWidget {
  const BibleRechercheScreen({super.key});

  @override
  State<BibleRechercheScreen> createState() => _BibleRechercheScreenState();
}

class _BibleRechercheScreenState extends State<BibleRechercheScreen> {
  final _champ = TextEditingController();
  String _saisie = '';
  List<VersetBiblique> _resultats = const [];
  int _requete = 0;

  @override
  void dispose() {
    _champ.dispose();
    super.dispose();
  }

  Future<void> _rechercher(String saisie) async {
    final numero = ++_requete;
    final resultats = await context.read<BibleController>().rechercher(saisie);
    // Seule la dernière frappe fait foi.
    if (!mounted || numero != _requete) return;
    setState(() {
      _saisie = saisie;
      _resultats = resultats;
    });
  }

  void _ouvrir(ReferenceBiblique reference) => context.push(AppRoutes.bibleLecture(reference));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<BibleController>();
    final reference = BibleReferenceRules.lire(_saisie, controller.livres);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.bibleRechercheTitre)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            child: TextField(
              controller: _champ,
              autofocus: true,
              decoration: InputDecoration(
                labelText: l10n.bibleRechercheChamp,
                prefixIcon: const Icon(Icons.search),
                helperText: l10n.bibleRechercheLocale(controller.version?.nom ?? ''),
              ),
              onChanged: _rechercher,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (reference != null)
                  ListTile(
                    leading: const Icon(Icons.menu_book_outlined),
                    title: Text(l10n.bibleOuvrirReference(
                      '${controller.nomDuLivre(reference.bookId)} ${reference.chapitre}'
                      '${reference.verset == null ? '' : ':${reference.verset}'}',
                    )),
                    onTap: () => _ouvrir(reference),
                  ),
                if (_saisie.trim().length >= 2 && _resultats.isEmpty && reference == null)
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingLg),
                    child: Text(l10n.bibleRechercheAucun),
                  ),
                for (final v in _resultats)
                  ListTile(
                    title: Text('${controller.nomDuLivre(v.bookId)} ${v.chapitre}:${v.verset}'),
                    subtitle: Text(v.texte),
                    onTap: () => _ouvrir(ReferenceBiblique(bookId: v.bookId, chapitre: v.chapitre, verset: v.verset)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
