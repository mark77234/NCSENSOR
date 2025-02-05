import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/storage_key.dart';

class PreferencesStorage {
  static late final SharedPreferencesWithCache _prefs;
  static bool _initialized = false;
  static final Set<String> _keys = {};

  PreferencesStorage._(); // 외부에서 인스턴스 생성 금지

  static Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: _keys,
      ),
    );
    _initialized = true;
  }

  static String? read(StorageKey key) {
    _checkIsAvailable(key.name);
    return _prefs.getString(key.name);
  }

  static Future<void> save(StorageKey key, String value) async {
    _checkIsAvailable(key.name);
    await _prefs.setString(key.name, value);
  }

  static void _checkIsAvailable(String key) {
    if (!_initialized) {
      throw StateError('init()을 먼저 호출해주세요.');
    }
    if (!_keys.contains(key)) {
      throw ArgumentError('허용되지 않은 키입니다: $key');
    }
  }
}
