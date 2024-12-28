import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:recipe_app/features/authentication/repository/token_store_repository.dart';
import 'package:recipe_app/helper/placeholder_class.dart';

import '../../../../di/getit_setup.dart';

class AuthenticationRp extends AsyncNotifier<PlaceHolder<String>> {
  final AuthRepository _authRepository = sl<AuthRepository>();
  final TokenStoreRepository _tokenStoreRepository = sl<TokenStoreRepository>();

  @override
  Future<PlaceHolder<String>> build() async {
    final token = await authToken;
    return PlaceHolder(data: token);
  }

  Future<String?> get authToken => _tokenStoreRepository.getToken();

  void login(String username, String password) async {
    state = AsyncLoading();
    try {
      await _usernamePasswordValidator(username, password);
      final token = await _authRepository.login(username, password);
      await _tokenStoreRepository.saveToken(token);
      state = AsyncData(PlaceHolder(data: token));
    } on DioException catch (e) {
      state = AsyncError(e.response?.data, StackTrace.empty);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.empty);
    }
  }

  void logout() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await _authRepository.logout();
      await _tokenStoreRepository.deleteToken();
      return PlaceHolder();
    });
  }

  Future<void> _usernamePasswordValidator(
      String username, String password) async {
    //username should be 6 characters long alphanumeric only not special characters
    //password should be 8 characters long with at least one special character
    //return true if valid else false
    if (RegExp(r'^[a-zA-Z0-9]{6,15}$').hasMatch(username) &&
        RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,16}$')
            .hasMatch(password)) {
      return;
    }
    throw Exception("Invalid username or password");
  }
}

final authenticationRpProvider =
    AsyncNotifierProvider<AuthenticationRp, PlaceHolder<String>>(
  () => AuthenticationRp(),
);
