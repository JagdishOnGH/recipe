import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipe_app/constants/urls.dart';
import 'package:recipe_app/features/authentication/data/token_storage.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/authentication/data/auth_datasource.dart';
import '../features/offline_recipe/data/offline_datasource.dart';
import '../features/offline_recipe/repository/offline_recipe_repository.dart';
import '../features/online_recipe/data/recipe_datasource.dart';
import '../features/online_recipe/repository/recipe_repository.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  // getItInit.registerSingletonAsync(() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs;
  // });
//dio
  sl.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
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
  sl.registerLazySingleton<RecipeRepository>(() => RecipeRepository(sl()));
  await sl.isReady<SharedPreferences>();
  sl.registerSingleton<TokenStorage>(SharedPrefTokenStorage(sl()));
  sl.registerSingleton<OfflineDatasource>(SharedPrefOfflineDatasource(sl()));
  sl.registerSingleton<OfflineRecipeRepository>(OfflineRecipeRepository(sl()));

  sl.registerSingleton<AuthDatasource>(
      RestDummyAuthDatasource(sl<Dio>(), sl()));
  sl.registerSingleton<AuthRepository>(AuthRepository(sl()));
}
