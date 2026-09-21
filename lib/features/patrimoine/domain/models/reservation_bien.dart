import 'objet_reservation.dart';

/// Réservation datée d'un bien mobilisable (Module XX, RG-XX-03), pour un
/// culte ou un événement. `PatrimoineRules.seChevauchent` empêche tout
/// conflit de double réservation sur la même plage horaire pour un même
/// bien.
class ReservationBien {
  const ReservationBien({
    required this.id,
    required this.bienId,
    required this.objetReservation,
    this.culteId,
    this.objetLibre,
    required this.dateDebut,
    required this.dateFin,
  });

  final String id;
  final String bienId;
  final ObjetReservation objetReservation;
  final String? culteId;
  final String? objetLibre;
  final DateTime dateDebut;
  final DateTime dateFin;
}
