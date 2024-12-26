import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/routes/auto_route_setup.gr.dart';

@AutoRouterConfig()
class AutoRouteSetup extends RootStackRouter {
  final WidgetRef ref;
  final BuildContext context;

  AutoRouteSetup({required this.ref, required this.context});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: "/login"),
        AutoRoute(
            page: OnboardingRoute.page, path: "/onboarding", initial: true),
        AutoRoute(
          page: HomeRoute.page,
          path: "/home",
        ),
        AutoRoute(page: RecipeDetailRoute.page, path: "/recipe-detail"),
        AutoRoute(page: SearchRecipeRoute.page, path: "/search-recipe"),
        AutoRoute(page: LoginReminderRoute.page, path: "/login-reminder"),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}

class AuthRouteGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthRouteGuard({required this.ref});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    resolver.next(true);
  }
}
