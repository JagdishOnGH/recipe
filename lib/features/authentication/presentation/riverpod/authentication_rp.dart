import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:recipe_app/helper/placeholder_class.dart';

import '../../../../di/getit_setup.dart';
import '../../../../exceptions/app_global_exception.dart';

class AuthenticationRp extends AsyncNotifier<DataPlaceHolder<String>> {
  final AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Future<DataPlaceHolder<String>> build() async {
    throw Exception("Method not implemented");
    state = AsyncLoading();
    final token = await _authRepository.loginStatus();
    return DataPlaceHolder(data: token);
  }

  void login(String username, String password) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _usernamePasswordValidator(username, password);
      final token = await _authRepository.login(username, password);
      return DataPlaceHolder(data: token);
    });
  }

  void logout() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepository.logout();

      return DataPlaceHolder();
    });
  }

  Future<void> _usernamePasswordValidator(
      String username, String password) async {
    //username should be 6 characters long alphanumeric only not special characters
    //password should be 8 characters long with at least one special character
    //return true if valid else false

    username = username.trim();

    // Check length
    if (username.length < 6 || username.length > 15) {
      throw AppGlobalException("Username must be 6-15 characters long.");
    }

    // Check that the first character is a letter
    if (!RegExp(r'^[a-zA-Z]').hasMatch(username)) {
      throw AppGlobalException("Username must start with a letter.");
    }

    // Check for invalid characters
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
      throw AppGlobalException(
          "Username can only contain letters and optional numbers (no special characters).");
    }
    if (!RegExp(r'^[a-zA-Z0-9]{6,15}$').hasMatch(username.trim())) {
      throw AppGlobalException(
          "Username should be minimum 6 letter  long alphanumeric only not special characters");
    }
    if (password.length < 8 || password.length > 16) {
      throw AppGlobalException("Password must be 8-16 characters long.");
    }
    // if (!RegExp(r'[0-9]').hasMatch(password)) {
    //   throw AppGlobalException("Password must include at least one digit.");
    // }
    // if (!RegExp(r'[a-z]').hasMatch(password)) {
    //   throw AppGlobalException("Password must include at least one lowercase letter.");
    // }
    // if (!RegExp(r'[A-Z]').hasMatch(password)) {
    //   throw AppGlobalException("Password must include at least one uppercase letter.");
    // }
    // if (!RegExp(r'[@#$%^&+=]').hasMatch(password)) {
    //   throw AppGlobalException(
    //       "Password must include at least one special character (@#\$%^&+=).");
    // }

    return;
  }
}

final authenticationRpProvider =
    AsyncNotifierProvider<AuthenticationRp, DataPlaceHolder<String>>(
  () => AuthenticationRp(),
);
