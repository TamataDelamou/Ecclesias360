import 'package:flutter/foundation.dart';

import '../../../core/audit/acteur.dart';
import '../../../core/error/app_error.dart';
import '../data/notes_pastorales_repository.dart';
import '../domain/models/note_pastorale.dart';

/// Contrôleur des notes pastorales privées (Module II, écran 13,
/// RG-II-11). Chaque appel transmet l'`Acteur` de la session au dépôt, qui
/// vérifie l'habilitation — l'écran n'est qu'une seconde barrière.
class NotesPastoralesController extends ChangeNotifier {
  NotesPastoralesController(this._repository);

  final NotesPastoralesRepository _repository;

  bool _enCours = false;
  String? _erreur;

  bool get enCours => _enCours;
  String? get erreur => _erreur;

  Stream<List<NotePastoraleResume>> watchNotesDuFidele({required Acteur acteur, required String fideleId}) =>
      _repository.watchNotesDuFidele(acteur: acteur, fideleId: fideleId);

  /// Ouverture journalisée ; lève `AppError` si l'acteur n'est pas habilité.
  Future<NotePastorale?> consulter({required Acteur acteur, required String noteId}) =>
      _repository.consulter(acteur: acteur, noteId: noteId);

  Stream<List<ConsultationNotePastorale>> watchConsultations({required Acteur acteur, required String noteId}) =>
      _repository.watchConsultations(acteur: acteur, noteId: noteId);

  Future<NotePastorale?> rediger({required Acteur acteur, required String fideleId, required String contenu}) =>
      _executer(() => _repository.rediger(acteur: acteur, fideleId: fideleId, contenu: contenu));

  Future<NotePastorale?> modifier({required Acteur acteur, required String noteId, required String contenu}) =>
      _executer(() => _repository.modifier(acteur: acteur, noteId: noteId, contenu: contenu));

  Future<T?> _executer<T>(Future<T> Function() action) async {
    _enCours = true;
    _erreur = null;
    notifyListeners();
    try {
      final resultat = await action();
      _enCours = false;
      notifyListeners();
      return resultat;
    } on AppError catch (error) {
      _enCours = false;
      _erreur = error.message;
      notifyListeners();
      return null;
    }
  }
}
