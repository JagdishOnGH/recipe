import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/di/getit_setup.dart';
import 'package:recipe_app/features/present_recipe/data/recipe_datasource.dart';
import 'package:recipe_app/features/present_recipe/models/recipe_model.dart';
import 'package:recipe_app/features/present_recipe/repository/recipe_repository.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();

  group("Present Recipi", () {
    setupGetIt();
    final dio = getItInit<Dio>();
    late RestRecipeRepository recipeRepository;
    late RecipeDatasource recipeDatasource;
    setUp(() {
      recipeDatasource = RestRecipeDatasource(dio);
      recipeRepository = RestRecipeRepository(recipeDatasource);
    });
    test("Get Recipes", () async {
      final res = await recipeRepository.getRecipes();
      expect(
        res.runtimeType,
        equals(List<Recipe>),
      );
    });
    test("Get Recipes - 10", () async {
      final res = await recipeRepository.getRecipes(limit: 20);
      final count = (res as List<Recipe>).length;
      expect(
        count,
        equals(20),
      );
    });
  });
}
