import 'criteres_groupe.dart';
import 'type_regle_groupe.dart';

/// RG-VI-01/02 — segment démographique ou fonctionnel de l'assemblée.
class GroupeEglise {
  const GroupeEglise({
    required this.id,
    required this.code,
    required this.libelle,
    required this.typeRegle,
    this.criteres,
  });

  final String id;
  final String code;
  final String libelle;
  final TypeRegleGroupe typeRegle;
  final CriteresGroupe? criteres;
}
