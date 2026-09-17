/// RG-XXIII-03 — une valeur de référentiel utilisée par des enregistrements
/// existants ne peut être supprimée, seulement désactivée (non proposée
/// aux nouvelles saisies, conservée pour l'historique).
enum StatutReferentiel {
  actif('actif'),
  desactive('desactive');

  const StatutReferentiel(this.code);

  final String code;

  static StatutReferentiel fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut référentiel inconnu : $code'),
      );
}
