import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../parametres/application/capacites_controller.dart';
import '../application/organisation_controller.dart';
import '../domain/models/categorie_confessionnelle.dart';
import 'acces_organisation.dart';

/// Écran 9 (Annuaire des Églises, filtrable par catégorie confessionnelle,
/// RG-I-09).
class ChurchDirectoryScreen extends StatefulWidget {
  const ChurchDirectoryScreen({super.key});

  @override
  State<ChurchDirectoryScreen> createState() => _ChurchDirectoryScreenState();
}

class _ChurchDirectoryScreenState extends State<ChurchDirectoryScreen> {
  CategorieConfessionnelle? _filtre;

  @override
  Widget build(BuildContext context) {
    // RG-I-09 : annuaire réservé à la capacité consulter_annuaire_eglises (roles.json).
    if (!capaciteAccordee(context, Capacites.consulterAnnuaireEglises)) {
      return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.organisationTitre)),
        body: Center(child: Text(AppLocalizations.of(context)!.organisationAccesReserve)),
      );
    }
    final controller = context.watch<OrganisationController>();
    final eglises = controller.annuaireEglises(filtre: _filtre);

    return Scaffold(
      appBar: AppBar(title: const Text('Annuaire des Églises')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            child: SegmentedButton<CategorieConfessionnelle?>(
              segments: const [
                ButtonSegment(value: null, label: Text('Toutes')),
                ButtonSegment(value: CategorieConfessionnelle.catholique, label: Text('Catholique')),
                ButtonSegment(value: CategorieConfessionnelle.autres, label: Text('Autres')),
              ],
              selected: {_filtre},
              onSelectionChanged: (selection) => setState(() => _filtre = selection.first),
            ),
          ),
          Expanded(
            child: eglises.isEmpty
                ? const Center(child: Text('Aucune église locale ne correspond à ce filtre.'))
                : ListView.builder(
                    itemCount: eglises.length,
                    itemBuilder: (context, index) {
                      final eglise = eglises[index];
                      return ListTile(
                        title: Text(eglise.nom),
                        subtitle: Text(
                          '${eglise.codeInterne} · ${eglise.categorieConfessionnelle!.code}',
                        ),
                        onTap: () => context.push(AppRoutes.organisationNoeud(eglise.id)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
