import 'package:flutter/material.dart';
import '../utils/app_dimensions.dart';
import '../utils/change_calculator.dart';

class ChangeTable extends StatelessWidget {
  final Map<int, int> changeMap;
  final int columns;
  final bool isTablet;

  const ChangeTable({
    super.key,
    required this.changeMap,
    this.columns = 1,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = isTablet
        ? AppDimensions.tableFontSizeTablet
        : AppDimensions.tableFontSize;
    final allDenoms = denominations;

    return columns == 1
        ? _buildSingleColumn(allDenoms, fontSize)
        : _buildTwoColumns(allDenoms, fontSize);
  }

  Widget _buildSingleColumn(List<int> denoms, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: denoms.map((d) => _row(d, fontSize)).toList(),
    );
  }

  Widget _buildTwoColumns(List<int> denoms, double fontSize) {
    final half = denoms.length ~/ 2;
    final left = denoms.sublist(0, half);
    final right = denoms.sublist(half);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: left.map((d) => _row(d, fontSize)).toList(),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: right.map((d) => _row(d, fontSize)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _row(int denom, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.tableRowPadding,
        horizontal: AppDimensions.screenPadding,
      ),
      child: Text(
        '$denom: ${changeMap[denom] ?? 0}',
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
