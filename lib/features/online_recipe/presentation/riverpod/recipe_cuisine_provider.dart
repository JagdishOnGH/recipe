import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/features/online_recipe/models/recipe_model.dart';

import '../../../../di/getit_setup.dart';
import '../../repository/recipe_repository.dart';

final recipeCuisineProvider =
    FutureProvider.autoDispose.family<RecipeList, String>((ref, cuisine) async {
  final recipeRepo = sl<RecipeRepository>();
  final recipeList = await recipeRepo.getRecipeByCuisine(cuisine);
  return recipeList;
});
