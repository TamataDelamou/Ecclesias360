import 'package:drift/native.dart';
import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/home/presentation/home_screen.dart';
import 'package:ecclesias_360/features/organization/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EcclesiasApp démarre sur HomeScreen', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(EcclesiasApp(database: database));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);

    // Le dépôt Module I annule un flux Drift dans
    // OrganisationController.dispose() lors du démontage final du widget ;
    // drift attend explicitement Database.close() dans les tests pour
    // libérer son minuteur interne de fermeture différée (voir le
    // commentaire de StreamQueryStore.markAsClosed), sans quoi
    // flutter_test échoue sur « Timer is still pending ».
    await database.close();
  });
}
