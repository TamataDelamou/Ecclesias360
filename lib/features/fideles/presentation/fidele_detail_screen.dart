import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../discipline/presentation/acces_discipline.dart';
import '../../finances/presentation/acces_finances.dart';
import '../../parametres/domain/models/role.dart';
import '../application/fidele_controller.dart';
import '../domain/models/lien_familial.dart';
import '../domain/models/statut_fidele.dart';
import '../domain/models/statut_spirituel.dart';
import '../domain/models/tuteur.dart';
import '../domain/models/type_lien.dart';
import '../domain/rules/fidele_acces_rules.dart';
import '../domain/rules/fidele_rules.dart';

const List<StatutSpirituel> _chaineProgression = [
  StatutSpirituel.visiteur,
  StatutSpirituel.nouveauConverti,
  StatutSpirituel.baptise,
  StatutSpirituel.membreActif,
];

List<StatutSpirituel> _prochainesCibles(StatutSpirituel actuel) {
  final index = _chaineProgression.indexOf(actuel);
  if (index == -1) return const [];
  return [
    if (index + 1 < _chaineProgression.length) _chaineProgression[index + 1],
    StatutSpirituel.membreDecede,
    StatutSpirituel.membreTransfere,
  ];
}

/// Écran 2 (Fiche fidèle) + écran 4 (Cheminement spirituel) + écran 5
/// (Liens familiaux) + écran 12 (Statuts spirituels — actions de
/// transition) regroupés sur un seul écran de synthèse.
class FideleDetailScreen extends StatelessWidget {
  const FideleDetailScreen({required this.fideleId, super.key});

  final String fideleId;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FideleController>();
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();

