import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_dimensions.dart';

/// Transition « axe partagé » (glissement horizontal léger + fondu) pour les
/// écrans imbriqués qui bénéficient d'une continuité visuelle plus marquée
/// que la transition Material par défaut des routes existantes — introduite
/// pour le Module VIII (bibliothèque -> détail -> historique des versions,
/// voir demande de transitions/animations soignées). Périmètre volontairement
/// limité à ce module pour l'instant : les routes existantes gardent leur
/// transition par défaut, pas de refonte visuelle non demandée ailleurs.
CustomTransitionPage<T> sharedAxisPage<T>({required LocalKey key, required Widget child}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: AppDimensions.durationNormal,
    reverseTransitionDuration: AppDimensions.durationNormal,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final courbe = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: courbe,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.06, 0), end: Offset.zero).animate(courbe),
          child: child,
        ),
      );
    },
  );
}
