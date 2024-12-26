import '../data/token_store_datasource.dart';

class TokenStoreRepository {
  final TokenStoreDatasource _tokenStoreDataSource;

  TokenStoreRepository(this._tokenStoreDataSource);

  Future<void> saveToken(String token) async {
    await _tokenStoreDataSource.saveToken(token);
  }

  Future<String?> getToken() async {
    return await _tokenStoreDataSource.getToken();
  }

  Future<void> deleteToken() async {
    await _tokenStoreDataSource.clearToken();
  }
}
