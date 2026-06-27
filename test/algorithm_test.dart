import 'package:flutter_test/flutter_test.dart';
import 'package:vangtichai/utils/change_calculator.dart';

void main() {
  test('calculates 688 correctly matching PDF screenshot', () {
    final result = calculateChange(688);
    expect(result[500], 1);
    expect(result[100], 1);
    expect(result[50],  1);
    expect(result[20],  1);
    expect(result[10],  1);
    expect(result[5],   1);
    expect(result[2],   1);
    expect(result[1],   1);
  });

  test('calculates 6 correctly (5:1, 1:1)', () {
    final result = calculateChange(6);
    expect(result[500], 0);
    expect(result[5],   1);
    expect(result[1],   1);
  });

  test('calculates 0 correctly (all zeros)', () {
    final result = calculateChange(0);
    for (final v in result.values) { expect(v, 0); }
  });

  test('digit append: 2 -> 23 -> 234', () {
    int amount = 0;
    amount = amount * 10 + 2; expect(amount, 2);
    amount = amount * 10 + 3; expect(amount, 23);
    amount = amount * 10 + 4; expect(amount, 234);
  });
}
