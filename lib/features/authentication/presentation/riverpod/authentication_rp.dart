import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:recipe_app/helper/placeholder_class.dart';

import '../../../../di/getit_setup.dart';

class AuthenticationRp extends AsyncNotifier<PlaceHolder<String>> {
  final AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Future<PlaceHolder<String>> build() async {
    state = AsyncLoading();
    final token = await _authRepository.loginStatus();
    return PlaceHolder(data: token);
  }

  void login(String username, String password) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _usernamePasswordValidator(username, password);
      final token = await _authRepository.login(username, password);

      return PlaceHolder(data: token);
    });
  }

  void logout() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepository.logout();

      return PlaceHolder();
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
      throw Exception("Username must be 6-15 characters long.");
    }

    // Check that the first character is a letter
    if (!RegExp(r'^[a-zA-Z]').hasMatch(username)) {
      throw Exception("Username must start with a letter.");
    }

    // Check for invalid characters
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
      throw Exception(
          "Username can only contain letters and optional numbers (no special characters).");
    }
    if (!RegExp(r'^[a-zA-Z0-9]{6,15}$').hasMatch(username.trim())) {
      throw Exception(
          "Username should be minimum 6 letter  long alphanumeric only not special characters");
    }
    if (password.length < 8 || password.length > 16) {
      throw Exception("Password must be 8-16 characters long.");
    }
    // if (!RegExp(r'[0-9]').hasMatch(password)) {
    //   throw Exception("Password must include at least one digit.");
    // }
    // if (!RegExp(r'[a-z]').hasMatch(password)) {
    //   throw Exception("Password must include at least one lowercase letter.");
    // }
    // if (!RegExp(r'[A-Z]').hasMatch(password)) {
    //   throw Exception("Password must include at least one uppercase letter.");
    // }
    // if (!RegExp(r'[@#$%^&+=]').hasMatch(password)) {
    //   throw Exception(
    //       "Password must include at least one special character (@#\$%^&+=).");
    // }

    return;
  }
}

final authenticationRpProvider =
    AsyncNotifierProvider<AuthenticationRp, PlaceHolder<String>>(
  () => AuthenticationRp(),
);
