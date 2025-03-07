import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:recipe_app/helper/placeholder_class.dart';

import '../../../../di/getit_setup.dart';

typedef PlaceHolderStringType = DataPlaceHolder<String>;

class AuthenticationNotifier extends AsyncNotifier<PlaceHolderStringType> {
  AuthRepository _authRepository = sl<AuthRepository>();

  @override
  FutureOr<PlaceHolderStringType> build() {
    return future;
  }

  void localLogin() async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final String? localJwt = await _authRepository.loginStatus();
      return DataPlaceHolder(data: localJwt);
    });
  }

  void loginWithUserNamePassword(
      {required String userName, required String password}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final String jwt = await _authRepository.login(userName, password);
      return DataPlaceHolder(data: jwt);
    });
  }

  void logout() => state = AsyncData(DataPlaceHolder());
}

final authenticationProvider =
    AsyncNotifierProvider<AuthenticationNotifier, PlaceHolderStringType>(() {
  return AuthenticationNotifier();
});
