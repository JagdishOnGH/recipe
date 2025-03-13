import 'package:dio/dio.dart';
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
