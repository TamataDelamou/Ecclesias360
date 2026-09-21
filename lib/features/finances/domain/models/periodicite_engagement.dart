/// Périodicité d'un engagement récurrent (Module XI, RG-XI-04). Le Cahier
/// n'impose pas de liste fermée précise ; ces quatre valeurs couvrent les
/// usages courants d'engagement financier d'église.
enum PeriodiciteEngagement {
  hebdomadaire('hebdomadaire'),
  mensuelle('mensuelle'),
  trimestrielle('trimestrielle'),
  annuelle('annuelle');

  const PeriodiciteEngagement(this.code);

  final String code;

  static PeriodiciteEngagement fromCode(String code) => PeriodiciteEngagement.values.firstWhere(
        (p) => p.code == code,
        orElse: () => throw ArgumentError("Périodicité d'engagement inconnue : $code"),
      );
}
