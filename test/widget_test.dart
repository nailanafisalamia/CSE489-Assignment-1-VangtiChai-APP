import 'package:flutter_test/flutter_test.dart';
import 'package:vangtichai/main.dart';

void main() {
  testWidgets('App renders VangtiChai title', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());
    expect(find.text('VangtiChai'), findsOneWidget);
  });
}
