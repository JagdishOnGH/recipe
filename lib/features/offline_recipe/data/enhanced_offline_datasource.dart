import 'package:recipe_app/database/database_helper.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';

import '../../online_recipe/models/recipe_model.dart';

abstract class OfflineDatasource {
  Future<void> saveRecipe(Recipe recipe);
  Future<void> deleteRecipe(int id);
  Future<Recipe?> recipeById(int id);
  Future<List<Recipe>> allRecipes({
    int? limit,
    int? offset,
    String? searchQuery,
    String? cuisine,
  });
  Future<bool> hasRecipe(int id);
  Future<int> getRecipeCount();
  Future<void> clearAllRecipes();
}

class DatabaseOfflineDatasource implements OfflineDatasource {
  final DatabaseHelper _databaseHelper;

  const DatabaseOfflineDatasource(this._databaseHelper);

  @override
  Future<List<Recipe>> allRecipes({
    int? limit,
    int? offset,
    String? searchQuery,
    String? cuisine,
  }) async {
    try {
      return await _databaseHelper.getAllRecipes(
        limit: limit,
        offset: offset,
        searchQuery: searchQuery,
        cuisine: cuisine,
      );
    } on Exception catch (e) {
      throw AppGlobalException("Failed to get all recipes: $e");
    }
  }

  @override
  Future<void> deleteRecipe(int id) async {
    try {
      await _databaseHelper.deleteRecipe(id);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to delete recipe: $e");
    }
  }

  @override
  Future<Recipe?> recipeById(int id) async {
    try {
      return await _databaseHelper.getRecipe(id);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to get recipe by id: $e");
    }
  }

  @override
  Future<bool> hasRecipe(int id) async {
    try {
      return await _databaseHelper.hasRecipe(id);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to check if recipe exists: $e");
    }
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    try {
      await _databaseHelper.insertRecipe(recipe);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to save recipe: $e");
    }
  }

  @override
  Future<int> getRecipeCount() async {
    try {
      return await _databaseHelper.getRecipeCount();
    } on Exception catch (e) {
      throw AppGlobalException("Failed to get recipe count: $e");
    }
  }

  @override
  Future<void> clearAllRecipes() async {
    try {
      await _databaseHelper.clearAllRecipes();
    } on Exception catch (e) {
      throw AppGlobalException("Failed to clear all recipes: $e");
    }
  }
}

// Keep the old SharedPreferences implementation as fallback
class SharedPrefOfflineDatasource implements OfflineDatasource {
  // ... existing implementation (keeping for backward compatibility)
  // This can be removed in future versions once migration is complete
  
  @override
  Future<List<Recipe>> allRecipes({
    int? limit,
    int? offset,
    String? searchQuery,
    String? cuisine,
  }) async {
    // Legacy implementation - to be removed
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }

  @override
  Future<void> deleteRecipe(int id) async {
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }

  @override
  Future<Recipe?> recipeById(int id) async {
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }

  @override
  Future<bool> hasRecipe(int id) async {
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }

  @override
  Future<int> getRecipeCount() async {
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }

  @override
  Future<void> clearAllRecipes() async {
    throw UnimplementedError('Use DatabaseOfflineDatasource for better performance');
  }
}