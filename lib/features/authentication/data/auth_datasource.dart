import 'package:dio/dio.dart';
import 'package:recipe_app/constants/urls.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/features/authentication/data/token_storage.dart';
import 'package:recipe_app/features/authentication/models/user_model.dart';
import 'package:recipe_app/helper/globalprinter.dart';

import '../models/register_user_model.dart';

abstract class AuthDatasource {
  Future<String?> loginStatus();

  Future<String> login(String username, String password);

  Future<void> logout();

  Future<void> register(RegisterUserModel registerUserModel);

  Future<void> resetPassword(String email);

  Future<UserModel> userProfile();
}

class RestDummyAuthDatasource implements AuthDatasource {
  final Dio _dio;
  final TokenStorage _tokenStorage;

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
  Future<void> logout() async {
    await _tokenStorage.clearToken();
  }

  @override
  Future<void> register(RegisterUserModel registerUserModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<String?> loginStatus() {
    return _tokenStorage.getToken();
  }

  @override
  Future<UserModel> userProfile() async {
    final token = await _tokenStorage.getToken();
    if (token == null) {
      throw AppGlobalException("User not logged in");
    }
    try {
      final response = await _dio.get(USER_PROFILE_URL,
          options: Options(headers: {'Authorization': "Bearer $token"}));
      final userModel = UserModel.fromJson(response.data);
      return userModel;
    } on DioException catch (e) {
      final resp = e.response?.statusMessage ?? "Error getting user profile";
      throw AppGlobalException(resp);
    }
  }
}
