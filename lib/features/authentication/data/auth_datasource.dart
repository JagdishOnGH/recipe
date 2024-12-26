import 'package:dio/dio.dart';
import 'package:recipe_app/constants/urls.dart';

import '../models/register_user_model.dart';

abstract class AuthDatasource {
  Future<String> login(String username, String password);

  Future<void> logout();

  Future<void> register(RegisterUserModel registerUserModel);

  Future<void> resetPassword(String email);
}

class RestAuthDatasource implements AuthDatasource {
  final Dio _dio;

  const RestAuthDatasource(this._dio);

  @override
  Future<String> login(String username, String password) async {
    final payload = {
      'username': username,
      'password': password,
    };
    final request = await _dio.post(LOGIN_URL, data: payload);
    final token = request.data?['accessToken'] ?? "Dummy token";
    //TODO save token.
    return token;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> register(RegisterUserModel registerUserModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    throw UnimplementedError();
  }
}
