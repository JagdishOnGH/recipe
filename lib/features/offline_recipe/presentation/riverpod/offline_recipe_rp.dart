import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/getit_setup.dart';
import '../../../online_recipe/models/recipe_model.dart';
import '../../repository/offline_recipe_repository.dart';

class OfflineRecipeAsyncNotifier extends AsyncNotifier<List<Recipe>> {
  final OfflineRecipeRepository _localRecipeRepo = sl();

  @override
  Future<List<Recipe>> build() async {
    return await _allOfflineRecipes();
  }

  // _allOfflineRecipes();
  Future<List<Recipe>> _allOfflineRecipes() async {
    return await _localRecipeRepo.allRecipes();
  }

  void saveRecipe(Recipe recipe) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _localRecipeRepo.saveRecipe(recipe);
      return await _allOfflineRecipes();
    });
  }

  void removeRecipe(Recipe recipe) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _localRecipeRepo.deleteRecipe(recipe.id);
      return await _allOfflineRecipes();
    });
  }
}

//AsyncNotifierProvider

final offlineRecipeAsyncProvider =
    AsyncNotifierProvider<OfflineRecipeAsyncNotifier, List<Recipe>>(
        () => OfflineRecipeAsyncNotifier());
