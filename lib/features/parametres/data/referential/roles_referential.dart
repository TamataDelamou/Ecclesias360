import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/models/role.dart';

/// Charge `assets/config/roles.json` (RG-XXIII-02) — croisement capacité →
/// rôle minimal requis. Aucune valeur en dur ailleurs dans le code (AGENTS.md
/// §5).
class RolesReferential {
  const RolesReferential(this._capaciteVersRoleMinimal);

  final Map<String, Role> _capaciteVersRoleMinimal;

  static Future<RolesReferential> charger({
    AssetBundle? bundle,
    String assetPath = 'assets/config/roles.json',
  }) async {
    final contenu = await (bundle ?? rootBundle).loadString(assetPath);
    final json = jsonDecode(contenu) as Map<String, dynamic>;
    final capacites = (json['capacites'] as Map<String, dynamic>).map(
      (capacite, roleCode) => MapEntry(capacite, Role.fromCode(roleCode as String)),
    );
    return RolesReferential(capacites);
  }

  Role? roleMinimalPour(String capacite) => _capaciteVersRoleMinimal[capacite];
}
