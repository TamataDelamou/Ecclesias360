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
}
