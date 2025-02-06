import 'package:NCSensor/constants/storage_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> write(StorageKey key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  static Future<String?> read(StorageKey key) async {
    try {
      return await _storage.read(key: key.name);
    } catch (e) {
      print('보안 저장소 읽기 실패: $e');
      rethrow;
    }
  }

  static Future<void> delete(StorageKey key) async {
    try {
      await _storage.delete(key: key.name);
    } catch (e) {
      print('보안 저장소 삭제 실패: $e');
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print('보안 저장소 전체 삭제 실패: $e');
      rethrow;
    }
  }
}
