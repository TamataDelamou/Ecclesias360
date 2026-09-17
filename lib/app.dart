import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/sync/sync_coordinator.dart';
import 'core/theme/design_tokens.dart';
import 'features/fideles/application/fidele_controller.dart';
import 'features/fideles/data/fidele_repository.dart';
import 'features/organization/application/organisation_controller.dart';
import 'features/organization/data/local/app_database.dart';
import 'features/organization/data/organisation_node_repository.dart';
import 'l10n/app_localizations.dart';

class EcclesiasApp extends StatefulWidget {
  const EcclesiasApp({required this.database, super.key});

  final AppDatabase database;

  @override
  State<EcclesiasApp> createState() => _EcclesiasAppState();
}

class _EcclesiasAppState extends State<EcclesiasApp> {
  late final SyncCoordinator _syncCoordinator;
  late final OrganisationNodeRepository _organisationRepository;
  late final OrganisationController _organisationController;
  late final FideleRepository _fideleRepository;
  late final FideleController _fideleController;

  @override
  void initState() {
    super.initState();
    _syncCoordinator = SyncCoordinator(widget.database);
    _organisationRepository = OrganisationNodeRepository(widget.database, _syncCoordinator);
    _organisationController = OrganisationController(_organisationRepository);
    _fideleRepository = FideleRepository(widget.database, _syncCoordinator);
    _fideleController = FideleController(_fideleRepository);
  }

  @override
  void dispose() {
    _organisationController.dispose();
    _fideleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrganisationController>.value(value: _organisationController),
        ChangeNotifierProvider<FideleController>.value(value: _fideleController),
      ],
      child: MaterialApp.router(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        theme: DesignTokens.light(),
        darkTheme: DesignTokens.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: appRouter,
      ),
    );
  }
}