    // RG-SEC-04/05 : sa propre fiche, ou le rang de gestion (miroir de la policy
    // `fideles`) — vérifié avant l'existence, qui n'est pas révélée ; un accès
    // direct par route ne contourne pas la liste.
    if (!FideleAccesRules.peutConsulterFiche(
      role: session.role,
      fideleId: fideleId,
      fideleIdConsultant: session.session?.fideleId,
    )) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.fidelesTitre)),
        body: Center(child: Text(l10n.fidelesAccesReserve)),
      );
    }

    final fidele = controller.findById(fideleId);
    if (fidele == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.fideleIntrouvableTitre)),
        body: Center(child: Text(l10n.fideleIntrouvableCorps)),
      );
    }

    final estMineur = FideleRules.estMineur(fidele.dateNaissance);
    // Écriture réservée au rang de gestion ; l'auteur tracé est la session (RG-II-05).
    final acteur = session.acteur;
    final gestion = acteur != null && FideleAccesRules.peutGererFideles(acteur.role) ? acteur : null;
    // Administrateur sans fiche (amorçage) : se lie à sa fiche pour être tracé
    // comme une personne du registre lors des validations (RG-XI-02).
    final peutLierSonCompte = session.peut(Role.administrateur) && session.session?.fideleId == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(fidele.nomComplet),
        actions: [
          if (peutLierSonCompte)
            IconButton(
              icon: const Icon(Icons.link),
              tooltip: l10n.authLierMonCompte,
              onPressed: () => _lierMonCompte(context, session, fidele.id, fidele.nomComplet),
            ),
          if (gestion != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: l10n.fideleModifierCoordonnees,
              onPressed: () => _modifierCoordonnees(context, controller, fidele.id, gestion,
                  telephone: fidele.telephone, email: fidele.email, adresse: fidele.adresse),
            ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: l10n.fideleHistoriqueTooltip,
            onPressed: () => context.push(AppRoutes.fideleHistorique(fidele.id)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        children: [
          _LigneInfo(label: l10n.fideleChampSexe, valeur: fidele.sexe.code),
          _LigneInfo(label: l10n.fideleChampStatutCivil, valeur: fidele.statutCivil.code),
          _LigneInfo(
            label: l10n.fideleChampDateNaissance,
            valeur: fidele.dateNaissance.toIso8601String().split('T').first,
          ),
          if (estMineur) _LigneInfo(label: l10n.fideleChampMineur, valeur: l10n.commonOui),
          if (fidele.telephone != null) _LigneInfo(label: l10n.fideleChampTelephone, valeur: fidele.telephone!),
          if (fidele.email != null) _LigneInfo(label: l10n.fideleChampEmail, valeur: fidele.email!),
          if (fidele.adresse != null) _LigneInfo(label: l10n.fideleChampAdresse, valeur: fidele.adresse!),
          const Divider(height: AppDimensions.spacingXxl),
          Text(l10n.fideleCheminementTitre, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppDimensions.spacingSm),
          _LigneInfo(label: l10n.fideleStatutActuel, valeur: fidele.statutSpirituel.code),
          const SizedBox(height: AppDimensions.spacingSm),
          if (gestion != null)
            Wrap(
            spacing: AppDimensions.spacingSm,
            children: _prochainesCibles(fidele.statutSpirituel)
                .map(
                  (cible) => OutlinedButton(
                    onPressed: () =>
                        controller.modifierStatutSpirituel(fideleId: fidele.id, cible: cible, acteur: gestion),
                    child: Text(l10n.fideleTransitionVers(cible.code)),
                  ),
                )
                .toList(),
          ),
          if (fidele.statutSpirituel == StatutSpirituel.membreEnDiscipline)
            Text(
              l10n.fideleStatutDisciplineNote,
            ),
          if (estMineur) ...[
            const Divider(height: AppDimensions.spacingXxl),
            Text(l10n.fideleTuteurLegalTitre, style: Theme.of(context).textTheme.titleMedium),
            _TuteursSection(controller: controller, mineurId: fidele.id, gestion: gestion),
          ],
          const Divider(height: AppDimensions.spacingXxl),
          Text(l10n.fideleLiensFamiliauxTitre, style: Theme.of(context).textTheme.titleMedium),
          _LiensFamiliauxSection(controller: controller, fideleId: fidele.id, gestion: gestion),
          const Divider(height: AppDimensions.spacingXxl),
          OutlinedButton.icon(
            icon: const Icon(Icons.auto_awesome_outlined),
            label: Text(l10n.fideleActionDons),
            onPressed: () => context.push(AppRoutes.donsFidele(fidele.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.work_outline),
            label: Text(l10n.fideleActionCompetences),
            onPressed: () => context.push(AppRoutes.fideleCompetences(fidele.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.groups_2_outlined),
            label: Text(l10n.fideleActionGroupes),
            onPressed: () => context.push(AppRoutes.fideleGroupes(fidele.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          OutlinedButton.icon(
            icon: const Icon(Icons.swap_horiz_outlined),
            label: Text(l10n.deplacementsHistoriqueTitre),
            onPressed: () => context.push(AppRoutes.mutationsDuFidele(fidele.id)),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          // RG-X-05 : historique confidentiel réservé (pasteur ou plus, ou membre d'une commission).
          AccesDisciplineBuilder(
            builder: (context, acces) => !acces.aAcces
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: AppDimensions.spacingSm),
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.balance_outlined),
                      label: Text(l10n.disciplineHistoriqueTitre),
                      onPressed: () => context.push(AppRoutes.disciplineDuFidele(fidele.id)),
                    ),
                  ),
          ),
          // RG-SEC-06 : historique financier réservé au fidèle lui-même, à un
          // pasteur (ou plus) et au trésorier de son nœud.
          AccesFinancesBuilder(
            builder: (context, acces) => !acces.peutConsulterFidele(fideleIdConsulte: fidele.id, noeudDuFidele: fidele.noeudId)
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.volunteer_activism_outlined),
                      label: Text(l10n.financesHistoriqueTitre),
                      onPressed: () => context.push(AppRoutes.financesDuFidele(fidele.id)),
                    ),
                    const SizedBox(height: AppDimensions.spacingSm),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.event_repeat_outlined),
                      label: Text(l10n.financesEngagementsTitre),
                      onPressed: () => context.push(AppRoutes.engagementsDuFidele(fidele.id)),
                    ),
                    const SizedBox(height: AppDimensions.spacingSm),
                    ],
                  ),
          ),
          // Favoris : visibles du seul fidèle concerné (policy favoris_proprietaire).
          if (session.session?.fideleId == fidele.id) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.favorite_border),
              label: Text(l10n.mediathequeFavorisTitre),
              onPressed: () => context.push(AppRoutes.mediathequeFavorisDuFidele(fidele.id)),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
          ],
          if (gestion != null && fidele.statut != StatutFidele.inactif)
            OutlinedButton.icon(
              icon: const Icon(Icons.archive_outlined),
              label: Text(l10n.fideleActionArchiver),
              onPressed: () => controller.archiverFidele(fidele.id, acteur: gestion),
            ),
          if (controller.erreur != null) ...[
            const SizedBox(height: AppDimensions.spacingLg),
            Text(controller.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
    );
  }
}

Future<void> _lierMonCompte(BuildContext context, SessionController session, String fideleId, String nom) async {
  final l10n = AppLocalizations.of(context)!;
  final messenger = ScaffoldMessenger.of(context);
  final confirme = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.authLierMonCompte),
      content: Text(l10n.authLierMonCompteConfirmation(nom)),
      actions: [
        TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
        FilledButton(onPressed: () => context.pop(true), child: Text(l10n.authLierMonCompteBouton)),
      ],
    ),
  );
  if (confirme != true) return;
  final lie = await session.lierMonCompteAFiche(fideleId);
  messenger.showSnackBar(SnackBar(content: Text(lie ? l10n.authLierMonCompteFait : session.erreur ?? '')));
}

