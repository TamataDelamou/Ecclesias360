import 'statut_decision.dart';

/// RG-VII-04/05 — [porteeDisciplinaire] signale une décision qui alimente
/// le Module X (discipline, pas encore construit) sans que le comité ne
/// puisse statuer seul sur l'issue finale — un simple drapeau informatif
/// dans cette itération, l'intégration effective est différée.
class Decision {
  const Decision({
    required this.id,
    required this.seanceId,
    required this.libelle,
    required this.resultatVote,
    required this.statut,
    required this.porteeDisciplinaire,
  });

  final String id;
  final String seanceId;
  final String libelle;
  final String? resultatVote;
  final StatutDecision statut;
  final bool porteeDisciplinaire;
}
