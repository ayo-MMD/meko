import 'package:flutter_test/flutter_test.dart';
import 'package:meko/app.dart';

void main() {
  testWidgets('MekoApp renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MekoApp());
    expect(find.text("Let's go in"), findsOneWidget);
  });
}
