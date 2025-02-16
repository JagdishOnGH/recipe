// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:recipe_app/features/authentication/presentation/pages/login_page.dart'
    as _i4;
import 'package:recipe_app/features/authentication/presentation/pages/profile_page.dart'
    as _i8;
import 'package:recipe_app/features/entry_homepage/presentation/entry_point_page.dart'
    as _i1;
import 'package:recipe_app/features/onboarding/presentation/pages/login_reminder_page.dart'
    as _i5;
import 'package:recipe_app/features/onboarding/presentation/pages/onboarding_page.dart'
    as _i7;
import 'package:recipe_app/features/present_recipe/models/recipe_model.dart'
    as _i14;
import 'package:recipe_app/features/present_recipe/presentation/pages/home_page.dart'
    as _i3;
import 'package:recipe_app/features/present_recipe/presentation/pages/home_page_2.dart'
    as _i2;
import 'package:recipe_app/features/present_recipe/presentation/pages/home_page_shimmer.dart'
    as _i10;
import 'package:recipe_app/features/present_recipe/presentation/pages/offline_show_page.dart'
    as _i6;
import 'package:recipe_app/features/present_recipe/presentation/pages/recipe_detail_page.dart'
    as _i9;
import 'package:recipe_app/features/present_recipe/presentation/pages/search_recipe_page.dart'
    as _i11;

/// generated route for
/// [_i1.EntryPointPage]
class EntryPointRoute extends _i12.PageRouteInfo<void> {
  const EntryPointRoute({List<_i12.PageRouteInfo>? children})
      : super(
          EntryPointRoute.name,
          initialChildren: children,
        );

  static const String name = 'EntryPointRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.EntryPointPage();
    },
  );
}

/// generated route for
/// [_i2.HomeNPage2]
class HomeNRoute2 extends _i12.PageRouteInfo<void> {
  const HomeNRoute2({List<_i12.PageRouteInfo>? children})
      : super(
          HomeNRoute2.name,
          initialChildren: children,
        );

  static const String name = 'HomeNRoute2';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeNPage2();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.LoginReminderPage]
class LoginReminderRoute extends _i12.PageRouteInfo<void> {
  const LoginReminderRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginReminderRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginReminderRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginReminderPage();
    },
  );
}

/// generated route for
/// [_i6.OfflineShowPage]
class OfflineShowRoute extends _i12.PageRouteInfo<void> {
  const OfflineShowRoute({List<_i12.PageRouteInfo>? children})
      : super(
          OfflineShowRoute.name,
          initialChildren: children,
        );

  static const String name = 'OfflineShowRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.OfflineShowPage();
    },
  );
}

/// generated route for
/// [_i7.OnboardingPage]
class OnboardingRoute extends _i12.PageRouteInfo<void> {
  const OnboardingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i7.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i8.ProfilePage]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i8.ProfilePage();
    },
  );
}

/// generated route for
/// [_i9.RecipeDetailPage]
class RecipeDetailRoute extends _i12.PageRouteInfo<RecipeDetailRouteArgs> {
  RecipeDetailRoute({
    _i13.Key? key,
    required _i14.Recipe recipe,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          RecipeDetailRoute.name,
          args: RecipeDetailRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeDetailRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecipeDetailRouteArgs>();
      return _i9.RecipeDetailPage(
        key: args.key,
        recipe: args.recipe,
      );
    },
  );
}

class RecipeDetailRouteArgs {
  const RecipeDetailRouteArgs({
    this.key,
    required this.recipe,
  });

  final _i13.Key? key;

  final _i14.Recipe recipe;

  @override
  String toString() {
    return 'RecipeDetailRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [_i10.RecipeShimmerPage]
class RecipeShimmerRoute extends _i12.PageRouteInfo<void> {
  const RecipeShimmerRoute({List<_i12.PageRouteInfo>? children})
      : super(
          RecipeShimmerRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecipeShimmerRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i10.RecipeShimmerPage();
    },
  );
}

/// generated route for
/// [_i11.SearchRecipePage]
class SearchRecipeRoute extends _i12.PageRouteInfo<void> {
  const SearchRecipeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SearchRecipeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRecipeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i11.SearchRecipePage();
    },
  );
}
