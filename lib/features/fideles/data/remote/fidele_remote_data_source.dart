import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../organization/data/local/app_database.dart';

/// Source de données distante Supabase pour `fideles`. Jamais appelée en
/// bloquant l'écriture locale (RG-OFF-01).
class FideleRemoteDataSource {
  FideleRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> upsertFidele(FideleRow fidele) async {
    await _client.from('fideles').upsert({
      'id': fidele.id,
      'noeud_id': fidele.noeudId,
      'nom': fidele.nom,
      'prenoms': fidele.prenoms,
      'date_naissance': fidele.dateNaissance.toIso8601String(),
      'sexe': fidele.sexe,
      'statut_civil': fidele.statutCivil,
      'statut_spirituel': fidele.statutSpirituel,
      'statut': fidele.statut,
      'date_conversion': fidele.dateConversion?.toIso8601String(),
      'date_bapteme': fidele.dateBapteme?.toIso8601String(),
      'eglise_provenance': fidele.egliseProvenance,
      'photo_url': fidele.photoUrl,
      'telephone': fidele.telephone,
      'email': fidele.email,
      'adresse': fidele.adresse,
      'created_at': fidele.createdAt.toIso8601String(),
      'updated_at': fidele.updatedAt.toIso8601String(),
    });
  }

  Future<void> deleteFidele(String id) async {
    await _client.from('fideles').delete().eq('id', id);
  }
}
