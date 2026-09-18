/// RG-III-03 — `suspendue` n'est atteint que depuis le Module X
/// (discipline) : la structure de données est prête, le déclenchement
/// automatique reste différé jusqu'à la construction de ce module (voir
/// `MinistereRepository.suspendreAffectationsActives`).
enum StatutAffectation {
  active('active'),
  suspendue('suspendue'),
  terminee('terminee');

  const StatutAffectation(this.code);

  final String code;

  static StatutAffectation fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut affectation inconnu : $code'),
      );
}
