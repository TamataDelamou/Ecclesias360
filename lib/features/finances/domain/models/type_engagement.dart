/// Type d'un engagement récurrent (Module XI, RG-XI-04) — liste fermée par
/// le Cahier, qui ne cite que ces deux formes.
enum TypeEngagement {
  dimeEngagement('dime_engagement'),
  promesseDon('promesse_don');

  const TypeEngagement(this.code);

  final String code;

  static TypeEngagement fromCode(String code) => TypeEngagement.values.firstWhere(
        (t) => t.code == code,
        orElse: () => throw ArgumentError("Type d'engagement inconnu : $code"),
      );
}
