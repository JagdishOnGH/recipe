import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recipe_app/core/cache/cache_manager.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/features/online_recipe/data/enhanced_recipe_datasource.dart';
import 'package:recipe_app/features/offline_recipe/data/enhanced_offline_datasource.dart';

import '../models/recipe_model.dart';

class EnhancedRecipeRepository {
  final EnhancedRecipeDatasource _onlineDatasource;
  final DatabaseOfflineDatasource _offlineDatasource;
  final Connectivity _connectivity;

  const EnhancedRecipeRepository(
    this._onlineDatasource,
    this._offlineDatasource,
    this._connectivity,
  );

  /// Get recipes with caching and offline-first approach
  Future<RecipeList> getRecipes({
    int limit = 10,
    int offset = 1,
    bool forceRefresh = false,
  }) async {
    final cacheKey = CacheManager.generateRecipeListKey(
      limit: limit,
      offset: offset,
    );

    // Check cache first unless force refresh is requested
    if (!forceRefresh) {
      final cachedRecipes = await CacheManager.getCachedRecipeList(cacheKey);
      if (cachedRecipes != null) {
        return cachedRecipes;
      }
    }

    // Check connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // Fetch from network
        final recipeList = await _onlineDatasource.getRecipes(
          limit: limit,
          offset: offset,
        );

        // Cache the result
        await CacheManager.cacheRecipeList(
          key: cacheKey,
          recipeList: recipeList,
        );

        return recipeList;
      } catch (e) {
        // If network fails, try to get from offline storage
        return await _getOfflineRecipes(limit: limit, offset: offset);
      }
    } else {
      // No connectivity - get from offline storage
      return await _getOfflineRecipes(limit: limit, offset: offset);
    }
  }

  /// Search recipes with caching
  Future<RecipeList> searchRecipes(
    String query, {
    int limit = 10,
    int offset = 1,
    bool forceRefresh = false,
  }) async {
    if (query.trim().isEmpty) {
      return RecipeList(recipes: [], total: 0, skip: 0, limit: limit);
    }

    // Check cache first unless force refresh is requested
    if (!forceRefresh) {
      final cachedResults = await CacheManager.getCachedSearchResults(query);
      if (cachedResults != null) {
        return cachedResults;
      }
    }

    // Check connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // Fetch from network
        final searchResults = await _onlineDatasource.searchRecipes(
          query,
          limit: limit,
          offset: offset,
        );

        // Cache the result
        await CacheManager.cacheSearchResults(
          query: query,
          results: searchResults,
        );

        return searchResults;
      } catch (e) {
        // If network fails, search in offline storage
        return await _searchOfflineRecipes(query, limit: limit, offset: offset);
      }
    } else {
      // No connectivity - search in offline storage
      return await _searchOfflineRecipes(query, limit: limit, offset: offset);
    }
  }

  /// Get recipes by cuisine with caching
  Future<RecipeList> getRecipeByCuisine(
    String cuisine, {
    int limit = 10,
    int offset = 1,
    bool forceRefresh = false,
  }) async {
    final cacheKey = CacheManager.generateRecipeListKey(
      limit: limit,
      offset: offset,
      cuisine: cuisine,
    );

    // Check cache first unless force refresh is requested
    if (!forceRefresh) {
      final cachedRecipes = await CacheManager.getCachedRecipeList(cacheKey);
      if (cachedRecipes != null) {
        return cachedRecipes;
      }
    }

    // Check connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // Fetch from network
        final recipeList = await _onlineDatasource.getRecipeByCuisine(
          cuisine,
          limit: limit,
          offset: offset,
        );

        // Cache the result
        await CacheManager.cacheRecipeList(
          key: cacheKey,
          recipeList: recipeList,
        );

        return recipeList;
      } catch (e) {
        // If network fails, get from offline storage by cuisine
        return await _getOfflineRecipesByCuisine(cuisine, limit: limit, offset: offset);
      }
    } else {
      // No connectivity - get from offline storage by cuisine
      return await _getOfflineRecipesByCuisine(cuisine, limit: limit, offset: offset);
    }
  }

  /// Save recipe for offline access
  Future<void> saveRecipeOffline(Recipe recipe) async {
    try {
      await _offlineDatasource.saveRecipe(recipe);
      
      // Also cache the individual recipe
      await CacheManager.cacheRecipe(
        recipeId: recipe.id!,
        recipe: recipe,
        duration: Duration(days: 7), // Longer cache for saved recipes
      );
    } catch (e) {
      throw AppGlobalException('Failed to save recipe offline: $e');
    }
  }

  /// Delete offline recipe
  Future<void> deleteOfflineRecipe(int recipeId) async {
    try {
      await _offlineDatasource.deleteRecipe(recipeId);
    } catch (e) {
      throw AppGlobalException('Failed to delete offline recipe: $e');
    }
  }

  /// Check if recipe is saved offline
  Future<bool> isRecipeSavedOffline(int recipeId) async {
    try {
      return await _offlineDatasource.hasRecipe(recipeId);
    } catch (e) {
      return false;
    }
  }

  /// Get offline recipe count
  Future<int> getOfflineRecipeCount() async {
    try {
      return await _offlineDatasource.getRecipeCount();
    } catch (e) {
      return 0;
    }
  }

  /// Clear all caches and offline data (for debugging/admin purposes)
  Future<void> clearAllData() async {
    await CacheManager.clearAllCache();
    await _offlineDatasource.clearAllRecipes();
  }

  /// Helper methods for offline operations
  Future<RecipeList> _getOfflineRecipes({
    int? limit,
    int? offset,
  }) async {
    try {
      final recipes = await _offlineDatasource.allRecipes(
        limit: limit,
        offset: offset,
      );
      
      return RecipeList(
        recipes: recipes,
        total: recipes.length,
        skip: offset ?? 0,
        limit: limit ?? 10,
      );
    } catch (e) {
      return RecipeList(recipes: [], total: 0, skip: 0, limit: limit ?? 10);
    }
  }

  Future<RecipeList> _searchOfflineRecipes(
    String query, {
    int? limit,
    int? offset,
  }) async {
    try {
      final recipes = await _offlineDatasource.allRecipes(
        searchQuery: query,
        limit: limit,
        offset: offset,
      );
      
      return RecipeList(
        recipes: recipes,
        total: recipes.length,
        skip: offset ?? 0,
        limit: limit ?? 10,
      );
    } catch (e) {
      return RecipeList(recipes: [], total: 0, skip: 0, limit: limit ?? 10);
    }
  }

  Future<RecipeList> _getOfflineRecipesByCuisine(
    String cuisine, {
    int? limit,
    int? offset,
  }) async {
    try {
      final recipes = await _offlineDatasource.allRecipes(
        cuisine: cuisine,
        limit: limit,
        offset: offset,
      );
      
      return RecipeList(
        recipes: recipes,
        total: recipes.length,
        skip: offset ?? 0,
        limit: limit ?? 10,
      );
    } catch (e) {
      return RecipeList(recipes: [], total: 0, skip: 0, limit: limit ?? 10);
    }
  }
}