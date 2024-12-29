import 'package:dio/dio.dart';
import 'package:recipe_app/constants/urls.dart';

import '../models/register_user_model.dart';

abstract class AuthDatasource {
  Future<String> login(String username, String password);

  Future<void> logout();

  Future<void> register(RegisterUserModel registerUserModel);

  Future<void> resetPassword(String email);
}

class RestDummyAuthDatasource implements AuthDatasource {
  final Dio _dio;

  RestDummyAuthDatasource(this._dio, this._tokenStorage);

  @override
  Future<String> login(String username, String password) async {
    try {
      final payload = {
        'username': username,
        'password': password,
      };

      final request = await _dio.post(LOGIN_URL, data: payload);
      final token = request.data?['accessToken'] ?? "Dummy token";
      await _tokenStorage.saveToken(token);

      return token;
    } on DioException catch (e) {
      final String? errorMessage = e.response?.data['message'];
      throw AppGlobalException(errorMessage ?? "Error logging in");
    } on AppGlobalException catch (e) {
      printer(e.toString());
      rethrow;
    } on Exception catch (e) {
      printer(e.toString());
      throw AppGlobalException(e.toString());
    }
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
