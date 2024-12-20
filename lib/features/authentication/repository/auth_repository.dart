import '../data/auth_datasource.dart';
import '../models/register_user_model.dart';

class AuthRepository {
  final AuthDatasource _authDatasource;

  const AuthRepository(this._authDatasource);

  Future<String> login(String username, String password) {
    return _authDatasource.login(username, password);
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
