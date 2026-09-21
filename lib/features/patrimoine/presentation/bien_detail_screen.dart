import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../../cultes/application/culte_controller.dart';
import '../../cultes/domain/models/culte.dart';
import '../../fideles/application/fidele_controller.dart';
import '../../parametres/domain/models/role.dart';
import '../application/patrimoine_controller.dart';
import '../domain/models/bien.dart';
import '../domain/models/categorie_bien.dart';
import '../domain/models/etat_bien.dart';
import '../domain/models/mouvement_stock.dart';
import '../domain/models/objet_reservation.dart';
import '../domain/models/reservation_bien.dart';
import '../domain/models/type_mouvement_stock.dart';
import '../domain/models/type_sortie_bien.dart';

/// Fiche d'un bien (RG-XX-01) — sert aussi d'écran d'action pour le
/// signalement d'état/panne (écran 4 du Cahier), la sortie du patrimoine
/// (RG-XX-02), la réservation (RG-XX-03, écran 3) et, pour un bien à
/// gestion de stock, les mouvements de stock et le seuil d'alerte
/// (RG-XX-05, écran 6).
class BienDetailScreen extends StatelessWidget {
  const BienDetailScreen({required this.bienId, super.key});

  final String bienId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PatrimoineController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.patrimoineFicheTitre)),
      body: FutureBuilder<Bien?>(
        future: controller.findBienById(bienId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final bien = snapshot.data;
          if (bien == null) return Center(child: Text(l10n.patrimoineIntrouvable));
          return _BienDetailBody(bien: bien, controller: controller);
        },
      ),
    );
  }
}

class _BienDetailBody extends StatefulWidget {
  const _BienDetailBody({required this.bien, required this.controller});

  final Bien bien;
  final PatrimoineController controller;

  @override
  State<_BienDetailBody> createState() => _BienDetailBodyState();
}

class _BienDetailBodyState extends State<_BienDetailBody> {
  late Bien _bien = widget.bien;

  Future<void> _rafraichir() async {
    final bien = await widget.controller.findBienById(_bien.id);
    if (mounted && bien != null) setState(() => _bien = bien);
  }

