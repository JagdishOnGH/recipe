import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/helper/placeholder_class.dart';
import 'package:recipe_app/routes/auto_route_setup.gr.dart';

import '../features/authentication/presentation/riverpod/authentication_rp.dart';

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
        AutoRoute(page: EntryPointRoute.page, path: "/entry-point", children: [
          AutoRoute(page: HomeRoute.page, path: "home", children: [
            AutoRoute(page: RecipeDetailRoute.page, path: "recipe-detail"),
            AutoRoute(page: SearchRecipeRoute.page, path: "search-recipe"),
          ]),
          AutoRoute(page: ProfileRoute.page, path: "profile"),
        ]),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}

class AuthRouteGuard extends AutoRouteGuard {
  BuildContext context;
  final WidgetRef ref;

  AuthRouteGuard({required this.ref, required this.context});

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final AsyncValue<DataPlaceHolder<String>> result =
        ref.read(authenticationRpProvider);
    if (result is AsyncData && result.value?.data != null) {
      resolver.next(true);
    } else {
      //check:
      router.push(const LoginReminderRoute());
      resolver.next(false);
    }
  }
}
