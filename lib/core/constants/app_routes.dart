/// Chemins de routage centralisés (`go_router`) — jamais de chemin en dur ailleurs.
abstract final class AppRoutes {
  static const String home = '/';

  static const String organisation = '/organisation';
  static const String organisationNouveauNoeud = '/organisation/nouveau';
  static const String organisationAnnuaireEglises = '/organisation/annuaire-eglises';

  static String organisationNoeud(String id) => '/organisation/$id';
  static String organisationNouveauSousNoeud(String parentId) =>
      '/organisation/nouveau?parent=$parentId';
  static String organisationModifierNoeud(String id) => '/organisation/$id/modifier';
  static String organisationHistorique(String id) => '/organisation/$id/historique';
  static String organisationResponsables(String id) => '/organisation/$id/responsables';

  static const String fideles = '/fideles';
  static const String fidelesNouveau = '/fideles/nouveau';

  static String fidele(String id) => '/fideles/$id';
  static String fideleHistorique(String id) => '/fideles/$id/historique';

  static const String zonesGeographiques = '/parametres/zones-geographiques';
  static const String roles = '/parametres/roles';

  static String ministeresDuNoeud(String noeudId) => '/organisation/$noeudId/ministeres';
  static String ministeresNouveau(String noeudId) => '/organisation/$noeudId/ministeres/nouveau';
  static String ministere(String id) => '/ministeres/$id';
  static String ministereMembres(String id) => '/ministeres/$id/membres';
  static String ministereHistoriqueResponsables(String id) => '/ministeres/$id/historique-responsables';
  static String ministereJournal(String id) => '/ministeres/$id/journal';
  static const String mandatsEcheance = '/ministeres/mandats-echeance';

  static const String donsReferentiel = '/dons-spirituels/referentiel';
  static String donsFidele(String fideleId) => '/fideles/$fideleId/dons';
  static String donHistorique(String fideleId, String donId) => '/fideles/$fideleId/dons/$donId';
  static String donEvaluer(String fideleId, String donId) => '/fideles/$fideleId/dons/$donId/evaluer';
  static String donMinisteresCompatibles(String fideleId, String donId) =>
      '/fideles/$fideleId/dons/$donId/ministeres-compatibles';
  static String donsStatistiques(String noeudId) => '/organisation/$noeudId/dons-statistiques';

  static const String professions = '/professions';
  static String professionGroupe(String professionId) => '/professions/$professionId';
  static String fideleCompetences(String fideleId) => '/fideles/$fideleId/competences';

  static const String groupesEglise = '/groupes-eglise';
  static String groupeMembres(String groupeId) => '/groupes-eglise/$groupeId/membres';
  static String groupeRegles(String groupeId) => '/groupes-eglise/$groupeId/regles';
  static String fideleGroupes(String fideleId) => '/fideles/$fideleId/groupes';

  static String comiteMembres(String noeudId) => '/organisation/$noeudId/comite/membres';
  static String comiteSeances(String noeudId) => '/organisation/$noeudId/comite/seances';
  static String comiteNouvelleSeance(String noeudId) => '/organisation/$noeudId/comite/seances/nouvelle';
  static String comiteSeance(String seanceId) => '/comite/seances/$seanceId';
}
