import 'package:flutter/foundation.dart';

import '../../../core/error/app_error.dart';
import '../../parametres/domain/models/role.dart';
import '../data/archivage_repository.dart';
import '../domain/models/document_archive.dart';
import '../domain/models/version_document.dart';

/// Contrôleur du Module VIII, exposé aux écrans (pattern `provider`). Sans
/// cache local : chaque écran observe directement les streams du dépôt,
/// scopés par nœud/document — même précédent que `CulteController`/
/// `ComiteController`.
class ArchivageController extends ChangeNotifier {
  ArchivageController(this._repository);

  final ArchivageRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  Stream<List<DocumentArchive>> watchBibliotheque({String? noeudId, String? moduleOrigine}) =>
      _repository.watchBibliotheque(noeudId: noeudId, moduleOrigine: moduleOrigine);

  Stream<List<DocumentArchive>> watchCorbeille({String? noeudId}) => _repository.watchCorbeille(noeudId: noeudId);

  Future<DocumentArchive?> findById(String id) => _repository.findById(id);

  /// RG-VIII-03 / RG-SEC-06 — lecture contrôlée et journalisée (voir
  /// `ArchivageRepository.consulter`) ; lève `AppError` sans habilitation.
  Future<DocumentArchive?> consulter({
    required String documentId,
    required String authUserId,
    required String? fideleId,
    required Role role,
  }) =>
      _repository.consulter(documentId: documentId, authUserId: authUserId, fideleId: fideleId, role: role);

  Stream<List<VersionDocument>> watchVersions(String documentId) => _repository.watchVersions(documentId);

  Future<bool> nouvelleVersion({required String documentId, required String fichier}) =>
      _executer(() => _repository.nouvelleVersion(documentId: documentId, fichier: fichier));

  Future<bool> mettreEnCorbeille(String id) => _executer(() => _repository.mettreEnCorbeille(id));

  Future<bool> restaurerDeCorbeille(String id) => _executer(() => _repository.restaurerDeCorbeille(id));

  Future<bool> purgerDefinitivement(String id, {required int delaiPurgeJours, required Role roleActeur}) => _executer(
        () => _repository.purgerDefinitivement(id, delaiPurgeJours: delaiPurgeJours, roleActeur: roleActeur),
      );

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
    }
  }
}
