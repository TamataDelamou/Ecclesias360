import 'issue_liaison.dart';

/// Statut d'une entrée du journal des liaisons de comptes.
enum StatutEntreeJournal {
  /// Issue consignée, aucune action requise.
  consigne('consigne'),

  /// Conflit à trancher par un administrateur.
  enAttente('en_attente'),

  /// L'administrateur a lié le compte à la fiche (lien précédent retiré).
  resoluLie('resolu_lie'),

  /// L'administrateur a maintenu le compte en utilisateur simple.
  resoluRejete('resolu_rejete');

  const StatutEntreeJournal(this.code);

  final String code;

  static StatutEntreeJournal fromCode(String code) =>
      values.firstWhere((s) => s.code == code, orElse: () => throw ArgumentError('Statut inconnu : $code'));
}

/// Trace d'une liaison (ou non-liaison) d'un compte à une fiche fidèle :
/// qui (compte, identifiant), quand, quelle fiche, quelle issue.
class EntreeJournalLiaison {
  const EntreeJournalLiaison({
    required this.id,
    required this.authUserId,
    required this.identifiant,
    required this.issue,
    required this.statut,
    required this.creeLe,
    this.fideleId,
    this.resoluParAuthUserId,
    this.resoluLe,
  });

  final String id;
  final String authUserId;
  final String identifiant;
  final IssueLiaison issue;
  final StatutEntreeJournal statut;
  final DateTime creeLe;
  final String? fideleId;
  final String? resoluParAuthUserId;
  final DateTime? resoluLe;
}
