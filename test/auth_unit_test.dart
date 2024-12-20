import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/di/getit_setup.dart';
import 'package:recipe_app/features/authentication/data/auth_datasource.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  group("Auth-Module", () {
    final dio = getItInit<Dio>();

    late AuthRepository authRepository;
    late AuthDatasource authDatasource;
    setUp(() {
      authDatasource = RestAuthDatasource(dio);
      authRepository = AuthRepository(authDatasource);
    });
    test("Invalid-Creds-Login-400BAD Req", () async {
      expect(
          () async => await authRepository.login("invalid", "invalid"),
          throwsA(isA<DioException>().having(
            (e) => e.response?.statusCode,
            "Invalid-Message",
            equals(400),
          )));
    });
    test("ValidCred-200OK", () async {
      final res = await authRepository.login("emilys", "emilyspass");
      expect(
        res.runtimeType,
        equals(String),
      );
    });
  });
}
