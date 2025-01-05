import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
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
    try {
      await prefs.setString(_authTokenKey, token);
    } on Exception catch (e) {
      throw AppGlobalException("Error saving token. ${e.toString()}");
    }
  }

  // Get token
  Future<String?> getToken() async {
    try {
      final token = await prefs.getString(_authTokenKey);
      if (token != null && JwtDecoder.isExpired(token)) {
        await clearToken();
        return null;
      }
      return token;
    } on Exception catch (e) {
      throw AppGlobalException("Error getting token. ${e.toString()}");
    }
  }

  // Remove token
  Future<void> clearToken() async {
    try {
      await prefs.remove(_authTokenKey);
    } on Exception catch (e) {
      throw AppGlobalException("Error clearing token. ${e.toString()}");
    }
  }
}
