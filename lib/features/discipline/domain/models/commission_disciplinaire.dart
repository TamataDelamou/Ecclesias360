/// RG-X-02 — commission instructrice d'un nœud. Ses membres peuvent
/// recouper ceux du comité local (module VII) sans dépendance directe : ce
/// sont de simples fidèles (voir Cahier, relation « la commission peut être
/// issue du comité »).
class CommissionDisciplinaire {
  const CommissionDisciplinaire({
    required this.id,
    required this.noeudId,
    required this.nom,
    required this.statut,
  });

  final String id;
  final String noeudId;
  final String nom;
  final String statut;
}
