/// Contenu de la médiathèque marqué en favori par un fidèle (Module XIII,
/// RG-XIII-04).
class Favori {
  const Favori({
    required this.id,
    required this.fideleId,
    required this.contenuId,
  });

  final String id;
  final String fideleId;
  final String contenuId;
}
