import '../models/livre_biblique.dart';

/// Règles pures de référence biblique (Module XXIV) : lecture d'une
/// référence saisie, navigation entre chapitres. Aucune dépendance au corpus
/// ni à Flutter : les livres de la version sont passés en paramètre.
abstract final class BibleReferenceRules {
  /// Normalise un nom de livre pour comparaison : minuscules, sans accents,
  /// sans espaces ni points (« 1 Co. » → « 1co », « Ésaïe » → « esaie »).
  static String normaliserNom(String nom) {
    const accents = {
      'à': 'a', 'â': 'a', 'ä': 'a', 'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e', 'î': 'i', 'ï': 'i',
      'ô': 'o', 'ö': 'o', 'ù': 'u', 'û': 'u', 'ü': 'u', 'ç': 'c', 'œ': 'oe',
    };
    final minuscule = nom.toLowerCase();
    final tampon = StringBuffer();
    for (final rune in minuscule.runes) {
      final c = String.fromCharCode(rune);
      tampon.write(accents[c] ?? c);
    }
    return tampon.toString().replaceAll(RegExp(r'[\s.]'), '');
  }

  /// Lit une référence saisie (« Jean 3:16 », « Jn 3,16 », « 1 Co 13 »,
  /// « Psaumes 23 ») parmi les [livres] d'une version. `null` si le livre
  /// est inconnu ou si le chapitre n'existe pas dans cette version.
  static ReferenceBiblique? lire(String saisie, List<LivreBiblique> livres) {
    final m = RegExp(r'^\s*(.+?)\s*(\d+)\s*(?:[:,.]\s*(\d+))?\s*$').firstMatch(saisie);
    if (m == null) return null;
    final nom = normaliserNom(m[1]!);
    if (nom.isEmpty) return null;
    LivreBiblique? trouve;
    for (final livre in livres) {
      if (normaliserNom(livre.abreviation) == nom || normaliserNom(livre.nom) == nom) {
        trouve = livre;
        break;
      }
    }
    // Préfixe non ambigu du nom complet (« Genes » → Genèse).
    if (trouve == null && nom.length >= 3) {
      final candidats = livres.where((l) => normaliserNom(l.nom).startsWith(nom)).toList();
      if (candidats.length == 1) trouve = candidats.single;
    }
    if (trouve == null) return null;
    final chapitre = int.parse(m[2]!);
    if (chapitre < 1 || chapitre > trouve.nbChapitres) return null;
    final verset = m[3] == null ? null : int.parse(m[3]!);
    if (verset != null && verset < 1) return null;
    return ReferenceBiblique(bookId: trouve.bookId, chapitre: chapitre, verset: verset);
  }

  static List<LivreBiblique> _dansLOrdre(List<LivreBiblique> livres) => [...livres]..sort((a, b) => a.ordre.compareTo(b.ordre));

  /// Chapitre suivant dans l'ordre d'affichage de la version, en passant au
  /// livre suivant après le dernier chapitre ; `null` à la fin de la Bible.
  static ReferenceBiblique? chapitreSuivant(ReferenceBiblique courant, List<LivreBiblique> livres) {
    final ordonnes = _dansLOrdre(livres);
    final i = ordonnes.indexWhere((l) => l.bookId == courant.bookId);
    if (i < 0) return null;
    if (courant.chapitre < ordonnes[i].nbChapitres) {
      return ReferenceBiblique(bookId: courant.bookId, chapitre: courant.chapitre + 1);
    }
    return i + 1 < ordonnes.length ? ReferenceBiblique(bookId: ordonnes[i + 1].bookId, chapitre: 1) : null;
  }

  /// Chapitre précédent, symétrique de [chapitreSuivant] ; `null` au début.
  static ReferenceBiblique? chapitrePrecedent(ReferenceBiblique courant, List<LivreBiblique> livres) {
    final ordonnes = _dansLOrdre(livres);
    final i = ordonnes.indexWhere((l) => l.bookId == courant.bookId);
    if (i < 0) return null;
    if (courant.chapitre > 1) return ReferenceBiblique(bookId: courant.bookId, chapitre: courant.chapitre - 1);
    return i > 0 ? ReferenceBiblique(bookId: ordonnes[i - 1].bookId, chapitre: ordonnes[i - 1].nbChapitres) : null;
  }

  /// Ramène une référence dans une version : inchangée si la version
  /// possède ce livre et ce chapitre (les identifiants sont stables) ; au
  /// dernier chapitre du livre s'il en a moins (versifications différentes) ;
  /// sinon premier chapitre de son premier livre — un livre deutérocanonique
  /// ouvert en Crampon n'existe pas en LSG 1910.
  static ReferenceBiblique adapterAVersion(ReferenceBiblique reference, List<LivreBiblique> livres) {
    for (final livre in livres) {
      if (livre.bookId == reference.bookId) {
        return reference.chapitre >= 1 && reference.chapitre <= livre.nbChapitres
            ? reference
            : ReferenceBiblique(bookId: reference.bookId, chapitre: livre.nbChapitres);
      }
    }
    return ReferenceBiblique(bookId: _dansLOrdre(livres).first.bookId, chapitre: 1);
  }
}
