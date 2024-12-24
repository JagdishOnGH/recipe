import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/routes/auto_route_setup.dart';
import 'package:recipe_app/themes/button_theme.dart';
import 'package:recipe_app/themes/chip_theme.dart';

import 'di/getit_setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AutoRouteSetup();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        chipTheme: chipThemeData,
        outlinedButtonTheme: outlinedButtonThemeData,
        elevatedButtonTheme: elevatedButtonThemeData,
        filledButtonTheme: filledButtonThemeData,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
