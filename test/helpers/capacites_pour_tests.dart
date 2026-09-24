import 'package:ecclesias_360/features/parametres/data/referential/roles_referential.dart';

/// `assets/config/roles.json`, préchargé une fois pour toute la suite par
/// `test/flutter_test_config.dart` — comme `main.dart` le fait avant
/// `runApp`. Sans lui, les capacités (RG-XXIII-02) restent refusées tant que
/// l'asset n'est pas lu, ce qui exige une vraie attente asynchrone
/// qu'un `pumpAndSettle` ne fournit pas.
late final RolesReferential capacitesDeTest;
