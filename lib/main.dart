import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'features/auth/data/auth_gateway.dart';
import 'features/auth/data/remote/session_securisee_storage.dart';
import 'features/auth/data/remote/supabase_auth_gateway.dart';
import 'features/organization/data/local/app_database.dart';
import 'features/parametres/data/referential/roles_referential.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();

  // RG-SEC-01 : sans Supabase configuré, l'accès reste fermé (aucune
  // connexion possible) — jamais ouvert sans authentification. Une session
  // déjà établie est restaurée hors ligne (RG-OFF).
  final config = AppConfig.instance;
  AuthGateway authGateway = const AuthGatewayNonConfigure();
  if (config.supabaseUrl.isNotEmpty && config.supabasePublishableKey.isNotEmpty) {
    await Supabase.initialize(
      url: config.supabaseUrl,
      publishableKey: config.supabasePublishableKey,
      authOptions: const FlutterAuthClientOptions(localStorage: SessionSecuriseeStorage()),
    );
    authGateway = SupabaseAuthGateway(Supabase.instance.client.auth);
  }

  // RG-XXIII-02 : capacités chargées avant le premier écran ; en cas d'échec,
  // l'application démarre avec toutes les capacités refusées (jamais ouvertes).
  RolesReferential? capacites;
  try {
    capacites = await RolesReferential.charger();
  } on Object {
    capacites = null;
  }

  runApp(EcclesiasApp(database: AppDatabase(), authGateway: authGateway, capacites: capacites));
}
