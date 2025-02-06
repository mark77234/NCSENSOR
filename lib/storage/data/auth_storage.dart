import '../../constants/storage_key.dart';
import '../base/secure_storage.dart';

class AuthStorage {
  AuthStorage._();

  static String? _accessToken;
  static String? _refreshToken;

  static String? get accessToken => _accessToken;

  static String? get refreshToken => _refreshToken;

  static Future<void> init({bool clear = true}) async {
    if (clear) await clearToken();
    await _load();
  }

  static Future<void> _load() async {
    try {
      _accessToken = await SecureStorage.read(StorageKey.accessToken);
      _refreshToken = await SecureStorage.read(StorageKey.refreshToken);
    } catch (e) {
      print('토큰 로드 실패: $e');
      rethrow;
    }
  }

  static Future<void> saveTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null) {
      _accessToken = accessToken;
      await SecureStorage.write(StorageKey.accessToken, accessToken);
    }
    if (refreshToken != null) {
      _refreshToken = refreshToken;
      await SecureStorage.write(StorageKey.refreshToken, refreshToken);
    }
  }

  static Future<void> deleteToken(StorageKey key) async {
    await SecureStorage.delete(key);
    if (key == StorageKey.accessToken) {
      _accessToken = null;
    } else if (key == StorageKey.refreshToken) {
      _refreshToken = null;
    }
  }

  static Future<void> clearToken() async {
    await SecureStorage.delete(StorageKey.accessToken);
    await SecureStorage.delete(StorageKey.refreshToken);
    _accessToken = null;
    _refreshToken = null;
  }
}
