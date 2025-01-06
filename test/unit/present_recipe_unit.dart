import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/di/getit_setup.dart';
import 'package:recipe_app/features/present_recipe/data/offline_datasource.dart';
import 'package:recipe_app/features/present_recipe/data/recipe_datasource.dart';
import 'package:recipe_app/features/present_recipe/models/recipe_model.dart';
import 'package:recipe_app/features/present_recipe/repository/offline_recipe_repository.dart';
import 'package:recipe_app/features/present_recipe/repository/recipe_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await setupGetIt();

  group("Present Recipi", () {
    final dio = sl<Dio>();
    late RecipeRepository recipeRepository;
    late RecipeDatasource recipeDatasource;
    setUp(() {
      recipeDatasource = RestRecipeDatasource(dio);
      recipeRepository = RecipeRepository(recipeDatasource);
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
  group("offline-recipe", () {
    late OfflineRecipeRepository recipeRepository;
    late OfflineDatasource offlineDatasource;

    setUp(() {
      offlineDatasource = SharedPrefOfflineDatasource(sl<SharedPreferences>());
      recipeRepository = OfflineRecipeRepository(offlineDatasource);
    });
    //test has recipe
    test("Has Recipe", () async {
      final res = await recipeRepository.hasRecipe(1);
      expect(
        res.runtimeType,
        equals(bool),
      );
    });
  });
}
