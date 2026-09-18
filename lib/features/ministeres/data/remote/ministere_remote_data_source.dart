import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../organization/data/local/app_database.dart';

/// Source de données distante Supabase pour `ministeres`. Jamais appelée en
/// bloquant l'écriture locale (RG-OFF-01). Les entités liées
/// (`affectations_ministeres`, `mandats_responsables`,
/// `activites_ministeres`) restent en synchronisation différée pour cette
/// première itération, même limitation documentée que ZonesGeographiques
/// (Module XXIII) — regroupement prévu dans un futur lot de consolidation
/// de la synchronisation, évitant un état partiellement synchronisé entre
/// un ministère et ses entités liées.
class MinistereRemoteDataSource {
  MinistereRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> upsertMinistere(MinistereRow ministere) async {
    await _client.from('ministeres').upsert({
      'id': ministere.id,
      'noeud_id': ministere.noeudId,
      'type_ministere_id': ministere.typeMinistereId,
      'nom': ministere.nom,
      'date_creation': ministere.dateCreation.toIso8601String(),
      'statut': ministere.statut,
    });
  }

  Future<void> deleteMinistere(String id) async {
    await _client.from('ministeres').delete().eq('id', id);
  }
}
