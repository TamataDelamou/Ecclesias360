import 'package:ecclesias_360/app.dart';
import 'package:ecclesias_360/features/home/presentation/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EcclesiasApp démarre sur HomeScreen', (tester) async {
    await tester.pumpWidget(const EcclesiasApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
