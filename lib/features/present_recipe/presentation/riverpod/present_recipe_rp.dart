import 'dart:async';

import 'package:recipe_app/di/getit_setup.dart';
import 'package:recipe_app/features/present_recipe/models/recipe_model.dart';
import 'package:recipe_app/features/present_recipe/repository/recipe_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../helper/placeholder_class.dart';

class PresentRecipeRp extends AsyncNotifier<DataPlaceHolder<RecipeList>> {
  final RestRecipeRepository _recipeRepository = sl<RestRecipeRepository>();

  @override
  FutureOr<DataPlaceHolder<RecipeList>> build() async {
    state = AsyncLoading();
    final result = await _getRecipes();
    return DataPlaceHolder<RecipeList>(data: result);
  }

  Future<RecipeList> _getRecipes({int limit = 10, int offset = 1}) async {
    final result =
        await _recipeRepository.getRecipes(limit: limit, offset: offset);
    return result;
  }
}

final presentRecipeRpProvider =
    AsyncNotifierProvider<PresentRecipeRp, DataPlaceHolder<RecipeList>>(
  () => PresentRecipeRp(),
);
