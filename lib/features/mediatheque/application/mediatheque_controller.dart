import 'package:flutter/foundation.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../data/mediatheque_repository.dart';
import '../domain/models/commentaire.dart';
import '../domain/models/contenu_mediatheque.dart';
import '../domain/models/favori.dart';
import '../domain/models/signalement_commentaire.dart';
import '../domain/models/statut_moderation_commentaire.dart';

/// Contrôleur du Module XIII, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// même précédent que `CulteController`/`ComiteController`.
class MediathequeController extends ChangeNotifier {
  MediathequeController(this._repository);

  final MediathequeRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  // --- Catalogue (RG-XIII-01/02) --------------------------------------------

  Stream<List<ContenuMediatheque>> watchCatalogue() => _repository.watchCatalogue();

  Stream<ContenuMediatheque?> watchContenu(String id) => _repository.watchContenu(id);

  /// RG-XIII-01 — recherche par thème ; laissée à la charge de l'écran de
  /// n'appeler cette méthode que pour un mot-clé non vide.
  Future<List<ContenuMediatheque>> rechercherParTheme(String motCle) =>
      _repository.rechercherParTheme(motCle);

  Future<void> enregistrerConsultation(String contenuId) => _repository.enregistrerConsultation(contenuId);

  // --- Favoris (RG-XIII-04) ---------------------------------------------------

  Stream<List<Favori>> watchFavoris(String fideleId) => _repository.watchFavoris(fideleId);

  Future<bool> toggleFavori({required String fideleId, required String contenuId}) =>
      _executer(() => _repository.toggleFavori(fideleId: fideleId, contenuId: contenuId));

  // --- Commentaires (RG-XIII-03) ----------------------------------------------

  Stream<List<Commentaire>> watchCommentaires(String contenuId) => _repository.watchCommentaires(contenuId);

  Future<bool> ajouterCommentaire({required String contenuId, required String fideleId, required String texte}) =>
      _executer(() => _repository.ajouterCommentaire(contenuId: contenuId, fideleId: fideleId, texte: texte));

  /// RG-XIII-03 — signalement attribué à la fiche de la session.
  Future<bool> signalerCommentaire({required String commentaireId, required String? fideleId, String? motif}) =>
      _executer(() => _repository.signalerCommentaire(commentaireId: commentaireId, fideleId: fideleId, motif: motif));

  /// RG-XIII-03 — décision de modération, réservée et tracée.
  Future<bool> modererCommentaire({
    required String id,
    required StatutModerationCommentaire nouveauStatut,
    required Acteur acteur,
  }) => _executer(() => _repository.modererCommentaire(id: id, nouveauStatut: nouveauStatut, acteur: acteur));

  Stream<List<Commentaire>> watchCommentairesAModerer() => _repository.watchCommentairesAModerer();

  Stream<List<SignalementCommentaire>> watchSignalements(String commentaireId) =>
      _repository.watchSignalements(commentaireId);

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
