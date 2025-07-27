import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/extensions/dio_exception_message.dart';

import '../../../constants/urls.dart';
import '../models/recipe_model.dart';

abstract class RecipeDatasource {
  Future<RecipeList> getRecipes({int limit = 10, int offset = 1});
  Future<RecipeList> searchRecipes(
    String query, {
    int limit = 10,
    int offset = 1,
  });
  Future<RecipeList> getRecipeByCuisine(
    String cuisine, {
    int limit = 10,
    int offset = 1,
  });
}

class EnhancedRecipeDatasource implements RecipeDatasource {
  final Dio _dio;
  final Connectivity _connectivity;
  static const int _maxRetries = 3;
  static const Duration _baseDelay = Duration(seconds: 1);

  const EnhancedRecipeDatasource(this._dio, this._connectivity);

  @override
  Future<RecipeList> getRecipes({int limit = 10, int offset = 1}) async {
    return await _executeWithRetry(() async {
      final recipeUrl = '$BASE_URL/recipes?limit=$limit&skip=$offset';
      final request = await _dio.get(recipeUrl);
      return RecipeList.fromJson(request.data);
    });
  }

  @override
  Future<RecipeList> searchRecipes(String query,
      {int limit = 10, int offset = 1}) async {
    return await _executeWithRetry(() async {
      final searchUrl = '$BASE_URL/recipes?search=$query&limit=$limit&skip=$offset';
      final request = await _dio.get(searchUrl);
      return RecipeList.fromJson(request.data);
    });
  }

  @override
  Future<RecipeList> getRecipeByCuisine(String cuisine,
      {int limit = 10, int offset = 1}) async {
    return await _executeWithRetry(() async {
      final cuisineUrl = '$BASE_URL/recipes/tag/$cuisine?limit=$limit&skip=$offset';
      final request = await _dio.get(cuisineUrl);
      return RecipeList.fromJson(request.data);
    });
  }

  Future<T> _executeWithRetry<T>(Future<T> Function() operation) async {
    // Check connectivity first
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw AppGlobalException('No internet connection available');
    }

    int retryCount = 0;
    
    while (retryCount < _maxRetries) {
      try {
        return await operation();
      } on DioException catch (e) {
        retryCount++;
        
        // Don't retry on client errors (4xx) except for timeout/connection issues
        if (_shouldRetry(e) && retryCount < _maxRetries) {
          final delay = _calculateDelay(retryCount);
          await Future.delayed(delay);
          continue;
        }
        
        final ex = handleDioException(e);
        throw AppGlobalException(ex);
      } catch (e) {
        // For non-Dio exceptions, don't retry
        throw AppGlobalException('Unexpected error: $e');
      }
    }
    
    throw AppGlobalException('Operation failed after $_maxRetries retries');
  }

  bool _shouldRetry(DioException error) {
    // Retry on network errors, timeouts, and server errors (5xx)
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // Retry on server errors (5xx) but not client errors (4xx)
        final statusCode = error.response?.statusCode;
        return statusCode != null && statusCode >= 500;
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      default:
        return false;
    }
  }

  Duration _calculateDelay(int retryCount) {
    // Exponential backoff with jitter
    final delay = _baseDelay * (1 << (retryCount - 1)); // 2^(retryCount-1)
    final jitter = Duration(milliseconds: (delay.inMilliseconds * 0.1).round());
    return delay + jitter;
  }
}

// Keep the original implementation for backward compatibility
class RestRecipeDatasource implements RecipeDatasource {
  final Dio _dio;

  const RestRecipeDatasource(this._dio);

  @override
  Future<RecipeList> getRecipes({int limit = 10, int offset = 1}) async {
    try {
      final RECIPE_URL = '$BASE_URL/recipes?limit=$limit&skip=$offset';
      final request = await _dio.get(RECIPE_URL);
      final RecipeList convertedResponse = RecipeList.fromJson(request.data);

      return convertedResponse;
    } on DioException catch (e) {
      final ex = handleDioException(e);
      throw AppGlobalException(ex);
    }
  }

  Future<RecipeList> searchRecipes(String query,
      {int limit = 10, int offset = 1}) async {
    try {
      final SEARCH_URL = '$BASE_URL/recipes?search=$query';
      final request = await _dio.get(SEARCH_URL);
      final RecipeList convertedResponse = RecipeList.fromJson(request.data);

      return convertedResponse;
    } on DioException catch (e) {
      final ex = handleDioException(e);
      throw AppGlobalException(ex);
    }
  }

  Future<RecipeList> getRecipeByCuisine(String cuisine,
      {int limit = 10, int offset = 1}) async {
    try {
      final CUISINE_URL = '$BASE_URL/recipes/tag/$cuisine';
      final request = await _dio.get(CUISINE_URL);
      final RecipeList convertedResponse = RecipeList.fromJson(request.data);

      return convertedResponse;
    } on DioException catch (e) {
      final ex = handleDioException(e);
      throw AppGlobalException(ex);
    }
  }
}