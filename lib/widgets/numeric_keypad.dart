import 'package:flutter/material.dart';
import '../utils/app_dimensions.dart';

class NumericKeypad extends StatelessWidget {
  final int columns; // 3 for portrait, 4 for landscape
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

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.buttonPadding),
      child: columns == 3
          ? _buildPortraitLayout(fontSize)
          : _buildLandscapeLayout(fontSize),
    );
  }

  // Portrait (3 cols): rows [1,2,3], [4,5,6], [7,8,9], [0, CLEAR(2)]
  Widget _buildPortraitLayout(double fontSize) {
    return Column(
      children: [
        _row([1, 2, 3], fontSize),
        _row([4, 5, 6], fontSize),
        _row([7, 8, 9], fontSize),
        _lastRow([0], fontSize),
      ],
    );
  }

  // Landscape (4 cols): rows [1,2,3,4], [5,6,7,8], [9,0, CLEAR(2)]
  Widget _buildLandscapeLayout(double fontSize) {
    return Column(
      children: [
        _row([1, 2, 3, 4], fontSize),
        _row([5, 6, 7, 8], fontSize),
        _lastRow([9, 0], fontSize),
      ],
    );
  }

  Widget _row(List<int> digits, double fontSize) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: digits
            .map((d) => _digitButton(d, fontSize))
            .toList(),
      ),
    );
  }

  // Last row: provided digits + CLEAR spanning 2 columns
  Widget _lastRow(List<int> digits, double fontSize) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...digits.map((d) => _digitButton(d, fontSize)),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.buttonPadding),
              child: ElevatedButton(
                onPressed: onClear,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.buttonBorderRadius),
                  ),
                  elevation: AppDimensions.buttonElevation,
                  minimumSize: const Size(0, AppDimensions.buttonMinHeight),
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'CLEAR',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _digitButton(int digit, double fontSize) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.buttonPadding),
        child: ElevatedButton(
          onPressed: () => onDigit(digit),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.buttonBorderRadius),
            ),
            elevation: AppDimensions.buttonElevation,
            minimumSize: const Size(0, AppDimensions.buttonMinHeight),
          ),
          child: Text(
            '$digit',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
