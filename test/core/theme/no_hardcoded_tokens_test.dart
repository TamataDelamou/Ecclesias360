import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// AGENTS.md §5 — foyer unique des couleurs et des espacements. Ce test
/// scanne le code source (pas l'AST — une recherche textuelle suffit pour
/// ce garde-fou et n'a pas besoin du SDK d'analyse) pour empêcher :
/// - toute couleur `Color(0x...)` en dehors de `lib/core/theme/app_palettes.dart` ;
/// - tout nombre de mise en page en dur dans les écrans déjà migrés vers
///   `AppDimensions` (liste ci-dessous ; un écran encore non migré n'a pas
///   à figurer dans cette liste tant qu'il n'a pas été converti).
void main() {
  final libDir = Directory('lib');

  test('aucune couleur Color(0x...) en dur en dehors de app_palettes.dart', () {
    final offenders = <String>[];
    final colorPattern = RegExp(r'Color\(0x[0-9A-Fa-f]{6,8}\)');
    for (final file in libDir.listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;
      if (file.path.replaceAll('\\', '/').endsWith('lib/core/theme/app_palettes.dart')) continue;
      final content = file.readAsStringSync();
      if (colorPattern.hasMatch(content)) {
        offenders.add(file.path);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'Couleurs en dur trouvées hors de app_palettes.dart : $offenders',
    );
  });

  test('aucun nombre de mise en page en dur dans les écrans déjà migrés', () {
    const ecransMigres = [
      'lib/features/home/presentation/home_screen.dart',
      'lib/features/organization/presentation/node_form_screen.dart',
      'lib/features/organization/presentation/node_detail_screen.dart',
      'lib/features/organization/presentation/hierarchy_screen.dart',
      'lib/features/organization/presentation/church_directory_screen.dart',
      'lib/features/fideles/presentation/fidele_detail_screen.dart',
      'lib/features/fideles/presentation/fidele_form_screen.dart',
      'lib/features/fideles/presentation/fidele_history_screen.dart',
      'lib/features/fideles/presentation/fidele_list_screen.dart',
      'lib/features/comite/presentation/membres_comite_screen.dart',
      'lib/features/comite/presentation/seances_comite_list_screen.dart',
      'lib/features/comite/presentation/seance_detail_screen.dart',
      'lib/features/comite/presentation/seance_form_screen.dart',
    ];
    // EdgeInsets.only(...) legitime pour l'indentation d'arbre : dépend de
    // node.depth, pas un nombre en dur isolé — exclu explicitement du motif.
    final layoutPattern = RegExp(
      r'(EdgeInsets\.(all|symmetric|only)|SizedBox\((height|width):|Divider\(height:)\s*\(?[^)]*?\b\d+(\.\d+)?\b',
    );
    final offenders = <String>[];
    for (final path in ecransMigres) {
      final file = File(path);
      final content = file.readAsStringSync();
      for (final match in layoutPattern.allMatches(content)) {
        final snippet = match.group(0)!;
        if (snippet.contains('AppDimensions') || snippet.contains('node.depth')) continue;
        offenders.add('$path : $snippet');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'Nombres de mise en page en dur trouvés dans un écran migré : $offenders',
    );
  });
}
