import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../application/organisation_controller.dart';
import '../../../core/theme/app_dimensions.dart';
import '../domain/models/categorie_confessionnelle.dart';
import '../domain/models/type_noeud.dart';
import '../domain/rules/organisation_acces_rules.dart';
import 'acces_organisation.dart';

/// Écran 3 (Création / édition d'un nœud).
///
/// Création : sans [parentId], seule la racine (siège) peut être créée ;
/// avec [parentId] (venant de « Ajouter un nœud enfant » sur la fiche d'un
/// nœud), le parent est fixé et le type se choisit parmi les types non-siège.
/// Édition ([nodeId] renseigné) : type et rattachement ne sont pas
/// modifiables ici (RG-I-06 passe par un flux de rattachement dédié).
class NodeFormScreen extends StatefulWidget {
  const NodeFormScreen({super.key, this.nodeId, this.parentId});

  final String? nodeId;
  final String? parentId;

  @override
  State<NodeFormScreen> createState() => _NodeFormScreenState();
}

class _NodeFormScreenState extends State<NodeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _codeInterneController = TextEditingController();
  TypeNoeud? _typeChoisi;
  CategorieConfessionnelle? _categorieChoisie;
  bool _initialise = false;

  bool get _estEdition => widget.nodeId != null;

  @override
  void dispose() {
    _nomController.dispose();
    _codeInterneController.dispose();
    super.dispose();
  }

  void _initialiserDepuisNoeudExistant(OrganisationController controller) {
    if (_initialise || !_estEdition) return;
    final noeud = controller.findById(widget.nodeId!);
    if (noeud == null) return;
    _nomController.text = noeud.nom;
    _codeInterneController.text = noeud.codeInterne;
    _typeChoisi = noeud.typeNoeud;
    _categorieChoisie = noeud.categorieConfessionnelle;
    _initialise = true;
  }

  Future<void> _soumettre(OrganisationController controller) async {
    if (!_formKey.currentState!.validate()) return;
    final acteur = context.read<SessionController>().acteur;
    if (acteur == null) return;

    final succes = _estEdition
        ? await controller.modifierInfosNoeud(
            id: widget.nodeId!,
            acteur: acteur,
            nom: _nomController.text.trim(),
            codeInterne: _codeInterneController.text.trim(),
          )
        : await controller.creerNoeud(
            acteur: acteur,
            typeNoeud: widget.parentId == null ? TypeNoeud.siege : _typeChoisi!,
            noeudParentId: widget.parentId,
            nom: _nomController.text.trim(),
            codeInterne: _codeInterneController.text.trim(),
            categorieConfessionnelle: _typeChoisi == TypeNoeud.egliseLocale ? _categorieChoisie : null,
          );

    if (succes && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrganisationController>();
    _initialiserDepuisNoeudExistant(controller);

    // RG-I-03 : seuls les types que le compte peut créer sont proposés.
    final typesDisponibles = TypeNoeud.values
        .where((type) => type != TypeNoeud.siege && peutCreerOuValiderType(context, type))
        .toList();
    final l10n = AppLocalizations.of(context)!;
    // Gardé aussi contre l'accès direct par la route (RG-SEC-04).
    final autorise = _estEdition
        ? OrganisationAccesRules.peutGererNoeuds(context.watch<SessionController>().role)
        : widget.parentId == null
            ? peutCreerOuValiderType(context, TypeNoeud.siege)
            : typesDisponibles.isNotEmpty;
    if (!autorise) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.organisationTitre)),
        body: Center(child: Text(l10n.organisationAccesReserve)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_estEdition ? 'Modifier le nœud' : 'Créer un nœud')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          children: [
            if (!_estEdition && widget.parentId == null)
              const Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.spacingLg),
                child: Text('Ce formulaire crée la racine unique (siège) de la plateforme.'),
              ),
            if (!_estEdition && widget.parentId != null) ...[
              DropdownButtonFormField<TypeNoeud>(
                initialValue: _typeChoisi,
                decoration: const InputDecoration(labelText: 'Type de nœud', border: OutlineInputBorder()),
                items: typesDisponibles
                    .map((type) => DropdownMenuItem(value: type, child: Text(type.code)))
                    .toList(),
                onChanged: (valeur) => setState(() => _typeChoisi = valeur),
                validator: (valeur) => valeur == null ? 'Choisissez un type.' : null,
              ),
              const SizedBox(height: AppDimensions.spacingLg),
            ],
            if (_estEdition && _typeChoisi != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
                child: Text('Type (non modifiable) : ${_typeChoisi!.code}'),
              ),
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
              validator: (valeur) => (valeur == null || valeur.trim().isEmpty) ? 'Le nom est requis.' : null,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            TextFormField(
              controller: _codeInterneController,
              decoration: const InputDecoration(labelText: 'Code interne', border: OutlineInputBorder()),
              validator: (valeur) =>
                  (valeur == null || valeur.trim().isEmpty) ? 'Le code interne est requis.' : null,
            ),
            if (!_estEdition && _typeChoisi == TypeNoeud.egliseLocale) ...[
              const SizedBox(height: AppDimensions.spacingLg),
              DropdownButtonFormField<CategorieConfessionnelle>(
                initialValue: _categorieChoisie,
                decoration: const InputDecoration(
                  labelText: 'Catégorie confessionnelle',
                  border: OutlineInputBorder(),
                ),
                items: CategorieConfessionnelle.values
                    .map((categorie) => DropdownMenuItem(value: categorie, child: Text(categorie.code)))
                    .toList(),
                onChanged: (valeur) => setState(() => _categorieChoisie = valeur),
                validator: (valeur) =>
                    valeur == null ? 'Obligatoire et immuable pour une église locale (RG-I-09).' : null,
              ),
            ],
            if (_estEdition && _categorieChoisie != null) ...[
              const SizedBox(height: AppDimensions.spacingLg),
              Text('Catégorie confessionnelle (immuable) : ${_categorieChoisie!.code}'),
            ],
            const SizedBox(height: AppDimensions.spacingXl),
            if (controller.erreur != null) ...[
              Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: AppDimensions.spacingLg),
            ],
            FilledButton(
              onPressed: controller.enCours ? null : () => _soumettre(controller),
              child: Text(_estEdition ? 'Enregistrer' : 'Créer'),
            ),
          ],
        ),
      ),
    );
  }
}
