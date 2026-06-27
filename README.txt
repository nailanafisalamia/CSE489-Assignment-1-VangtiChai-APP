VangtiChai - Taka Change Calculator
CSE 489 Assignment L1

Framework: Flutter (Dart)
Minimum SDK: Android API 21 (Android 5.0 Lollipop)

Description:
  Enter a Taka amount via a custom numeric keypad.
  The app calculates change using denominations: 500, 100, 50, 20, 10, 5, 2, 1.

Tested devices/screen sizes:
  - Pixel XL (411x731dp)   Portrait     checkmark
  - Pixel XL (411x731dp)   Landscape    checkmark
  - Nexus 10 (800x1280dp)  Portrait     checkmark
  - Nexus 10 (800x1280dp)  Landscape    checkmark

Layout notes:
  Portrait:  Change table (1 column) on left, 3-column keypad on right.
  Landscape: Change table (2 columns) on left, 4-column keypad on right.

State preservation:
  Flutter StatefulWidget (_HomePageState holds _amount) survives orientation
  changes automatically because the widget stays in the tree under OrientationBuilder.

No hardcoding:
  All sizes, padding, and margins are defined in lib/utils/app_dimensions.dart.

Known limitations: None.
