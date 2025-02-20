import 'dart:convert';

import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../online_recipe/models/recipe_model.dart';

abstract class OfflineDatasource {
  Future<void> saveRecipe(Recipe recipe);

  Future<void> deleteRecipe(int id);

  Future<Recipe?> recipeById(int id);

  Future<List<Recipe>> allRecipes();

  Future<bool> hasRecipe(int id);
}

class SharedPrefOfflineDatasource implements OfflineDatasource {
  final SharedPreferences _preferences;

  const SharedPrefOfflineDatasource(this._preferences);

  static const String recipeKey = "local-recipe-key";

  @override
  Future<List<Recipe>> allRecipes() async {
    try {
      final recipes = await _preferences.getStringList(recipeKey) ?? [];
      final jsonRecipes =
          recipes.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      final recipeList = jsonRecipes.map((e) => Recipe.fromJson(e)).toList();
      return recipeList;
    } on Exception catch (e) {
      throw AppGlobalException("Failed to get all recipes: $e");
    }
  }

  @override
  Future<void> deleteRecipe(int id) async {
    final recipes = await _preferences.getStringList(recipeKey) ?? [];
    final jsonRecipes =
        recipes.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    final newRecipes = jsonRecipes.where((element) => element['id'] != id);
    final newRecipesString = newRecipes.map((e) => jsonEncode(e)).toList();
    final result =
        await _preferences.setStringList(recipeKey, newRecipesString);
    if (!result) {
      throw AppGlobalException("Failed to delete recipe");
    }
  }

  @override
  Future<Recipe?> recipeById(int id) async {
    try {
      final recipes = await _preferences.getStringList(recipeKey) ?? [];
      final jsonRecipe =
          recipes.map((e) => jsonDecode(e) as Map<String, dynamic>?).toList();
      final recipe = jsonRecipe.firstWhere(
        (element) => element?['id'] == id,
        orElse: () => null,
      );
      if (recipe == null) return null;
      return Recipe.fromJson(recipe);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to get recipe by id: $e");
    }
  }

  Future<bool> hasRecipe(int id) async {
    try {
      final recipes = await _preferences.getStringList(recipeKey) ?? [];
      print("recipes: $recipes");
      final jsonRecipes =
          recipes.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      return jsonRecipes.any((element) => element['id'] == id);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to check if recipe exists: $e");
    }
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    try {
      final jsonRecipe = recipe.toJson();
      final recipes = await _preferences.getStringList(recipeKey) ?? [];
      recipes.add(jsonEncode(jsonRecipe));
      //remove duplicates ON ID
      final uniqueRecipes = recipes.toSet().toList();
      await _preferences.setStringList(recipeKey, uniqueRecipes);
    } on Exception catch (e) {
      throw AppGlobalException("Failed to save recipe: $e");
    }
  }
}
