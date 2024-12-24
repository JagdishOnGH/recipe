import 'package:recipe_app/features/present_recipe/models/recipe_model.dart';

import '../data/recipe_datasource.dart';

// abstract class RecipeRepository {
//   Future getRecipes({int limit = 10, int offset = 1});
// }

class RestRecipeRepository {
  final RecipeDatasource _recipeDatasource;

  // final TokenStorage _tokenStorage;

  RestRecipeRepository(this._recipeDatasource);

  Future<RecipeList> getRecipes({int limit = 10, int offset = 1}) async {
    return await _recipeDatasource.getRecipes(limit: limit, offset: offset);
  }

  Future<RecipeList> searchRecipes(String query,
      {int limit = 10, int offset = 1}) async {
    return await _recipeDatasource.searchRecipes(query,
        limit: limit, offset: offset);
  }
}
