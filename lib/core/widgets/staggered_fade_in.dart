import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';

/// Entrée animée (fondu + léger glissement vertical) pour un élément de
/// liste, avec un décalage croissant selon [index] : donne un effet
/// d'apparition « en cascade » à une liste sans dépendance externe.
/// Introduit pour le Module VIII (voir demande d'écrans dynamiques/animés) ;
/// réutilisable tel quel par d'autres modules qui en auraient besoin plus
/// tard, sans qu'aucun ne soit retouché pour l'instant (périmètre volontaire).
class StaggeredFadeIn extends StatelessWidget {
  const StaggeredFadeIn({required this.index, required this.child, super.key});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final duree = AppDimensions.durationNormal + Duration(milliseconds: index.clamp(0, 8) * 40);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duree,
      curve: Curves.easeOutCubic,
      builder: (context, valeur, enfant) {
        return Opacity(
          opacity: valeur,
          child: Transform.translate(offset: Offset(0, (1 - valeur) * 12), child: enfant),
        );
      },
      child: child,
    );
  }
}
