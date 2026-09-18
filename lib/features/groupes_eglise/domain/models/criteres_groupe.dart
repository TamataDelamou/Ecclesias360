import 'dart:convert';

/// RG-VI-01 — critères calculables d'un groupe automatique : tous les
/// critères renseignés doivent correspondre (ET logique). Champs non
/// renseignés = non contraignants. Codes alignés sur les enums du Module
/// II (`Sexe`, `StatutCivil`, `StatutSpirituel`) mais stockés en texte brut
/// ici pour rester un objet de valeur pur, sans dépendance à ces enums.
class CriteresGroupe {
  const CriteresGroupe({this.sexe, this.statutCivil, this.statutSpirituel, this.ageMin, this.ageMax});

  final String? sexe;
  final String? statutCivil;
  final String? statutSpirituel;
  final int? ageMin;
  final int? ageMax;

  factory CriteresGroupe.fromJson(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return CriteresGroupe(
      sexe: map['sexe'] as String?,
      statutCivil: map['statutCivil'] as String?,
      statutSpirituel: map['statutSpirituel'] as String?,
      ageMin: map['ageMin'] as int?,
      ageMax: map['ageMax'] as int?,
    );
  }

  String toJson() {
    return jsonEncode({
      if (sexe != null) 'sexe': sexe,
      if (statutCivil != null) 'statutCivil': statutCivil,
      if (statutSpirituel != null) 'statutSpirituel': statutSpirituel,
      if (ageMin != null) 'ageMin': ageMin,
      if (ageMax != null) 'ageMax': ageMax,
    });
  }
}
