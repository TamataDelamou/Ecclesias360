import 'dart:async';

import 'package:ecclesias_360/features/parametres/data/referential/roles_referential.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/capacites_pour_tests.dart';

/// Exécuté avant chaque fichier de test, hors du temps simulé des tests
/// d'écran : précharge le référentiel des capacités (voir `capacitesDeTest`).
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  capacitesDeTest = await RolesReferential.charger();
  await testMain();
}
