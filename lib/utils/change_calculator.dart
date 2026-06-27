const _denominations = [500, 100, 50, 20, 10, 5, 2, 1];

Map<int, int> calculateChange(int amount) {
  final result = <int, int>{};
  var remaining = amount;
  for (final denom in _denominations) {
    result[denom] = remaining ~/ denom;
    remaining %= denom;
  }
  return result;
}

List<int> get denominations => List.unmodifiable(_denominations);
