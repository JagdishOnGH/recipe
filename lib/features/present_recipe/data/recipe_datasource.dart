import 'package:dio/dio.dart';

import '../../../constants/urls.dart';
import '../models/recipe_model.dart';

abstract class RecipeDatasource {
  Future getRecipes({int limit = 10, int offset = 1});
}

class RestRecipeDatasource implements RecipeDatasource {
  final Dio _dio;

  const RestRecipeDatasource(this._dio);

  @override
  Future getRecipes({int limit = 10, int offset = 1}) async {
    final RECIPE_URL = '$BASE_URL/recipes?limit=$limit&skip=$offset';
    final request = await _dio.get(RECIPE_URL);
    final RecipeList convertedResponse = RecipeList.fromJson(request.data);

    return convertedResponse.recipes;
  }
}
