/// Cycle de vie d'un dossier disciplinaire (RG-X-01 à 04). Le Cahier ne fixe
/// pas de valeurs précises pour le champ « statut » : ce découpage à trois
/// états est un choix d'implémentation, cohérent avec les transitions
/// exigées (ouverture, décision, clôture/réintégration).
enum StatutDossierDisciplinaire {
  /// Dossier ouvert, en attente d'une décision motivée (RG-X-02).
  enInstruction('en_instruction'),

  /// Décision prononcée — sanction éventuellement en cours (suspension de
  /// ministères, durée déterminée ou indéterminée).
  sanctionne('sanctionne'),

  /// Dossier clos : le fidèle a retrouvé son statut spirituel antérieur
  /// (RG-X-04), qu'il s'agisse d'une réintégration après sanction ou d'une
  /// clôture sans sanction (relaxe).
  clos('clos');

  const StatutDossierDisciplinaire(this.code);

  final String code;

  static StatutDossierDisciplinaire fromCode(String code) => values.firstWhere(
        (s) => s.code == code,
        orElse: () => throw ArgumentError('Statut de dossier disciplinaire inconnu : $code'),
      );
}
