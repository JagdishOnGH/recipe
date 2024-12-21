import '../data/recipe_datasource.dart';

// abstract class RecipeRepository {
//   Future getRecipes({int limit = 10, int offset = 1});
// }

class RestRecipeRepository {
  final RecipeDatasource _recipeDatasource;

  // final TokenStorage _tokenStorage;

  RestRecipeRepository(this._recipeDatasource);

  Future getRecipes({int limit = 10, int offset = 1}) async {
    return _recipeDatasource.getRecipes(limit: limit, offset: offset);
  }
}
