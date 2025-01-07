import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:recipe_app/features/present_recipe/models/recipe_model.dart';
import 'package:recipe_app/features/present_recipe/repository/offline_recipe_repository.dart';

import '../../../../di/getit_setup.dart';

AutoDisposeFutureProvider<List<Recipe>> offlineRecipeProvider =
    FutureProvider.autoDispose((ref) async {
  final OfflineRecipeRepository recipeRepo = sl();
  final List<Recipe> recipes = await recipeRepo.allRecipes();
  return recipes;
});

final recipeIsSavedProvider =
    AutoDisposeFutureProviderFamily<bool, int>((ref, id) async {
  final OfflineRecipeRepository recipeRepo = sl();
  return await recipeRepo.hasRecipe(id);
});

final internetConnectionProvider = StreamProvider((ref) {
  return InternetConnection().onStatusChange;
});
