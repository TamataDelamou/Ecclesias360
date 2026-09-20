import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/sync/sync_coordinator.dart';
import 'core/theme/design_tokens.dart';
import 'features/archivage/data/archivage_repository.dart';
import 'features/comite/application/comite_controller.dart';
import 'features/comite/data/comite_repository.dart';
import 'features/cultes/application/culte_controller.dart';
import 'features/cultes/data/culte_repository.dart';
import 'features/dons_spirituels/application/don_spirituel_controller.dart';
import 'features/dons_spirituels/data/don_spirituel_repository.dart';
import 'features/fideles/application/fidele_controller.dart';
import 'features/fideles/data/fidele_repository.dart';
import 'features/groupes_eglise/application/groupe_controller.dart';
import 'features/groupes_eglise/data/groupe_repository.dart';
import 'features/ministeres/application/ministere_controller.dart';
import 'features/ministeres/data/ministere_repository.dart';
import 'features/organization/application/organisation_controller.dart';
import 'features/organization/data/local/app_database.dart';
import 'features/organization/data/organisation_node_repository.dart';
import 'features/parametres/application/zone_geographique_controller.dart';
import 'features/parametres/data/zone_geographique_repository.dart';
import 'features/professions/application/profession_controller.dart';
import 'features/professions/data/profession_repository.dart';
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
  late final ZoneGeographiqueRepository _zoneGeographiqueRepository;
  late final ZoneGeographiqueController _zoneGeographiqueController;
  late final MinistereRepository _ministereRepository;
  late final MinistereController _ministereController;
  late final DonSpirituelRepository _donSpirituelRepository;
  late final DonSpirituelController _donSpirituelController;
  late final ProfessionRepository _professionRepository;
  late final ProfessionController _professionController;
  late final GroupeRepository _groupeRepository;
  late final GroupeController _groupeController;
  late final ArchivageRepository _archivageRepository;
  late final ComiteRepository _comiteRepository;
  late final ComiteController _comiteController;
  late final CulteRepository _culteRepository;
  late final CulteController _culteController;

  @override
  void initState() {
    super.initState();
    _syncCoordinator = SyncCoordinator(widget.database);
    _organisationRepository = OrganisationNodeRepository(widget.database, _syncCoordinator);
    _organisationController = OrganisationController(_organisationRepository);
    _fideleRepository = FideleRepository(widget.database, _syncCoordinator);
    _fideleController = FideleController(_fideleRepository);
    _zoneGeographiqueRepository = ZoneGeographiqueRepository(widget.database);
    _zoneGeographiqueController = ZoneGeographiqueController(_zoneGeographiqueRepository);
    _ministereRepository = MinistereRepository(widget.database, _syncCoordinator);
    _ministereController = MinistereController(_ministereRepository);
    _donSpirituelRepository = DonSpirituelRepository(widget.database);
    _donSpirituelController = DonSpirituelController(_donSpirituelRepository);
    _professionRepository = ProfessionRepository(widget.database);
    _professionController = ProfessionController(_professionRepository);
    _groupeRepository = GroupeRepository(widget.database);
    _groupeController = GroupeController(_groupeRepository);
    _archivageRepository = ArchivageRepository(widget.database);
    _comiteRepository = ComiteRepository(widget.database, archivageRepository: _archivageRepository);
    _comiteController = ComiteController(_comiteRepository);
    _culteRepository = CulteRepository(widget.database);
    _culteController = CulteController(_culteRepository);
  }

  @override
  void dispose() {
    _organisationController.dispose();
    _fideleController.dispose();
    _zoneGeographiqueController.dispose();
    _ministereController.dispose();
    _donSpirituelController.dispose();
    _professionController.dispose();
    _groupeController.dispose();
    _comiteController.dispose();
    _culteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrganisationController>.value(value: _organisationController),
        ChangeNotifierProvider<FideleController>.value(value: _fideleController),
        ChangeNotifierProvider<ZoneGeographiqueController>.value(value: _zoneGeographiqueController),
        ChangeNotifierProvider<MinistereController>.value(value: _ministereController),
        ChangeNotifierProvider<DonSpirituelController>.value(value: _donSpirituelController),
        ChangeNotifierProvider<ProfessionController>.value(value: _professionController),
        ChangeNotifierProvider<GroupeController>.value(value: _groupeController),
        ChangeNotifierProvider<ComiteController>.value(value: _comiteController),
        ChangeNotifierProvider<CulteController>.value(value: _culteController),
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
