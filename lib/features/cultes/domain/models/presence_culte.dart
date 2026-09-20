/// RG-XII-02 — pointage nominal : une ligne par fidèle présent. Utilisée
/// uniquement quand `Culte.modePresence == ModePresence.nominal` (voir
/// `Culte.compteGlobalPresence` pour le mode global).
class PresenceCulte {
  const PresenceCulte({required this.id, required this.culteId, required this.fideleId});

  final String id;
  final String culteId;
  final String fideleId;
}
