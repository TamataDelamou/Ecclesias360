import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Persistance de la session Supabase (jetons d'accès et de
/// rafraîchissement) dans le stockage sécurisé du système plutôt que dans
/// SharedPreferences, en clair par défaut (AGENTS.md §2 : jetons →
/// `flutter_secure_storage`).
class SessionSecuriseeStorage extends LocalStorage {
  const SessionSecuriseeStorage([this._stockage = const FlutterSecureStorage()]);

  final FlutterSecureStorage _stockage;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() => _stockage.containsKey(key: supabasePersistSessionKey);

  @override
  Future<String?> accessToken() => _stockage.read(key: supabasePersistSessionKey);

  @override
  Future<void> removePersistedSession() => _stockage.delete(key: supabasePersistSessionKey);

  @override
  Future<void> persistSession(String persistSessionString) =>
      _stockage.write(key: supabasePersistSessionKey, value: persistSessionString);
}
