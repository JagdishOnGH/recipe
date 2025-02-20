import 'dart:async';

import 'package:recipe_app/di/getit_setup.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../helper/placeholder_class.dart';
import '../../models/recipe_model.dart';
import '../../repository/recipe_repository.dart';

class OnlineRecipeAsyncNotifier
    extends AsyncNotifier<DataPlaceHolder<RecipeList>> {
  final RecipeRepository _recipeRepository = sl<RecipeRepository>();

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

final onlineRecipeAsyncProvider = AsyncNotifierProvider<
    OnlineRecipeAsyncNotifier, DataPlaceHolder<RecipeList>>(
  () => OnlineRecipeAsyncNotifier(),
);
