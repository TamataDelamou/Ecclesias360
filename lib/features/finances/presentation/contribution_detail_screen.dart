import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../fideles/application/fidele_controller.dart';
import '../application/finances_controller.dart';
import '../domain/models/contribution.dart';
import '../domain/models/statut_contribution.dart';
import '../domain/models/type_offrande.dart';
import 'acces_finances.dart';

/// Fiche d'une contribution — sert à la fois de « Reçu de contribution »
/// (écran dédié du Cahier) et d'écran d'action pour la validation
/// comptable (RG-XI-02), le rejet et la contre-passation (RG-XI-05).
///
/// L'acteur est la session : son rôle et sa fiche liée, tracée comme
/// valideur (jamais un compte sans fiche). Lecture réservée (RG-SEC-06) au
/// pasteur (ou plus), au trésorier du nœud et au donateur.
class ContributionDetailScreen extends StatelessWidget {
  const ContributionDetailScreen({required this.contributionId, super.key});

  final String contributionId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FinancesController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.financesRecuTitre)),
      body: FutureBuilder<Contribution?>(
        future: controller.findContributionById(contributionId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final contribution = snapshot.data;
          if (contribution == null) {
            return Center(child: Text(l10n.financesIntrouvable));
          }
          return AccesFinancesBuilder(
            builder: (context, acces) => acces.peutConsulter(contribution)
                ? _ContributionDetailBody(contribution: contribution, controller: controller, acces: acces)
                : Center(child: Text(l10n.financesAccesReserve)),
          );
        },
      ),
    );
  }
}

class _ContributionDetailBody extends StatefulWidget {
  const _ContributionDetailBody({required this.contribution, required this.controller, required this.acces});

  final Contribution contribution;
  final FinancesController controller;
  final AccesFinances acces;

  @override
  State<_ContributionDetailBody> createState() => _ContributionDetailBodyState();
}

class _ContributionDetailBodyState extends State<_ContributionDetailBody> {
  late Contribution _contribution = widget.contribution;

  Future<void> _rafraichir() async {
    final contribution = await widget.controller.findContributionById(_contribution.id);
    if (mounted && contribution != null) setState(() => _contribution = contribution);
  }

  Future<void> _valider(BuildContext context, String acteurFideleId) async {
    final session = context.read<SessionController>();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.financesValiderTitre),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.financesValiderBouton)),
          ],
        );
      },
    );

    if (confirme == true) {
      await widget.controller.validerContribution(
        id: _contribution.id,
        roleActeur: session.role,
        valideParFideleId: acteurFideleId,
      );
      await _rafraichir();
    }
  }

  Future<void> _rejeter(BuildContext context, String acteurFideleId) async {
    final session = context.read<SessionController>();
    final motifController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.financesRejeterTitre),
          content: TextField(controller: motifController, decoration: InputDecoration(labelText: l10n.financesChampMotif)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.financesRejeterBouton)),
          ],
        );
      },
    );
    if (confirme == true) {
      await widget.controller.rejeterContribution(
        id: _contribution.id,
        roleActeur: session.role,
        rejeteParFideleId: acteurFideleId,
        motifRejet: motifController.text.trim().isNotEmpty ? motifController.text.trim() : null,
      );
      await _rafraichir();
    }
  }

  Future<void> _contrePasser(BuildContext context, String acteurFideleId) async {
    final session = context.read<SessionController>();
    final motifController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.financesContrePasserTitre),
          content: TextField(controller: motifController, decoration: InputDecoration(labelText: l10n.financesChampMotif)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.financesContrePasserBouton)),
          ],
        );
      },
    );
    if (confirme == true) {
      await widget.controller.contrePasserContribution(
        id: _contribution.id,
        roleActeur: session.role,
        valideParFideleId: acteurFideleId,
        motif: motifController.text.trim().isNotEmpty ? motifController.text.trim() : null,
      );
      await _rafraichir();
    }
  }

  /// Décision comptable (RG-XI-02/05) : réservée au pasteur (ou plus) et au
  /// trésorier du nœud, et à un compte lié à sa fiche (valideur tracé).
  List<Widget> _actions(BuildContext context, AppLocalizations l10n) {
    final aDecider = _contribution.statut == StatutContribution.enAttente ||
        (_contribution.statut == StatutContribution.validee && !_contribution.estContrePassation);
    if (!aDecider || !widget.acces.peutGererContributions(_contribution.noeudId)) return const [];
    final acteurFideleId = widget.acces.fideleId;
    if (acteurFideleId == null) return [Text(l10n.authFicheLieeRequise)];
    // RG-XI-02 : séparation stricte — la personne qui a saisi ne décide pas ;
    // la contribution attend une autre personne habilitée (comportement voulu).
    if (_contribution.statut == StatutContribution.enAttente && _contribution.saisieParFideleId == acteurFideleId) {
      return [Text(l10n.financesDecisionParLeSaisissant)];
    }
    if (_contribution.statut == StatutContribution.enAttente) {
      return [
        FilledButton(onPressed: () => _valider(context, acteurFideleId), child: Text(l10n.financesValiderBouton)),
        const SizedBox(height: AppDimensions.spacingSm),
        OutlinedButton(onPressed: () => _rejeter(context, acteurFideleId), child: Text(l10n.financesRejeterBouton)),
      ];
    }
    return [
      OutlinedButton(
        onPressed: () => _contrePasser(context, acteurFideleId),
        child: Text(l10n.financesContrePasserBouton),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fideleController = context.watch<FideleController>();
    final donateurNom = _contribution.fideleId != null
        ? (fideleController.findById(_contribution.fideleId!)?.nomComplet ?? '—')
        : (_contribution.libelleDonateurAnonyme ?? l10n.financesDonateurAnonyme);

    return StreamBuilder<List<TypeOffrande>>(
      stream: widget.controller.watchTypesOffrande(),
      builder: (context, typesSnapshot) {
        final types = typesSnapshot.data ?? const <TypeOffrande>[];
        var typeLibelle = '—';
        for (final type in types) {
          if (type.id == _contribution.typeOffrandeId) {
            typeLibelle = type.libelle;
            break;
          }
        }

        return ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_contribution.montant} ${_contribution.devise}', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppDimensions.spacingSm),
                    Text('${l10n.financesChampDonateur} : $donateurNom'),
                    Text('${l10n.financesChampTypeOffrande} : $typeLibelle'),
                    Text('${l10n.financesChampModePaiement} : ${_contribution.modePaiement}'),
                    Text(l10n.financesSaisieLe(_contribution.dateSaisie.toIso8601String().split('T').first)),
                    if (_contribution.dateValidation != null)
                      Text(l10n.financesValideeLe(_contribution.dateValidation!.toIso8601String().split('T').first)),
                    if (_contribution.motifRejet != null) Text('${l10n.financesChampMotif} : ${_contribution.motifRejet}'),
                    if (_contribution.estContrePassation) Text(l10n.financesEstContrePassation),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            ..._actions(context, l10n),
          ],
        );
      },
    );
  }
}
