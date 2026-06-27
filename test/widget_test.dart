import 'package:flutter_test/flutter_test.dart';
import 'package:vangtichai/main.dart';

void main() {
  testWidgets('App shows Taka display and keypad', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());

    expect(find.text('Taka: 0'), findsOneWidget);
    expect(find.text('CLEAR'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
  });

  testWidgets('Tapping digits appends to amount', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());

    await tester.tap(find.text('6'));
    await tester.pump();
    expect(find.text('Taka: 6'), findsOneWidget);

    await tester.tap(find.text('8'));
    await tester.pump();
    expect(find.text('Taka: 68'), findsOneWidget);

    await tester.tap(find.text('8'));
    await tester.pump();
    expect(find.text('Taka: 688'), findsOneWidget);
  });

  testWidgets('CLEAR resets amount to 0', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());

    await tester.tap(find.text('6'));
    await tester.pump();
    await tester.tap(find.text('CLEAR'));
    await tester.pump();
    expect(find.text('Taka: 0'), findsOneWidget);
  });

  testWidgets('Change table shows all 8 denominations', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());

    expect(find.textContaining('500:'), findsOneWidget);
    expect(find.textContaining('100:'), findsOneWidget);
    expect(find.textContaining('50:'), findsOneWidget);
    expect(find.textContaining('20:'), findsOneWidget);
    expect(find.textContaining('10:'), findsOneWidget);
    expect(find.textContaining('5:'), findsOneWidget);
    expect(find.textContaining('2:'), findsOneWidget);
    expect(find.textContaining('1:'), findsOneWidget);
  });
}
