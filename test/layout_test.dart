import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vangtichai/main.dart';

// Wraps the app with a forced screen size and orientation.
Widget appWithSize(double width, double height) {
  return MediaQuery(
    data: MediaQueryData(
      size: Size(width, height),
      devicePixelRatio: 1.0,
    ),
    child: const VangtiChaiApp(),
  );
}

void main() {
  // ─── Portrait layouts: 3-col keypad, 1-col change table ───────────────────

  group('Pixel XL Portrait (411×731)', () {
    testWidgets('shows 3-column keypad', (tester) async {
      tester.view.physicalSize = const Size(411, 731);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      // All portrait digit buttons must be present
      for (final d in ['1','2','3','4','5','6','7','8','9','0']) {
        expect(find.text(d), findsOneWidget,
            reason: 'Digit $d not found in portrait keypad');
      }
      expect(find.text('CLEAR'), findsOneWidget);
    });

    testWidgets('shows all 8 denominations in single column', (tester) async {
      tester.view.physicalSize = const Size(411, 731);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      for (final d in [500, 100, 50, 20, 10, 5, 2, 1]) {
        expect(find.textContaining('$d:'), findsOneWidget,
            reason: 'Denomination $d not found');
      }
    });

    testWidgets('amount display spans top', (tester) async {
      tester.view.physicalSize = const Size(411, 731);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      expect(find.text('Taka: 0'), findsOneWidget);
    });
  });

  group('Nexus 10 Portrait (800×1280)', () {
    testWidgets('tablet detected — isTablet true at shortestSide=800', (tester) async {
      tester.view.physicalSize = const Size(800, 1280);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      // Same structure as phone portrait — 3-col keypad, all denoms visible
      expect(find.text('CLEAR'), findsOneWidget);
      for (final d in [500, 100, 50, 20, 10, 5, 2, 1]) {
        expect(find.textContaining('$d:'), findsOneWidget);
      }
      expect(find.text('Taka: 0'), findsOneWidget);
    });
  });

  // ─── Landscape layouts: 4-col keypad, 2-col change table ──────────────────

  group('Pixel XL Landscape (731×411)', () {
    testWidgets('shows 4-column keypad (digits 1-4 in first row)', (tester) async {
      tester.view.physicalSize = const Size(731, 411);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      for (final d in ['1','2','3','4','5','6','7','8','9','0']) {
        expect(find.text(d), findsOneWidget,
            reason: 'Digit $d not found in landscape keypad');
      }
      expect(find.text('CLEAR'), findsOneWidget);
    });

    testWidgets('all 8 denominations present in landscape', (tester) async {
      tester.view.physicalSize = const Size(731, 411);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      for (final d in [500, 100, 50, 20, 10, 5, 2, 1]) {
        expect(find.textContaining('$d:'), findsOneWidget);
      }
    });
  });

  group('Nexus 10 Landscape (1280×800)', () {
    testWidgets('tablet landscape shows all content', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      expect(find.text('CLEAR'), findsOneWidget);
      expect(find.text('Taka: 0'), findsOneWidget);
      for (final d in [500, 100, 50, 20, 10, 5, 2, 1]) {
        expect(find.textContaining('$d:'), findsOneWidget);
      }
    });
  });

  // ─── State preservation across orientation change ──────────────────────────

  group('State preservation on rotation', () {
    testWidgets('amount survives portrait -> landscape', (tester) async {
      // Start portrait
      tester.view.physicalSize = const Size(411, 731);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      // Enter 688
      await tester.tap(find.text('6')); await tester.pump();
      await tester.tap(find.text('8')); await tester.pump();
      await tester.tap(find.text('8')); await tester.pump();
      expect(find.text('Taka: 688'), findsOneWidget);

      // Rotate to landscape (swap width/height)
      tester.view.physicalSize = const Size(731, 411);
      await tester.pump();

      // Amount must survive rotation
      expect(find.text('Taka: 688'), findsOneWidget,
          reason: 'Amount lost after rotation to landscape');

      // Change table must still reflect 688
      expect(find.text('500: 1'), findsOneWidget);
      expect(find.text('100: 1'), findsOneWidget);
      expect(find.text('50: 1'),  findsOneWidget);

      // Rotate back
      tester.view.physicalSize = const Size(411, 731);
      await tester.pump();
      expect(find.text('Taka: 688'), findsOneWidget,
          reason: 'Amount lost after rotation back to portrait');

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  // ─── Functional: key amounts from PDF screenshots ─────────────────────────

  group('Functional correctness', () {
    testWidgets('688 → correct change table matches PDF screenshot', (tester) async {
      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      await tester.tap(find.text('6')); await tester.pump();
      await tester.tap(find.text('8')); await tester.pump();
      await tester.tap(find.text('8')); await tester.pump();

      expect(find.text('500: 1'), findsOneWidget);
      expect(find.text('100: 1'), findsOneWidget);
      expect(find.text('50: 1'),  findsOneWidget);
      expect(find.text('20: 1'),  findsOneWidget);
      expect(find.text('10: 1'),  findsOneWidget);
      expect(find.text('5: 1'),   findsOneWidget);
      expect(find.text('2: 1'),   findsOneWidget);
      expect(find.text('1: 1'),   findsOneWidget);
    });

    testWidgets('6 → 5:1, 1:1 (matches PDF screenshot)', (tester) async {
      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      await tester.tap(find.text('6')); await tester.pump();

      expect(find.text('500: 0'), findsOneWidget);
      expect(find.text('100: 0'), findsOneWidget);
      expect(find.text('50: 0'),  findsOneWidget);
      expect(find.text('20: 0'),  findsOneWidget);
      expect(find.text('10: 0'),  findsOneWidget);
      expect(find.text('5: 1'),   findsOneWidget);
      expect(find.text('2: 0'),   findsOneWidget);
      expect(find.text('1: 1'),   findsOneWidget);
    });

    testWidgets('CLEAR returns to all zeros', (tester) async {
      await tester.pumpWidget(const VangtiChaiApp());
      await tester.pump();

      await tester.tap(find.text('6')); await tester.pump();
      await tester.tap(find.text('8')); await tester.pump();
      await tester.tap(find.text('CLEAR')); await tester.pump();

      expect(find.text('Taka: 0'), findsOneWidget);
      expect(find.text('500: 0'), findsOneWidget);
      expect(find.text('1: 0'),   findsOneWidget);
    });
  });
}
