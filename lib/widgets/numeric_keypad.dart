import 'package:flutter/material.dart';
import '../utils/app_dimensions.dart';

class NumericKeypad extends StatelessWidget {
  final int columns;
  final bool isTablet;
  final void Function(int digit) onDigit;
  final VoidCallback onClear;

  const NumericKeypad({
    super.key,
    required this.columns,
    required this.onDigit,
    required this.onClear,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = isTablet
        ? AppDimensions.buttonFontSizeTablet
        : AppDimensions.buttonFontSize;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.keypadBorderRadius),
      ),
      padding: const EdgeInsets.all(AppDimensions.keypadPadding),
      child: columns == 3
          ? _buildPortraitGrid(context, fontSize)
          : _buildLandscapeGrid(context, fontSize),
    );
  }

  Widget _buildPortraitGrid(BuildContext context, double fontSize) {
    return Column(
      children: [
        _buildRow(context, [1, 2, 3], fontSize),
        _buildRow(context, [4, 5, 6], fontSize),
        _buildRow(context, [7, 8, 9], fontSize),
        _buildLastRowPortrait(context, fontSize),
      ],
    );
  }

  Widget _buildLandscapeGrid(BuildContext context, double fontSize) {
    return Column(
      children: [
        _buildRow(context, [1, 2, 3, 4], fontSize),
        _buildRow(context, [5, 6, 7, 8], fontSize),
        _buildLastRowLandscape(context, fontSize),
      ],
    );
  }

  Widget _buildRow(BuildContext context, List<int> digits, double fontSize) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
            digits.map((d) => _digitButton(context, d, fontSize)).toList(),
      ),
    );
  }

  Widget _buildLastRowPortrait(BuildContext context, double fontSize) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _digitButton(context, 0, fontSize),
          Expanded(
            flex: 2,
            child: _gap(
              child: _clearButton(context, fontSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastRowLandscape(BuildContext context, double fontSize) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _digitButton(context, 9, fontSize),
          _digitButton(context, 0, fontSize),
          Expanded(
            flex: 2,
            child: _gap(
              child: _clearButton(context, fontSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget _digitButton(BuildContext context, int digit, double fontSize) {
    return Expanded(
      child: _gap(
        child: FilledButton.tonal(
          onPressed: () => onDigit(digit),
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.buttonBorderRadius),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            '$digit',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _clearButton(BuildContext context, double fontSize) {
    final cs = Theme.of(context).colorScheme;
    return FilledButton(
      onPressed: onClear,
      style: FilledButton.styleFrom(
        backgroundColor: cs.error,
        foregroundColor: cs.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonBorderRadius),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        'CLR',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _gap({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.buttonGap),
      child: child,
    );
  }
}
