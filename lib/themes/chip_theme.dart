import 'package:flutter/material.dart';

ChipThemeData chipThemeData = ChipThemeData(
  color: WidgetStatePropertyAll<Color>(Colors.orange.shade100),
  backgroundColor: Colors.orange.shade100,

  shape: StadiumBorder(side: BorderSide(color: Colors.orange.shade100)),
  // Capsule shape

  brightness: Brightness.light,
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
);
