import 'package:flutter/material.dart';

ChipThemeData chipThemeData = ChipThemeData(
  color: WidgetStatePropertyAll<Color>(Colors.orange),
  backgroundColor: Colors.orange.shade100,

  shape: StadiumBorder(),
  // Capsule shape

  brightness: Brightness.light,
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
);
