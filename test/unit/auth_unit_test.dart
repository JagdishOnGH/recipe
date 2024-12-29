import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/di/getit_setup.dart';
import 'package:recipe_app/exceptions/AppGlobalException.dart';
import 'package:recipe_app/features/authentication/data/auth_datasource.dart';
import 'package:recipe_app/features/authentication/data/token_storage.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.setMockInitialValues({});
  await setupGetIt();
  final pref = await SharedPreferences.getInstance();
  group("Auth-Module", () {
    final dio = sl<Dio>();
    late AuthRepository authRepository;
    late AuthDatasource authDatasource;
    late TokenStorage tokenStorage;
    setUp(() {
      authDatasource = RestDummyAuthDatasource(dio, sl());
      authRepository = AuthRepository(authDatasource);
    });
    test("Invalid-Creds-Login-400BAD Req", () async {
      expect(() async => await authRepository.login("invalid", "invalid"),
          throwsA(isA<AppGlobalException>()));
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
