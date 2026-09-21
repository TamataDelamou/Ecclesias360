import 'statut_periode_comptable.dart';

/// Période comptable (exercice, Module XXI, RG-XXI-03). Globale (aucun
/// `noeud_id` — le Cahier ne le prévoit pas pour cette entité), une fois
/// clôturée elle devient immuable : toute correction postérieure exige une
/// écriture de régularisation dans la période courante, jamais une
/// réouverture.
class PeriodeComptable {
  const PeriodeComptable({
    required this.id,
    required this.exercice,
    required this.dateDebut,
    required this.dateFin,
    required this.statut,
  });

  final String id;
  final int exercice;
  final DateTime dateDebut;
  final DateTime dateFin;
  final StatutPeriodeComptable statut;
}
