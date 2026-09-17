import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'features/organization/data/local/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();

  // RG-OFF : l'application doit rester utilisable hors ligne et sans
  // backend configuré (développement local avant provisionnement Supabase).
  final config = AppConfig.instance;
  if (config.supabaseUrl.isNotEmpty && config.supabasePublishableKey.isNotEmpty) {
    await Supabase.initialize(
      url: config.supabaseUrl,
      publishableKey: config.supabasePublishableKey,
    );
  }

  runApp(EcclesiasApp(database: AppDatabase()));
}
