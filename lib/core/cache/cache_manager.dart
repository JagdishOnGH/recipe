import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../features/online_recipe/models/recipe_model.dart';

class CacheManager {
  static const String _recipeListCacheBox = 'recipe_list_cache';
  static const String _recipeDetailCacheBox = 'recipe_detail_cache';
  static const String _searchCacheBox = 'search_cache';
  static const Duration _defaultCacheDuration = Duration(hours: 1);

  static late Box<String> _recipeListCache;
  static late Box<String> _recipeDetailCache;
  static late Box<String> _searchCache;

  static Future<void> init() async {
    await Hive.initFlutter();
    
    _recipeListCache = await Hive.openBox<String>(_recipeListCacheBox);
    _recipeDetailCache = await Hive.openBox<String>(_recipeDetailCacheBox);
    _searchCache = await Hive.openBox<String>(_searchCacheBox);
  }

  // Recipe List Caching
  static Future<void> cacheRecipeList({
    required String key,
    required RecipeList recipeList,
    Duration? duration,
  }) async {
    final cacheData = CacheData(
      data: jsonEncode(recipeList.toJson()),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      expiresIn: (duration ?? _defaultCacheDuration).inMilliseconds,
    );
    
    await _recipeListCache.put(key, jsonEncode(cacheData.toJson()));
  }

  static Future<RecipeList?> getCachedRecipeList(String key) async {
    final cachedString = _recipeListCache.get(key);
    if (cachedString == null) return null;

    try {
      final cacheData = CacheData.fromJson(jsonDecode(cachedString));
      
      if (_isExpired(cacheData)) {
        await _recipeListCache.delete(key);
        return null;
      }

      final recipeListJson = jsonDecode(cacheData.data);
      return RecipeList.fromJson(recipeListJson);
    } catch (e) {
      // If parsing fails, remove the corrupted cache entry
      await _recipeListCache.delete(key);
      return null;
    }
  }

  // Recipe Detail Caching
  static Future<void> cacheRecipe({
    required int recipeId,
    required Recipe recipe,
    Duration? duration,
  }) async {
    final cacheData = CacheData(
      data: jsonEncode(recipe.toJson()),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      expiresIn: (duration ?? _defaultCacheDuration).inMilliseconds,
    );
    
    await _recipeDetailCache.put(
      recipeId.toString(), 
      jsonEncode(cacheData.toJson())
    );
  }

  static Future<Recipe?> getCachedRecipe(int recipeId) async {
    final cachedString = _recipeDetailCache.get(recipeId.toString());
    if (cachedString == null) return null;

    try {
      final cacheData = CacheData.fromJson(jsonDecode(cachedString));
      
      if (_isExpired(cacheData)) {
        await _recipeDetailCache.delete(recipeId.toString());
        return null;
      }

      final recipeJson = jsonDecode(cacheData.data);
      return Recipe.fromJson(recipeJson);
    } catch (e) {
      await _recipeDetailCache.delete(recipeId.toString());
      return null;
    }
  }

  // Search Results Caching
  static Future<void> cacheSearchResults({
    required String query,
    required RecipeList results,
    Duration? duration,
  }) async {
    final cacheData = CacheData(
      data: jsonEncode(results.toJson()),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      expiresIn: (duration ?? Duration(minutes: 30)).inMilliseconds,
    );
    
    await _searchCache.put(
      _generateSearchKey(query), 
      jsonEncode(cacheData.toJson())
    );
  }

  static Future<RecipeList?> getCachedSearchResults(String query) async {
    final cachedString = _searchCache.get(_generateSearchKey(query));
    if (cachedString == null) return null;

    try {
      final cacheData = CacheData.fromJson(jsonDecode(cachedString));
      
      if (_isExpired(cacheData)) {
        await _searchCache.delete(_generateSearchKey(query));
        return null;
      }

      final resultsJson = jsonDecode(cacheData.data);
      return RecipeList.fromJson(resultsJson);
    } catch (e) {
      await _searchCache.delete(_generateSearchKey(query));
      return null;
    }
  }

  // Cache Management
  static Future<void> clearAllCache() async {
    await _recipeListCache.clear();
    await _recipeDetailCache.clear();
    await _searchCache.clear();
  }

  static Future<void> clearExpiredCache() async {
    await _clearExpiredFromBox(_recipeListCache);
    await _clearExpiredFromBox(_recipeDetailCache);
    await _clearExpiredFromBox(_searchCache);
  }

  static Future<CacheStats> getCacheStats() async {
    return CacheStats(
      recipeListCacheSize: _recipeListCache.length,
      recipeDetailCacheSize: _recipeDetailCache.length,
      searchCacheSize: _searchCache.length,
      totalCacheSize: _recipeListCache.length + 
                     _recipeDetailCache.length + 
                     _searchCache.length,
    );
  }

  // Helper methods
  static String _generateSearchKey(String query) {
    return 'search_${query.toLowerCase().replaceAll(' ', '_')}';
  }

  static String generateRecipeListKey({
    int limit = 10,
    int offset = 1,
    String? cuisine,
  }) {
    return 'recipes_${limit}_${offset}_${cuisine ?? 'all'}';
  }

  static bool _isExpired(CacheData cacheData) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return now > (cacheData.timestamp + cacheData.expiresIn);
  }

  static Future<void> _clearExpiredFromBox(Box<String> box) async {
    final keysToDelete = <String>[];
    
    for (final key in box.keys) {
      final cachedString = box.get(key);
      if (cachedString != null) {
        try {
          final cacheData = CacheData.fromJson(jsonDecode(cachedString));
          if (_isExpired(cacheData)) {
            keysToDelete.add(key.toString());
          }
        } catch (e) {
          // If parsing fails, mark for deletion
          keysToDelete.add(key.toString());
        }
      }
    }

    for (final key in keysToDelete) {
      await box.delete(key);
    }
  }
}

class CacheData {
  final String data;
  final int timestamp;
  final int expiresIn;

  CacheData({
    required this.data,
    required this.timestamp,
    required this.expiresIn,
  });

  Map<String, dynamic> toJson() => {
    'data': data,
    'timestamp': timestamp,
    'expiresIn': expiresIn,
  };

  factory CacheData.fromJson(Map<String, dynamic> json) => CacheData(
    data: json['data'],
    timestamp: json['timestamp'],
    expiresIn: json['expiresIn'],
  );
}

class CacheStats {
  final int recipeListCacheSize;
  final int recipeDetailCacheSize;
  final int searchCacheSize;
  final int totalCacheSize;

  CacheStats({
    required this.recipeListCacheSize,
    required this.recipeDetailCacheSize,
    required this.searchCacheSize,
    required this.totalCacheSize,
  });

  @override
  String toString() {
    return 'CacheStats(recipeList: $recipeListCacheSize, '
           'recipeDetail: $recipeDetailCacheSize, '
           'search: $searchCacheSize, '
           'total: $totalCacheSize)';
  }
}