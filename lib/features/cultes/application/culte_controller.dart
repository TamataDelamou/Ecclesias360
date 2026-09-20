import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../data/culte_repository.dart';
import '../domain/models/culte.dart';
import '../domain/models/mode_presence.dart';
import '../domain/models/presence_culte.dart';
import '../domain/models/proposition_theme.dart';
import '../domain/models/publication_culte.dart';
import '../domain/models/sequence_liturgique.dart';
import '../domain/models/statut_culte.dart';
import '../domain/models/statut_proposition.dart';
import '../domain/models/valeur_vote.dart';
import '../domain/models/vote_proposition.dart';

/// Contrôleur du Module XII, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/culte/proposition — même précédent que `ComiteController`.
class CulteController extends ChangeNotifier {
  CulteController(this._repository);

  final CulteRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  // --- Cultes (RG-XII-01/02/05) --------------------------------------------

  Stream<List<Culte>> watchCultes(String noeudId) => _repository.watchCultes(noeudId);

  Future<Culte?> findCulteById(String id) => _repository.findCulteById(id);

  Future<bool> creerCulte({
    required String noeudId,
    required DateTime dateHeure,
    required String typeCulte,
    String? theme,
    String? predicateurId,
    ModePresence modePresence = ModePresence.nominal,
  }) => _executer(
        () => _repository.creerCulte(
          noeudId: noeudId,
          dateHeure: dateHeure,
          typeCulte: typeCulte,
          theme: theme,
          predicateurId: predicateurId,
          modePresence: modePresence,
        ),
      );

  /// RG-XII-05 — crée une série de cultes récurrents (occurrences
  /// hebdomadaires) à partir d'une première date/heure.
  Future<bool> creerSerieRecurrente({
    required String noeudId,
    required DateTime premiereDateHeure,
    required String typeCulte,
    String? theme,
    String? predicateurId,
    ModePresence modePresence = ModePresence.nominal,
    required int nombreOccurrences,
  }) => _executer(
        () => _repository.creerSerieRecurrente(
          noeudId: noeudId,
          premiereDateHeure: premiereDateHeure,
          typeCulte: typeCulte,
          theme: theme,
          predicateurId: predicateurId,
          modePresence: modePresence,
          nombreOccurrences: nombreOccurrences,
        ),
      );

  Future<bool> changerStatutCulte({required String id, required StatutCulte statut}) =>
      _executer(() => _repository.changerStatutCulte(id: id, statut: statut));

  // --- Présences (RG-XII-02) ------------------------------------------------

  Stream<List<PresenceCulte>> watchPresences(String culteId) => _repository.watchPresences(culteId);

  Future<bool> ajouterPresenceNominale({required String culteId, required String fideleId}) =>
      _executer(() => _repository.ajouterPresenceNominale(culteId: culteId, fideleId: fideleId));

  Future<bool> retirerPresenceNominale(String id) => _executer(() => _repository.retirerPresenceNominale(id));

  Future<bool> definirCompteGlobalPresence({required String culteId, required int compte}) =>
      _executer(() => _repository.definirCompteGlobalPresence(culteId: culteId, compte: compte));

  // --- Liturgie (RG-XII-01) -------------------------------------------------

  Stream<List<SequenceLiturgique>> watchSequences(String culteId) => _repository.watchSequences(culteId);

  Future<bool> ajouterSequence({
    required String culteId,
    required int ordre,
    required String libelle,
    String? responsableId,
    int? dureePrevueMinutes,
  }) => _executer(
        () => _repository.ajouterSequence(
          culteId: culteId,
          ordre: ordre,
          libelle: libelle,
          responsableId: responsableId,
          dureePrevueMinutes: dureePrevueMinutes,
        ),
      );

  Future<bool> retirerSequence(String id) => _executer(() => _repository.retirerSequence(id));

  // --- Publication post-culte (RG-XII-03) -----------------------------------

  Stream<PublicationCulte?> watchPublication(String culteId) => _repository.watchPublication(culteId);

  Future<bool> publier({
    required String culteId,
    String? texteBiblique,
    String? audioUrl,
    String? videoUrl,
    String? pdfUrl,
  }) => _executer(
        () => _repository.publier(
          culteId: culteId,
          texteBiblique: texteBiblique,
          audioUrl: audioUrl,
          videoUrl: videoUrl,
          pdfUrl: pdfUrl,
        ),
      );

  // --- Propositions de thème (RG-XII-06) --------------------------------------

  Stream<List<PropositionTheme>> watchPropositions() => _repository.watchPropositions();

  Future<bool> soumettreProposition({required String fideleId, required String titre, String? explication}) =>
      _executer(
        () => _repository.soumettreProposition(fideleId: fideleId, titre: titre, explication: explication),
      );

  Future<bool> changerStatutProposition({required String id, required StatutProposition statut}) =>
      _executer(() => _repository.changerStatutProposition(id: id, statut: statut));

  Stream<List<VoteProposition>> watchVotes(String propositionId) => _repository.watchVotes(propositionId);

  /// RG-XII-06 — un vote par fidèle et par proposition ; voter à nouveau
  /// change simplement le sens du vote (jamais un second vote compté).
  Future<bool> voter({required String propositionId, required String fideleId, required ValeurVote valeur}) =>
      _executer(() => _repository.voter(propositionId: propositionId, fideleId: fideleId, valeur: valeur));

  Future<bool> _executer(Future<void> Function() action) async {
    _enCours = true;
    _erreur = null;
    notifyListeners();
    try {
      await action();
      _enCours = false;
      notifyListeners();
      return true;
    } on AppError catch (error) {
      _enCours = false;
      _erreur = error.message;
      notifyListeners();
      return false;
    } on ArgumentError catch (error) {
      _enCours = false;
      _erreur = error.message?.toString() ?? 'Requête invalide.';
      notifyListeners();
      return false;
    }
  }
}
