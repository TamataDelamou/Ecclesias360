import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/application/session_controller.dart';
import '../../discipline/presentation/acces_discipline.dart';
import '../../parametres/domain/models/role.dart';
import '../domain/models/document_archive.dart';
import '../domain/rules/archivage_rules.dart';

/// Bibliothèque et corbeille d'un nœud (policy `documents_archive_lecture` :
/// périmètre hiérarchique). Tant que le bornage local par périmètre n'est pas
/// câblé (dette RG-SEC-05, inventaire du Module II), il est approché par le
/// rang responsable — porteur d'un mandat —, même motif que le patrimoine.
bool peutOuvrirArchives(SessionController session) => session.peut(Role.responsable);

/// RG-VIII-03 / RG-X-05 — un document n'est affiché que si le compte courant
/// peut le consulter : même règle que le dépôt (`ArchivageRepository.consulter`).
bool documentVisible(AccesDiscipline acces, DocumentArchive document) => ArchivageRules.peutConsulterDocument(
  role: acces.role,
  niveau: document.niveauConfidentialite,
  dossiersRattaches: document.dossiersRattaches,
  commissionsDuConsultant: acces.commissions.map((c) => c.id).toSet(),
);

class EcranArchivesAccesReserve extends StatelessWidget {
  const EcranArchivesAccesReserve({required this.titre, super.key});

  final String titre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: Center(child: Text(AppLocalizations.of(context)!.archivageAccesReserve)),
    );
  }
}
