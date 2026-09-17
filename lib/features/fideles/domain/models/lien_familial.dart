import 'type_lien.dart';

/// Entité pure LienFamilial (RG-II-04).
class LienFamilial {
  const LienFamilial({
    required this.id,
    required this.fideleId1,
    required this.fideleId2,
    required this.typeLien,
  });

  final String id;
  final String fideleId1;
  final String fideleId2;
  final TypeLien typeLien;
}
