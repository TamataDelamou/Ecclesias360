import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../parametres/domain/models/role.dart';

/// Accès au patrimoine d'un nœud (policy `biens_acces`, 0019 : périmètre
/// hiérarchique). Tant que le bornage local par périmètre n'est pas câblé
/// (dette RG-SEC-05, inventaire du Module II), il est approché par le rang
/// responsable — porteur d'un mandat —, même motif que les projets du
/// Module XI.
bool peutGererBiens(SessionController session) => session.peut(Role.responsable);

class EcranPatrimoineAccesReserve extends StatelessWidget {
  const EcranPatrimoineAccesReserve({required this.titre, super.key});

  final String titre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: Center(child: Text(AppLocalizations.of(context)!.patrimoineAccesReserve)),
    );
  }
}