Future<void> _modifierCoordonnees(
  BuildContext context,
  FideleController controller,
  String fideleId,
  Acteur acteur, {
  String? telephone,
  String? email,
  String? adresse,
}) async {
  final telephoneController = TextEditingController(text: telephone);
  final emailController = TextEditingController(text: email);
  final adresseController = TextEditingController(text: adresse);

  final confirme = await showDialog<bool>(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return AlertDialog(
        title: Text(l10n.fideleModifierCoordonnees),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: telephoneController, decoration: InputDecoration(labelText: l10n.fideleChampTelephone)),
            TextField(controller: emailController, decoration: InputDecoration(labelText: l10n.fideleChampEmail)),
            TextField(controller: adresseController, decoration: InputDecoration(labelText: l10n.fideleChampAdresse)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
          FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonEnregistrer)),
        ],
      );
    },
  );

  if (confirme == true) {
    await controller.modifierCoordonnees(
      fideleId: fideleId,
      acteur: acteur,
      telephone: telephoneController.text.trim(),
      email: emailController.text.trim(),
      adresse: adresseController.text.trim(),
    );
  }
}

class _LigneInfo extends StatelessWidget {
  const _LigneInfo({required this.label, required this.valeur});

  final String label;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppDimensions.labelColumnWidthNarrow,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}

class _TuteursSection extends StatelessWidget {
  const _TuteursSection({required this.controller, required this.mineurId, required this.gestion});

  final FideleController controller;
  final String mineurId;

  /// Acteur habilité à modifier ; `null` : lecture seule.
  final Acteur? gestion;

  Future<void> _ajouterTuteurTiers(BuildContext context) async {
    final nomController = TextEditingController();
    final lienController = TextEditingController();
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.fideleAjouterTuteurTitre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomController, decoration: InputDecoration(labelText: l10n.fideleChampNomTuteur)),
              TextField(controller: lienController, decoration: InputDecoration(labelText: l10n.fideleChampLienTuteur)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
            FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonAjouter)),
          ],
        );
      },
    );
    if (confirme == true && nomController.text.trim().isNotEmpty && lienController.text.trim().isNotEmpty) {
      await controller.ajouterTuteur(
        acteur: gestion!,
        mineurId: mineurId,
        lien: lienController.text.trim(),
        tuteurTiersNom: nomController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<Tuteur>>(
      stream: controller.watchTuteurs(mineurId),
      builder: (context, snapshot) {
        final tuteurs = snapshot.data ?? const <Tuteur>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final tuteur in tuteurs)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(tuteur.tuteurTiersNom ?? tuteur.tuteurFideleId ?? '—'),
                subtitle: Text(tuteur.lien),
              ),
            if (gestion != null)
              TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.fideleAjouterTuteurBouton),
              onPressed: () => _ajouterTuteurTiers(context),
            ),
          ],
        );
      },
    );
  }
}

class _LiensFamiliauxSection extends StatelessWidget {
  const _LiensFamiliauxSection({required this.controller, required this.fideleId, required this.gestion});

  final FideleController controller;
  final String fideleId;

  /// Acteur habilité à modifier ; `null` : lecture seule.
  final Acteur? gestion;

  Future<void> _ajouterLien(BuildContext context) async {
    final autresFideles = controller.fideles.where((f) => f.id != fideleId).toList();
    if (autresFideles.isEmpty) return;

    String? autreId = autresFideles.first.id;
    TypeLien type = TypeLien.conjoint;

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.fideleAjouterLienTitre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: autreId,
                  items: autresFideles
                      .map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet)))
                      .toList(),
                  onChanged: (valeur) => setState(() => autreId = valeur),
                ),
                DropdownButtonFormField<TypeLien>(
                  initialValue: type,
                  items: TypeLien.values
                      .map((t) => DropdownMenuItem(value: t, child: Text(t.code)))
                      .toList(),
                  onChanged: (valeur) => setState(() => type = valeur ?? TypeLien.conjoint),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => context.pop(false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => context.pop(true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );

    if (confirme == true && autreId != null) {
      await controller.ajouterLienFamilial(acteur: gestion!, fideleId1: fideleId, fideleId2: autreId!, typeLien: type);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<LienFamilial>>(
      stream: controller.watchLiensFamiliaux(fideleId),
      builder: (context, snapshot) {
        final liens = snapshot.data ?? const <LienFamilial>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final lien in liens)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  controller.findById(lien.fideleId1 == fideleId ? lien.fideleId2 : lien.fideleId1)?.nomComplet ??
                      '—',
                ),
                subtitle: Text(lien.typeLien.code),
                trailing: gestion == null
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => controller.retirerLienFamilial(lien.id, acteur: gestion!),
                      ),
              ),
            if (gestion != null)
              TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.fideleAjouterLienBouton),
              onPressed: () => _ajouterLien(context),
            ),
          ],
        );
      },
    );
  }
}
