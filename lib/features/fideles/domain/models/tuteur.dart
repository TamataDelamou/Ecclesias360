/// Entité pure Tuteur (RG-II-06) — tuteur légal d'un fidèle mineur, soit un
/// autre fidèle enregistré ([tuteurFideleId]), soit un tiers non enregistré
/// ([tuteurTiersNom]/[tuteurTiersTelephone]). Exactement l'un des deux doit
/// être renseigné (voir `FideleRules.validerTuteur`).
class Tuteur {
  const Tuteur({
    required this.id,
    required this.mineurId,
    required this.lien,
    this.tuteurFideleId,
    this.tuteurTiersNom,
    this.tuteurTiersTelephone,
  });

  final String id;
  final String mineurId;
  final String lien;
  final String? tuteurFideleId;
  final String? tuteurTiersNom;
  final String? tuteurTiersTelephone;

  bool get estFideleEnregistre => tuteurFideleId != null;
}
