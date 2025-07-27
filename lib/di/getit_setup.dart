import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recipe_app/constants/urls.dart';
import 'package:recipe_app/features/authentication/data/token_storage.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enhanced imports for scaling
import '../core/cache/cache_manager.dart';
import '../database/database_helper.dart';
import '../features/authentication/data/auth_datasource.dart';
import '../features/offline_recipe/data/offline_datasource.dart';
import '../features/offline_recipe/data/enhanced_offline_datasource.dart';
import '../features/offline_recipe/repository/offline_recipe_repository.dart';
import '../features/online_recipe/data/recipe_datasource.dart';
import '../features/online_recipe/data/enhanced_recipe_datasource.dart';
import '../features/online_recipe/repository/recipe_repository.dart';
import '../features/online_recipe/repository/enhanced_recipe_repository.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  // Initialize cache system
  await CacheManager.init();

  // Core services
  sl.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  // Database
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // Enhanced Dio with better configuration
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 15),
      sendTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    dio.interceptors.add(PrettyDioLogger(
      enabled: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    return dio;
  });

  // Wait for SharedPreferences to be ready
  await sl.isReady<SharedPreferences>();

  // Data sources - Enhanced versions
  sl.registerLazySingleton<EnhancedRecipeDatasource>(
    () => EnhancedRecipeDatasource(sl<Dio>(), sl<Connectivity>()),
  );

  sl.registerLazySingleton<DatabaseOfflineDatasource>(
    () => DatabaseOfflineDatasource(sl<DatabaseHelper>()),
  );

  // Repositories - Enhanced versions
  sl.registerLazySingleton<EnhancedRecipeRepository>(
    () => EnhancedRecipeRepository(
      sl<EnhancedRecipeDatasource>(),
      sl<DatabaseOfflineDatasource>(),
      sl<Connectivity>(),
    ),
  );

  // Legacy support - keep old implementations for backward compatibility
  sl.registerSingleton<RecipeDatasource>(RestRecipeDatasource(sl<Dio>()));
  sl.registerLazySingleton<RecipeRepository>(() => RecipeRepository(sl()));
  sl.registerSingleton<OfflineDatasource>(SharedPrefOfflineDatasource(sl()));
  sl.registerSingleton<OfflineRecipeRepository>(OfflineRecipeRepository(sl()));

  // Authentication
  sl.registerSingleton<TokenStorage>(SharedPrefTokenStorage(sl()));
  sl.registerSingleton<AuthDatasource>(
      RestDummyAuthDatasource(sl<Dio>(), sl()));
  sl.registerSingleton<AuthRepository>(AuthRepository(sl()));
}
