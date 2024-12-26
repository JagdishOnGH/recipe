import 'dart:async';

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
    state = await AsyncValue.guard(() async {
      final token = await _authRepository.login(username, password);
      await _tokenStoreRepository.saveToken(token);
      return PlaceHolder();
    });
  }
}