  Future<void> _signalerEtat(BuildContext context) async {
    EtatBien nouvelEtat = _bien.etat;
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.patrimoineSignalerEtatTitre),
            content: DropdownButtonFormField<EtatBien>(
              isExpanded: true,
              initialValue: nouvelEtat,
              decoration: InputDecoration(labelText: l10n.patrimoineChampEtat),
              items: EtatBien.values
                  .where((e) => e != EtatBien.cede)
                  .map((e) => DropdownMenuItem(value: e, child: Text(_libelleEtat(l10n, e))))
                  .toList(),
              onChanged: (valeur) => setState(() => nouvelEtat = valeur ?? nouvelEtat),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.patrimoineSignalerEtatBouton)),
            ],
          ),
        );
      },
    );
    if (confirme == true) {
      await widget.controller.signalerEtat(id: _bien.id, nouvelEtat: nouvelEtat);
      await _rafraichir();
    }
  }

  Future<void> _sortir(BuildContext context) async {
    final fideleController = context.read<FideleController>();
    final fidelesDuNoeud = fideleController.fideles.where((f) => f.noeudId == _bien.noeudId).toList();
    if (fidelesDuNoeud.isEmpty) return;

    Role roleActeur = Role.pasteur;
    TypeSortieBien typeSortie = TypeSortieBien.cession;
    String valideParFideleId = fidelesDuNoeud.first.id;
    final motifController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.patrimoineSortirTitre),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<TypeSortieBien>(
                    isExpanded: true,
                    initialValue: typeSortie,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampTypeSortie),
                    items: [
                      DropdownMenuItem(value: TypeSortieBien.cession, child: Text(l10n.patrimoineTypeSortieCession)),
                      DropdownMenuItem(value: TypeSortieBien.don, child: Text(l10n.patrimoineTypeSortieDon)),
                      DropdownMenuItem(
                        value: TypeSortieBien.miseAuRebut,
                        child: Text(l10n.patrimoineTypeSortieMiseAuRebut),
                      ),
                    ],
                    onChanged: (valeur) => setState(() => typeSortie = valeur ?? typeSortie),
                  ),
                  DropdownButtonFormField<Role>(
                    isExpanded: true,
                    initialValue: roleActeur,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampRoleActeur),
                    items: Role.values.map((r) => DropdownMenuItem(value: r, child: Text(r.code))).toList(),
                    onChanged: (valeur) => setState(() => roleActeur = valeur ?? roleActeur),
                  ),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: valideParFideleId,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampValidePar),
                    items: fidelesDuNoeud.map((f) => DropdownMenuItem(value: f.id, child: Text(f.nomComplet))).toList(),
                    onChanged: (valeur) => setState(() => valideParFideleId = valeur ?? valideParFideleId),
                  ),
                  TextField(
                    controller: motifController,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampMotif),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.patrimoineSortirBouton)),
            ],
          ),
        );
      },
    );

    if (confirme == true) {
      await widget.controller.sortirBien(
        id: _bien.id,
        roleActeur: roleActeur,
        typeSortie: typeSortie,
        valideParFideleId: valideParFideleId,
        motif: motifController.text.trim().isNotEmpty ? motifController.text.trim() : null,
      );
      await _rafraichir();
    }
  }

  Future<void> _reserver(BuildContext context) async {
    final culteController = context.read<CulteController>();
    ObjetReservation objetReservation = ObjetReservation.culte;
    String? culteId;
    final objetLibreController = TextEditingController();
    DateTime dateDebut = DateTime.now();
    DateTime dateFin = DateTime.now().add(const Duration(hours: 2));

    Future<DateTime?> choisirDateHeure(DateTime initiale) async {
      final date = await showDatePicker(context: context, initialDate: initiale, firstDate: DateTime(2000), lastDate: DateTime(2100));
      if (date == null || !context.mounted) return null;
      final heure = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initiale));
      if (heure == null) return null;
      return DateTime(date.year, date.month, date.day, heure.hour, heure.minute);
    }

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StreamBuilder<List<Culte>>(
          stream: culteController.watchCultes(_bien.noeudId),
          builder: (context, culteSnapshot) {
            final cultes = culteSnapshot.data ?? const <Culte>[];
            return StatefulBuilder(
              builder: (context, setState) {
                if (objetReservation == ObjetReservation.culte && culteId == null && cultes.isNotEmpty) {
                  culteId = cultes.first.id;
                }
                return AlertDialog(
                  title: Text(l10n.patrimoineReserverTitre),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<ObjetReservation>(
                          isExpanded: true,
                          initialValue: objetReservation,
                          decoration: InputDecoration(labelText: l10n.patrimoineChampObjetReservation),
                          items: [
                            DropdownMenuItem(value: ObjetReservation.culte, child: Text(l10n.patrimoineObjetCulte)),
                            DropdownMenuItem(value: ObjetReservation.evenement, child: Text(l10n.patrimoineObjetEvenement)),
                            DropdownMenuItem(value: ObjetReservation.autre, child: Text(l10n.patrimoineObjetAutre)),
                          ],
                          onChanged: (valeur) => setState(() => objetReservation = valeur ?? objetReservation),
                        ),
                        if (objetReservation == ObjetReservation.culte)
                          cultes.isEmpty
                              ? Text(l10n.patrimoineAucunCultePourReservation)
                              : DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  initialValue: culteId,
                                  decoration: InputDecoration(labelText: l10n.patrimoineChampCulte),
                                  items: cultes
                                      .map((c) => DropdownMenuItem(value: c.id, child: Text('${c.typeCulte} — ${c.dateHeure.toIso8601String().split('T').first}')))
                                      .toList(),
                                  onChanged: (valeur) => setState(() => culteId = valeur),
                                )
                        else
                          TextField(
                            controller: objetLibreController,
                            decoration: InputDecoration(labelText: l10n.patrimoineChampObjetLibre),
                          ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.patrimoineChampDateDebut),
                          subtitle: Text(dateDebut.toString()),
                          trailing: const Icon(Icons.calendar_today_outlined),
                          onTap: () async {
                            final choisie = await choisirDateHeure(dateDebut);
                            if (choisie != null) setState(() => dateDebut = choisie);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.patrimoineChampDateFin),
                          subtitle: Text(dateFin.toString()),
                          trailing: const Icon(Icons.calendar_today_outlined),
                          onTap: () async {
                            final choisie = await choisirDateHeure(dateFin);
                            if (choisie != null) setState(() => dateFin = choisie);
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
                    FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.patrimoineReserverBouton)),
                  ],
                );
              },
            );
          },
        );
      },
    );

    if (confirme == true && dateFin.isAfter(dateDebut)) {
      await widget.controller.reserverBien(
        bienId: _bien.id,
        objetReservation: objetReservation,
        culteId: objetReservation == ObjetReservation.culte ? culteId : null,
        objetLibre: objetReservation != ObjetReservation.culte && objetLibreController.text.trim().isNotEmpty
            ? objetLibreController.text.trim()
            : null,
        dateDebut: dateDebut,
        dateFin: dateFin,
      );
    }
  }

  Future<void> _enregistrerMouvement(BuildContext context) async {
    TypeMouvementStock type = TypeMouvementStock.entree;
    final quantiteController = TextEditingController();
    final motifController = TextEditingController();

    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(l10n.patrimoineMouvementAjouterTitre),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<TypeMouvementStock>(
                    isExpanded: true,
                    initialValue: type,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampTypeMouvement),
                    items: [
                      DropdownMenuItem(value: TypeMouvementStock.entree, child: Text(l10n.patrimoineMouvementEntree)),
                      DropdownMenuItem(value: TypeMouvementStock.sortie, child: Text(l10n.patrimoineMouvementSortie)),
                    ],
                    onChanged: (valeur) => setState(() => type = valeur ?? type),
                  ),
                  TextField(
                    controller: quantiteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampQuantite),
                  ),
                  TextField(
                    controller: motifController,
                    decoration: InputDecoration(labelText: l10n.patrimoineChampMotif),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonAnnuler)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonAjouter)),
            ],
          ),
        );
      },
    );

    final quantite = int.tryParse(quantiteController.text.trim());
    if (confirme == true && quantite != null && quantite > 0) {
      await widget.controller.enregistrerMouvementStock(
        bienId: _bien.id,
        type: type,
        quantite: quantite,
        motif: motifController.text.trim().isNotEmpty ? motifController.text.trim() : null,
      );
    }
  }

  String _libelleEtat(AppLocalizations l10n, EtatBien etat) => switch (etat) {
        EtatBien.neuf => l10n.patrimoineEtatNeuf,
        EtatBien.bon => l10n.patrimoineEtatBon,
        EtatBien.aReparer => l10n.patrimoineEtatAReparer,
        EtatBien.horsService => l10n.patrimoineEtatHorsService,
        EtatBien.cede => l10n.patrimoineEtatCede,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<List<CategorieBien>>(
      stream: widget.controller.watchCategoriesBien(),
      builder: (context, categoriesSnapshot) {
        final categories = categoriesSnapshot.data ?? const <CategorieBien>[];
        CategorieBien? categorie;
        for (final c in categories) {
          if (c.id == _bien.categorieId) {
            categorie = c;
            break;
          }
        }
        final estGestionStock = categorie?.code == 'stocks';
        final estSorti = _bien.etat == EtatBien.cede;

        return ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_bien.designation, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppDimensions.spacingSm),
                    Text('${l10n.patrimoineChampIdInventaire} : ${_bien.idInventaire}'),
                    Text('${l10n.patrimoineChampCategorie} : ${categorie?.libelle ?? '—'}'),
                    Text('${l10n.patrimoineChampEtat} : ${_libelleEtat(l10n, _bien.etat)}'),
                    Text('${l10n.patrimoineChampValeurAcquisition} : ${_bien.valeurAcquisition} ${_bien.devise}'),
                    Text('${l10n.patrimoineChampValeurVenale} : ${_bien.valeurVenale} ${_bien.devise}'),
                    Text(l10n.patrimoineAcquisLe(_bien.dateAcquisition.toIso8601String().split('T').first)),
                    if (estSorti && _bien.typeSortie != null)
                      Text(l10n.patrimoineSortiLe(_bien.dateSortie!.toIso8601String().split('T').first)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            if (!estSorti) ...[
              OutlinedButton(onPressed: () => _signalerEtat(context), child: Text(l10n.patrimoineSignalerEtatBouton)),
              const SizedBox(height: AppDimensions.spacingSm),
              OutlinedButton(onPressed: () => _reserver(context), child: Text(l10n.patrimoineReserverBouton)),
              const SizedBox(height: AppDimensions.spacingSm),
              OutlinedButton(onPressed: () => _sortir(context), child: Text(l10n.patrimoineSortirBouton)),
              const SizedBox(height: AppDimensions.spacingMd),
            ],
            if (estGestionStock) ...[
              Text(l10n.patrimoineStockTitre, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppDimensions.spacingSm),
              StreamBuilder<List<MouvementStock>>(
                stream: widget.controller.watchMouvementsStock(_bien.id),
                builder: (context, mouvementsSnapshot) {
                  final mouvements = mouvementsSnapshot.data ?? const <MouvementStock>[];
                  // Recalculée à chaque émission des mouvements (jamais une
                  // colonne stockée, RG-XX-05), même motif que le solde de
                  // projet du Module XI.
                  return FutureBuilder<int>(
                    future: widget.controller.quantiteStock(_bien.id),
                    builder: (context, quantiteSnapshot) {
                      final quantite = quantiteSnapshot.data ?? 0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.patrimoineQuantiteActuelle(quantite)),
                          if (_bien.seuilAlerteStock != null) Text(l10n.patrimoineSeuilAlerte(_bien.seuilAlerteStock!)),
                          const SizedBox(height: AppDimensions.spacingSm),
                          FilledButton(
                            onPressed: () => _enregistrerMouvement(context),
                            child: Text(l10n.patrimoineMouvementAjouterBouton),
                          ),
                          const SizedBox(height: AppDimensions.spacingMd),
                          for (final mouvement in mouvements)
                            Card(
                              child: ListTile(
                                title: Text(
                                  mouvement.type == TypeMouvementStock.entree
                                      ? l10n.patrimoineMouvementEntree
                                      : l10n.patrimoineMouvementSortie,
                                ),
                                subtitle: Text(mouvement.date.toIso8601String().split('T').first),
                                trailing: Text('${mouvement.quantite}'),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: AppDimensions.spacingMd),
            ],
            Text(l10n.patrimoineReservationsTitre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            StreamBuilder<List<ReservationBien>>(
              stream: widget.controller.watchReservations(_bien.id),
              builder: (context, reservationsSnapshot) {
                final reservations = reservationsSnapshot.data ?? const <ReservationBien>[];
                if (reservations.isEmpty) {
                  return Text(l10n.patrimoineReservationsAucune);
                }
                return Column(
                  children: [
                    for (final reservation in reservations)
                      Card(
                        child: ListTile(
                          title: Text(reservation.objetLibre ?? _libelleObjet(l10n, reservation.objetReservation)),
                          subtitle: Text(
                            '${reservation.dateDebut.toIso8601String().split('T').first} → '
                            '${reservation.dateFin.toIso8601String().split('T').first}',
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  String _libelleObjet(AppLocalizations l10n, ObjetReservation objet) => switch (objet) {
        ObjetReservation.culte => l10n.patrimoineObjetCulte,
        ObjetReservation.evenement => l10n.patrimoineObjetEvenement,
        ObjetReservation.autre => l10n.patrimoineObjetAutre,
      };
}
