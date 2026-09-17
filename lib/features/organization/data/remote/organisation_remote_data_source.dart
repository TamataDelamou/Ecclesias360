import 'package:supabase_flutter/supabase_flutter.dart';

import '../local/app_database.dart';

/// Source de données distante Supabase pour `organisation_nodes`. Jamais
/// appelée en bloquant l'écriture locale (RG-OFF-01) — toute erreur reste
/// dans l'outbox pour une prochaine tentative.
class OrganisationRemoteDataSource {
  OrganisationRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> upsertNode(OrganisationNodeRow node) async {
    await _client.from('organisation_nodes').upsert({
      'id': node.id,
      'type_noeud': node.typeNoeud,
      'noeud_parent_id': node.noeudParentId,
      'nom': node.nom,
      'code_interne': node.codeInterne,
      'statut': node.statut,
      'logo_url': node.logoUrl,
      'cachet_url': node.cachetUrl,
      'date_fondation': node.dateFondation?.toIso8601String(),
      'categorie_confessionnelle': node.categorieConfessionnelle,
      'zone_geo_id': node.zoneGeoId,
      'path': node.path,
      'depth': node.depth,
      'created_at': node.createdAt.toIso8601String(),
      'updated_at': node.updatedAt.toIso8601String(),
    });
  }

  Future<void> deleteNode(String id) async {
    await _client.from('organisation_nodes').delete().eq('id', id);
  }
}
