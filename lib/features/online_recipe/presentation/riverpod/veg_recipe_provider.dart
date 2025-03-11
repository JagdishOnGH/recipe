import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/getit_setup.dart';
import '../../models/recipe_model.dart';
import '../../repository/recipe_repository.dart';

AutoDisposeFutureProvider<RecipeList> vegRecipeProvider =
    FutureProvider.autoDispose((ref) async {
  final recipeRepository = sl<RecipeRepository>();

  return await recipeRepository.vegRecipes('salad');
});
