import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipe_app/constants/urls.dart';

final getItInit = GetIt.instance;

void setupGetIt() {
//dio
  getItInit.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          baseUrl: BASE_URL,
        ),
      )..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)));
}
