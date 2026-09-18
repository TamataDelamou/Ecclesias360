/// RG-IV-03 — correspondance don spirituel ↔ type de ministère compatible
/// (Module III), utilisée pour alimenter la suggestion d'affectation.
/// Aucune paire n'est pré-remplie (jugement pastoral/organisationnel, hors
/// périmètre technique) : à renseigner via une future administration.
class DonMinistereCompatible {
  const DonMinistereCompatible({
    required this.id,
    required this.donId,
    required this.typeMinistereId,
  });

  final String id;
  final String donId;
  final String typeMinistereId;
}
