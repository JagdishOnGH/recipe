import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipe_app/constants/urls.dart';

import '../features/present_recipe/data/recipe_datasource.dart';
import '../features/present_recipe/repository/recipe_repository.dart';

final sl = GetIt.instance;

void setupGetIt() {
  // getItInit.registerSingletonAsync(() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs;
  // });
//dio
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          baseUrl: BASE_URL,
        ),
      )..interceptors.add(PrettyDioLogger(
          enabled: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)));

  sl.registerSingleton<RecipeDatasource>(RestRecipeDatasource(sl<Dio>()));
  sl.registerLazySingleton<RestRecipeRepository>(
      () => RestRecipeRepository(sl()));
}
