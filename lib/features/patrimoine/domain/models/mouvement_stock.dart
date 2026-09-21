import 'type_mouvement_stock.dart';

/// Mouvement d'entrée ou de sortie d'un bien à gestion de stock
/// (Module XX, RG-XX-05). La quantité en stock n'est jamais une colonne
/// stockée : elle se recalcule à la lecture (entrées moins sorties), même
/// précédent que le solde de projet (Module XI, RG-XI-03) et le décompte
/// des votes (Module XII, RG-XII-06).
class MouvementStock {
  const MouvementStock({
    required this.id,
    required this.bienId,
    required this.type,
    required this.quantite,
    required this.date,
    this.motif,
  });

  final String id;
  final String bienId;
  final TypeMouvementStock type;
  final int quantite;
  final DateTime date;
  final String? motif;
}
