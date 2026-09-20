import 'mode_presence.dart';
import 'statut_culte.dart';

/// RG-XII-01/02/05 — [serieRecurrenteId] regroupe les occurrences d'un
/// culte récurrent (RG-XII-05) ; [estException] marque une occurrence
/// modifiée ponctuellement sans affecter les autres occurrences de la
/// série.
class Culte {
  const Culte({
    required this.id,
    required this.noeudId,
    required this.dateHeure,
    required this.typeCulte,
    required this.statut,
    required this.modePresence,
    this.theme,
    this.predicateurId,
    this.compteGlobalPresence,
    this.serieRecurrenteId,
    this.estException = false,
  });

  final String id;
  final String noeudId;
  final DateTime dateHeure;
  final String typeCulte;
  final String? theme;
  final String? predicateurId;
  final StatutCulte statut;
  final ModePresence modePresence;
  final int? compteGlobalPresence;
  final String? serieRecurrenteId;
  final bool estException;
}
