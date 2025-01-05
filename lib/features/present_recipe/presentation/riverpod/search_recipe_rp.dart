import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/getit_setup.dart';
import '../../../../helper/placeholder_class.dart';
import '../../models/recipe_model.dart';
import '../../repository/recipe_repository.dart';

class SearchRecipeRp extends AsyncNotifier<DataPlaceHolder<RecipeList>> {
  final recipeRepository = sl<RecipeRepository>();

  @override
  FutureOr<DataPlaceHolder<RecipeList>> build() async {
    return DataPlaceHolder();
  }

  void searchRecipes(String query, {int limit = 10, int offset = 1}) async {
    try {
      state = AsyncLoading();
      final result = await recipeRepository.searchRecipes(query,
          limit: limit, offset: offset);
      final dataUnderPlaceHolder = DataPlaceHolder(data: result);
      state = AsyncData((dataUnderPlaceHolder));
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
    // return result;
  }
}

//auto dispose provider
final searchRecipeRpProvider =
    AsyncNotifierProvider<SearchRecipeRp, DataPlaceHolder<RecipeList>>(
  () => SearchRecipeRp(),
);
