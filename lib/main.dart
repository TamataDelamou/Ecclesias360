import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();
  await Supabase.initialize(
    url: AppConfig.instance.supabaseUrl,
    publishableKey: AppConfig.instance.supabasePublishableKey,
  );
  runApp(const EcclesiasApp());
}
