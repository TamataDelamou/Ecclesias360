/// Règles pures de recherche biblique locale (RG-XXIV-05) : la recherche
/// par mot-clé s'exécute sur l'index local (FTS5, insensible aux accents),
/// hors connexion. Aucune recherche élargie n'existe encore : quand elle
/// viendra, elle devra rester distincte dans l'interface.
abstract final class RechercheBibliqueRules {
  /// Longueur minimale d'un mot recherché.
  static const longueurMinimale = 2;

  /// Construit l'expression FTS5 d'une saisie libre : chaque mot devient un
  /// terme entre guillemets (aucune syntaxe FTS5 de l'utilisateur n'est
  /// interprétée), le dernier en préfixe (recherche au fil de la frappe).
  /// `null` si aucun mot n'est assez long.
  static String? expressionFts(String saisie) {
    final mots = saisie
        .split(RegExp(r"[^\p{L}\p{N}]+", unicode: true))
        .where((m) => m.length >= longueurMinimale)
        .toList();
    if (mots.isEmpty) return null;
    final termes = [
      for (var i = 0; i < mots.length; i++) i == mots.length - 1 ? '"${mots[i]}"*' : '"${mots[i]}"',
    ];
    return termes.join(' ');
  }
}
