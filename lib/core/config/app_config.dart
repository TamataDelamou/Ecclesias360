import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Accès centralisé à la configuration chargée depuis `.env`.
///
/// [load] doit être appelé une seule fois avant [AppConfig.instance] ou tout
/// accès à Supabase (voir `main.dart`).
class AppConfig {
  AppConfig._(this.supabaseUrl, this.supabasePublishableKey);

  final String supabaseUrl;
  final String supabasePublishableKey;

  static AppConfig? _instance;

  static AppConfig get instance {
    final config = _instance;
    if (config == null) {
      throw StateError('AppConfig.load() doit être appelé avant AppConfig.instance.');
    }
    return config;
  }

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
    _instance = AppConfig._(
      dotenv.get('SUPABASE_URL', fallback: ''),
      dotenv.get('SUPABASE_PUBLISHABLE_KEY', fallback: ''),
    );
  }
}
