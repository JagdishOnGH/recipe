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
