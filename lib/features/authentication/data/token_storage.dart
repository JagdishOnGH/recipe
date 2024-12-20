import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenStorage {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> clearToken();
}

class SharedPrefTokenStorage implements TokenStorage {
  final SharedPreferences _prefs;

  const SharedPrefTokenStorage(this._prefs);

  static const String _authTokenKey = 'user_auth_token';

  get prefs => _prefs;

  // Save token
  Future<void> saveToken(String token) async {
    await prefs.setString(_authTokenKey, token);
  }

  // Get token
  Future<String?> getToken() async {
    return prefs.getString(_authTokenKey);
  }

  // Remove token
  Future<void> clearToken() async {
    await prefs.remove(_authTokenKey);
  }
}
