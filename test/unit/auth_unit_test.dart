import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/di/getit_setup.dart';
import 'package:recipe_app/features/authentication/data/auth_datasource.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();

  group("Auth-Module", () {
    setupGetIt();
    final dio = sl<Dio>();
    late AuthRepository authRepository;
    late AuthDatasource authDatasource;
    setUp(() {
      authDatasource = RestDummyAuthDatasource(dio, sl());
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
