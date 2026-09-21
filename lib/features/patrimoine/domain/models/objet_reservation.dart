/// Nature de l'objet pour lequel un bien mobilisable est réservé
/// (Module XX, RG-XX-03). `culte` référence un `Culte` existant (Module
/// XII, construit) ; `evenement` anticipe le Module XVIII (Événements, non
/// construit) et `autre` couvre tout autre usage — ces deux derniers cas
/// portent leur description dans `ReservationBien.objetLibre`.
enum ObjetReservation {
  culte('culte'),
  evenement('evenement'),
  autre('autre');

  const ObjetReservation(this.code);

  final String code;

  static ObjetReservation fromCode(String code) => ObjetReservation.values
      .firstWhere((o) => o.code == code, orElse: () => throw ArgumentError('Objet de réservation inconnu : $code'));
}
