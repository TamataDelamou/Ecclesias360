import '../../../parametres/domain/models/role.dart';

/// Entité pure NotePastorale (écran 13 du Module II, RG-II-11) — note privée
/// d'un pasteur sur un fidèle. `noeudId` est le nœud du fidèle **au moment
/// de la rédaction** : la note reste à ce nœud, elle ne suit pas une
/// mutation (Module IX). `fideleId`, `auteurFideleId` et `noeudId` sont
/// immuables ; seul `contenu` est modifiable, par l'auteur seul.
class NotePastorale {
  const NotePastorale({
    required this.id,
    required this.fideleId,
    required this.auteurFideleId,
    required this.noeudId,
    required this.contenu,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String fideleId;
  final String auteurFideleId;
  final String noeudId;
  final String contenu;
  final DateTime createdAt;
  final DateTime updatedAt;
}

/// Ce qu'une liste de notes expose (RG-II-11) : l'auteur et les dates,
/// jamais le contenu — lu seulement à l'ouverture, qui est journalisée.
class NotePastoraleResume {
  const NotePastoraleResume({
    required this.id,
    required this.fideleId,
    required this.auteurFideleId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String fideleId;
  final String auteurFideleId;
  final DateTime createdAt;
  final DateTime updatedAt;
}

/// Trace d'une ouverture de note pastorale (RG-II-11, RG-SEC-06 par
/// analogie). `fideleId` est `null` pour un compte sans fiche.
class ConsultationNotePastorale {
  const ConsultationNotePastorale({
    required this.id,
    required this.noteId,
    required this.authUserId,
    required this.fideleId,
    required this.role,
    required this.consulteLe,
  });

  final String id;
  final String noteId;
  final String authUserId;
  final String? fideleId;
  final Role role;
  final DateTime consulteLe;
}
