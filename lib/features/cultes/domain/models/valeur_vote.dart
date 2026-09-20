enum ValeurVote {
  jaime('jaime'),
  jenaimepas('jenaimepas');

  const ValeurVote(this.code);

  final String code;

  static ValeurVote fromCode(String code) => values.firstWhere(
        (v) => v.code == code,
        orElse: () => throw ArgumentError('Valeur de vote inconnue : $code'),
      );
}
