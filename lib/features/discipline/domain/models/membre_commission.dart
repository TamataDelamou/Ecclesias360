/// RG-X-02 — appartenance d'un fidèle à une commission disciplinaire.
class MembreCommission {
  const MembreCommission({
    required this.id,
    required this.commissionId,
    required this.fideleId,
  });

  final String id;
  final String commissionId;
  final String fideleId;
}
