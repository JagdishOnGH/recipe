import '../../online_recipe/models/recipe_model.dart';
import '../data/offline_datasource.dart';

class OfflineRecipeRepository {
  final OfflineDatasource _recipeDatasource;

  const OfflineRecipeRepository(this._recipeDatasource);

  Future<void> saveRecipe(Recipe recipe) async {
    return await _recipeDatasource.saveRecipe(recipe);
  }

  Future<void> deleteRecipe(int id) async {
    return await _recipeDatasource.deleteRecipe(id);
  }

  Future<Recipe?> recipeById(int id) async {
    return await _recipeDatasource.recipeById(id);
  }

  Future<List<Recipe>> allRecipes() async {
    return await _recipeDatasource.allRecipes();
  }

  Future<bool> hasRecipe(int id) async {
    return await _recipeDatasource.hasRecipe(id);
  }
}
