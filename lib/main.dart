import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/routes/auto_route_setup.dart';
import 'package:recipe_app/themes/button_theme.dart';
import 'package:recipe_app/themes/chip_theme.dart';

import 'di/getit_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  runApp(ProviderScope(
    child: ScreenUtilInit(
        child: MyApp(),
        minTextAdapt: true,
        designSize: const Size(390, 797),
        builder: (context, child) {
          return child!;
        }),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late AutoRouteSetup _appRouter;

  @override
  void initState() {
    _appRouter = AutoRouteSetup(
      context: context,
      ref: ref,
    );

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
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
