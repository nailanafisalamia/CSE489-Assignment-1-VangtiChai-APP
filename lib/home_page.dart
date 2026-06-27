import 'package:flutter/material.dart';
import 'utils/app_dimensions.dart';
import 'utils/change_calculator.dart';
import 'widgets/amount_display.dart';
import 'widgets/change_table.dart';
import 'widgets/numeric_keypad.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _amount = 0;

  void _onDigit(int digit) {
    setState(() {
      _amount = _amount * 10 + digit;
    });
  }

  void _onClear() {
    setState(() {
      _amount = 0;
    });
  }

  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTablet(context);
    final changeMap = calculateChange(_amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VangtiChai',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            tooltip:
                widget.isDark ? 'Switch to light mode' : 'Switch to dark mode',
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortrait(changeMap, isTablet)
              : _buildLandscape(changeMap, isTablet);
        },
      ),
    );
  }

  Widget _buildPortrait(Map<int, int> changeMap, bool isTablet) {
    return Column(
      children: [
        AmountDisplay(amount: _amount, isTablet: isTablet),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ChangeTable(
                    changeMap: changeMap,
                    columns: 1,
                    isTablet: isTablet,
                  ),
                ),
                Expanded(
                  child: NumericKeypad(
                    columns: 3,
                    onDigit: _onDigit,
                    onClear: _onClear,
                    isTablet: isTablet,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscape(Map<int, int> changeMap, bool isTablet) {
    return Column(
      children: [
        AmountDisplay(amount: _amount, isTablet: isTablet),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ChangeTable(
                    changeMap: changeMap,
                    columns: 2,
                    isTablet: isTablet,
                  ),
                ),
                Expanded(
                  child: NumericKeypad(
                    columns: 4,
                    onDigit: _onDigit,
                    onClear: _onClear,
                    isTablet: isTablet,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
