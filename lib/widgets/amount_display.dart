import 'package:flutter/material.dart';
import '../utils/app_dimensions.dart';

class AmountDisplay extends StatelessWidget {
  final int amount;
  final bool isTablet;

  const AmountDisplay({
    super.key,
    required this.amount,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = isTablet
        ? AppDimensions.amountFontSizeTablet
        : AppDimensions.amountFontSize;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.amountPadding),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        'Taka: $amount',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
