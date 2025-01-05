import 'package:recipe_app/features/authentication/models/user_model.dart';

import '../data/auth_datasource.dart';
import '../models/register_user_model.dart';

class AuthRepository {
  final AuthDatasource _authDatasource;

  const AuthRepository(
    this._authDatasource,
  );

  Future<UserModel> userProfile() {
    return _authDatasource.userProfile();
  }

  Future<String> login(String username, String password) {
    return _authDatasource.login(username, password);
  }

  Future<String?> loginStatus() async {
    return await Future.microtask(
        () async => await _authDatasource.loginStatus());
  }

  //
  Future<void> logout() {
    return _authDatasource.logout();
  }

  //
  Future<void> register(RegisterUserModel registerUserModel) {
    return _authDatasource.register(registerUserModel);
  }

  //
  Future<void> resetPassword(String email) {
    return _authDatasource.resetPassword(email);
  }
}
