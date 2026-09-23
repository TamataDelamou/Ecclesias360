import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../fideles/application/fidele_controller.dart';
import '../../fideles/domain/models/fidele.dart';
import '../application/session_controller.dart';
import '../domain/models/entree_journal_liaison.dart';
import '../domain/models/issue_liaison.dart';
import '../domain/rules/identifiant_rules.dart';
import '../domain/rules/liaison_compte_rules.dart';

/// RG-SEC-01 — journal des liaisons compte ↔ fiche fidèle (qui, quand,
/// quelle fiche) et résolution des conflits (correspondance multiple, fiche
/// déjà liée) par un administrateur. Accès réservé : l'entrée n'apparaît
/// dans les Paramètres que pour un administrateur, et la résolution est
/// revérifiée par le dépôt.
class LiaisonsComptesScreen extends StatelessWidget {
  const LiaisonsComptesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();
    final fideles = context.watch<FideleController>().fideles;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authLiaisonsTitre)),
      body: StreamBuilder<List<EntreeJournalLiaison>>(
        stream: session.watchJournalLiaisons(),
        builder: (context, snapshot) {
          final entrees = snapshot.data ?? const <EntreeJournalLiaison>[];
          if (entrees.isEmpty) return Center(child: Text(l10n.authLiaisonsAucune));
          final conflits = entrees.where((e) => e.statut == StatutEntreeJournal.enAttente).toList();
          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            children: [
              if (conflits.isNotEmpty) ...[
                Text(l10n.authLiaisonsConflits, style: Theme.of(context).textTheme.titleMedium),
                for (final conflit in conflits) _ConflitCard(entree: conflit, fideles: fideles),
                const SizedBox(height: AppDimensions.spacingLg),
              ],
              Text(l10n.authLiaisonsJournal, style: Theme.of(context).textTheme.titleMedium),
              for (final entree in entrees)
                ListTile(
                  title: Text('${entree.identifiant} — ${libelleIssue(l10n, entree.issue)}'),
                  subtitle: Text([
                    DateFormat.yMd().add_Hm().format(entree.creeLe),
                    if (entree.fideleId != null) _nomFiche(fideles, entree.fideleId!),
                    libelleStatut(l10n, entree.statut),
                  ].join(' · ')),
                ),
            ],
          );
        },
      ),
    );
  }
}

String _nomFiche(List<Fidele> fideles, String id) {
  for (final fidele in fideles) {
    if (fidele.id == id) return fidele.nomComplet;
  }
  return id;
}

String libelleIssue(AppLocalizations l10n, IssueLiaison issue) => switch (issue) {
      IssueLiaison.lieAutomatiquement => l10n.authIssueLieAutomatiquement,
      IssueLiaison.administrateurAmorcage => l10n.authIssueAdministrateurAmorcage,
      IssueLiaison.aucuneCorrespondance => l10n.authIssueAucuneCorrespondance,
      IssueLiaison.correspondanceMultiple => l10n.authIssueCorrespondanceMultiple,
      IssueLiaison.ficheDejaLiee => l10n.authIssueFicheDejaLiee,
    };

String libelleStatut(AppLocalizations l10n, StatutEntreeJournal statut) => switch (statut) {
      StatutEntreeJournal.consigne => '',
      StatutEntreeJournal.enAttente => l10n.authStatutEnAttente,
      StatutEntreeJournal.resoluLie => l10n.authStatutResoluLie,
      StatutEntreeJournal.resoluRejete => l10n.authStatutResoluRejete,
    };

class _ConflitCard extends StatefulWidget {
  const _ConflitCard({required this.entree, required this.fideles});

  final EntreeJournalLiaison entree;
  final List<Fidele> fideles;

  @override
  State<_ConflitCard> createState() => _ConflitCardState();
}

class _ConflitCardState extends State<_ConflitCard> {
  String? _ficheChoisie;

  /// Fiches correspondant à l'identifiant du compte en conflit, même
  /// comparaison que la décision automatique.
  List<Fidele> get _candidates {
    final identifiant = IdentifiantRules.telephone(widget.entree.identifiant) ??
        IdentifiantRules.email(widget.entree.identifiant);
    if (identifiant == null) return const [];
    return widget.fideles
        .where((f) => LiaisonCompteRules.correspond(
              identifiant,
              FicheCandidate(fideleId: f.id, telephone: f.telephone, email: f.email),
            ))
        .toList(growable: false);
  }

  Future<void> _lier(SessionController session, String fideleId) async {
    final l10n = AppLocalizations.of(context)!;
    final confirme = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: Text(l10n.authLiaisonConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(l10n.commonAnnuler)),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(l10n.authConfirmer)),
        ],
      ),
    );
    if (confirme != true || !mounted) return;
    await session.resoudreConflit(entreeId: widget.entree.id, lier: true, fideleIdChoisi: fideleId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();
    final multiple = widget.entree.issue == IssueLiaison.correspondanceMultiple;
    final candidates = _candidates;
    final fideleId = multiple ? _ficheChoisie : widget.entree.fideleId;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.entree.identifiant, style: Theme.of(context).textTheme.titleSmall),
            Text(libelleIssue(l10n, widget.entree.issue)),
            if (!multiple && widget.entree.fideleId != null) Text(_nomFiche(widget.fideles, widget.entree.fideleId!)),
            if (multiple)
              DropdownButtonFormField<String>(
                initialValue: _ficheChoisie,
                decoration: InputDecoration(labelText: l10n.authLiaisonChoisirFiche),
                items: [
                  for (final fiche in candidates) DropdownMenuItem(value: fiche.id, child: Text(fiche.nomComplet)),
                ],
                onChanged: (valeur) => setState(() => _ficheChoisie = valeur),
              ),
            if (session.erreur != null)
              Text(session.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: session.enCours
                      ? null
                      : () => session.resoudreConflit(entreeId: widget.entree.id, lier: false),
                  child: Text(l10n.authLiaisonRejeter),
                ),
                FilledButton(
                  onPressed: session.enCours || fideleId == null ? null : () => _lier(session, fideleId),
                  child: Text(l10n.authLiaisonLier),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
