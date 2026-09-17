/// Catégorisation confessionnelle obligatoire et immuable des nœuds de type
/// « église locale » (RG-I-09).
enum CategorieConfessionnelle {
  catholique('catholique'),
  autres('autres');

  const CategorieConfessionnelle(this.code);

  final String code;

  static CategorieConfessionnelle fromCode(String code) => values.firstWhere(
        (categorie) => categorie.code == code,
        orElse: () => throw ArgumentError('Catégorie confessionnelle inconnue : $code'),
      );
}
