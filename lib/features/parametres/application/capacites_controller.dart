import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/referential/roles_referential.dart';
import '../domain/models/role.dart';
import '../domain/rules/capacity_rules.dart';

/// Noms des capacités déclarées dans `assets/config/roles.json`
/// (RG-XXIII-02). Seuls les noms sont ici ; le rôle minimal requis reste
/// dans le référentiel.
abstract final class Capacites {
  static const creerNoeudNiveauSuperieur = 'creer_noeud_niveau_superieur';
  static const consulterAnnuaireEglises = 'consulter_annuaire_eglises';
}

/// Référentiel des capacités (RG-XXIII-02), chargé une seule fois à la
/// racine de l'application. **Refus par défaut** : tant que le référentiel
/// n'est pas chargé, ou pour une capacité qu'il ne déclare pas, rien n'est
/// accordé.
class CapacitesController extends ChangeNotifier {
  /// [referentiel] déjà chargé (production : `main.dart`, avant `runApp`),
  /// sinon chargé en arrière-plan depuis [chargement] ou l'asset.
  CapacitesController({RolesReferential? referentiel, Future<RolesReferential>? chargement})
    : _referentiel = referentiel {
    if (referentiel != null) return;
    unawaited(
      (chargement ?? RolesReferential.charger()).then((referentiel) {
        _referentiel = referentiel;
        notifyListeners();
      }, onError: (Object _) {}),
    );
  }

  RolesReferential? _referentiel;

  bool get charge => _referentiel != null;

  bool accorde({required String capacite, required Role role}) {
    final roleMinimal = _referentiel?.roleMinimalPour(capacite);
    return roleMinimal != null && CapacityRules.possede(role: role, roleMinimalRequis: roleMinimal);
  }
}
