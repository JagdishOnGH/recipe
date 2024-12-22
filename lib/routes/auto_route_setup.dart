import 'package:auto_route/auto_route.dart';
import 'package:recipe_app/routes/auto_route_setup.gr.dart';

@AutoRouterConfig()
class AutoRouteSetup extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: "/login"),
        AutoRoute(
            page: OnboardingRoute.page, path: "/onboarding", initial: true),
        AutoRoute(page: HomeRoute.page, path: "/home")
      ];
}
