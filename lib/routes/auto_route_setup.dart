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
        AutoRoute(page: SearchRecipeRoute.page, path: "/search-recipe"),
        AutoRoute(page: ForYouFullRoute.page, path: "/for-you"),
        AutoRoute(page: RecipeDetailRoute.page, path: "/recipe-detail"),
        AutoRoute(page: EntryPointRoute.page, path: "/entry-point", children: [
          AutoRoute(page: HomeRoute.page, path: "home", children: [
            AutoRoute(page: RecipeDetailRoute.page, path: "recipe-detail"),
          ]),
          AutoRoute(page: RecipeShimmerRoute.page, path: "recipe-shimmer"),
          AutoRoute(page: OfflineShowRoute.page, path: "offline-show"),
          AutoRoute(page: ProfileRoute.page, path: "profile"),
        ]),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
