import 'dart:io';

import 'package:ecclesias_360/core/theme/app_defaults.dart';
import 'package:flutter_test/flutter_test.dart';

/// RG-XIII-03 — le seuil de masquage automatique existe forcément à deux
/// endroits : `AppDefaults` (client, hors ligne) et le déclencheur serveur
/// (`seuil_masquage_commentaire()`, 0025). Ce test lit la migration et
/// échoue si les deux valeurs divergent : une règle dupliquée ne doit jamais
/// dériver en silence.
void main() {
  test('le seuil serveur (0025) égale AppDefaults.mediathequeSeuilSignalementsAvantMasquage', () {
    final migration = File('supabase/migrations/0025_signalements_moderation_commentaires.sql').readAsStringSync();
    final correspondance = RegExp(
      r'function public\.seuil_masquage_commentaire\(\)[\s\S]*?\$\$\s*select\s+(\d+)\s*\$\$',
    ).firstMatch(migration);

    expect(correspondance, isNotNull, reason: 'seuil_masquage_commentaire() introuvable dans 0025');
    expect(int.parse(correspondance!.group(1)!), AppDefaults.mediathequeSeuilSignalementsAvantMasquage);
  });
}
