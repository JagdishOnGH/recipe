import 'package:dio/dio.dart';
import 'package:recipe_app/constants/urls.dart';
import 'package:recipe_app/features/authentication/data/token_storage.dart';

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
    final token = request.data?["accessToken"];

    final TokenStorage tokenStorage = TokenStorage();
    await tokenStorage.saveToken(token);
    return token;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(RegisterUserModel registerUserModel) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
