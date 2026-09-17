import 'package:ecclesias_360/features/parametres/data/referential/roles_referential.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('charge assets/config/roles.json et résout les capacités connues', () async {
    final referential = await RolesReferential.charger();

    expect(referential.roleMinimalPour('creer_noeud_niveau_superieur'), Role.administrateur);
    expect(referential.roleMinimalPour('consulter_annuaire_eglises'), Role.responsable);
    expect(referential.roleMinimalPour('capacite_inexistante'), isNull);
  });
}
