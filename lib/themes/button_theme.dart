import 'package:flutter/material.dart';

FilledButtonThemeData filledButtonThemeData = FilledButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Makes the corners rectangular
      ),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Makes the corners rectangular
      ),
    ),
  ),
);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Makes the corners rectangular
      ),
    ),
  ),
);
